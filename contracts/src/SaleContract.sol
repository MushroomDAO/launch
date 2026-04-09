// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {IERC20Metadata} from "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {SafeERC20} from "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {Pausable} from "openzeppelin-contracts/contracts/utils/Pausable.sol";

/**
 * @title SaleContract
 * @author Mycelium Protocol
 * @notice Revenue-Based Milestone Sale for GToken.
 *
 * Version scheme: MAJOR.MINOR.PATCH (each segment 0-99)
 *   MAJOR: breaking changes to sale logic or milestone structure
 *   MINOR: new features (new payment token, whitelist mode, cap changes)
 *   PATCH: bug fixes, parameter tweaks, doc updates
 *
 * Current: 1.2.1
 *   1 = revenue-based milestone architecture
 *   2 = security: CEI ordering, zero-token guard, slippage param, 6-decimal token enforcement,
 *       auto-advance milestone (_advanceIfNeeded), public tryAdvanceMilestone()
 *   1 = fix: TokensPurchased event now emits actual price/milestone paid (pre-advance)
 *
 * The sale is divided into 6 milestones (0-5). The price increases at each milestone
 * and the owner can advance the milestone once totalRevenue reaches the milestone's
 * revenueCap. This design aligns price increases with actual traction.
 *
 * All USD amounts use 6 decimals (USDC/USDT precision).
 * GToken uses 18 decimals.
 */
contract SaleContract is Ownable, ReentrancyGuard, Pausable {

    // =============================================================
    //                         VERSION
    // =============================================================

    /// @notice Semantic version: MAJOR * 10000 + MINOR * 100 + PATCH
    /// e.g. 1.0.0 = 10000, 1.2.3 = 10203, 2.0.0 = 20000
    uint256 public constant VERSION = 10201; // 1.2.1

    /// @notice Human-readable version string
    function version() external pure returns (string memory) {
        return "1.2.1";
    }
    using SafeERC20 for IERC20;

    // =============================================================
    //                         ERRORS
    // =============================================================

    error ZeroAmount();
    error ZeroTokensOut();
    error TokenNotAccepted(address token);
    error InvalidTokenDecimals(address token, uint8 decimals);
    error SlippageExceeded(uint256 got, uint256 minExpected);
    error ExceedsPerPersonCap(uint256 requested, uint256 remaining);
    error InsufficientInventory(uint256 requested, uint256 available);
    error NotWhitelisted(address user);
    error MilestoneNotReached(uint256 currentRevenue, uint256 required);
    error AlreadyAtMaxMilestone();
    error ZeroAddress();

    // =============================================================
    //                         MILESTONE DATA
    // =============================================================

    struct Milestone {
        uint256 priceUSD;      // Price of 1 GToken in USD (6 decimals)
        uint256 revenueCap;    // Cumulative USD revenue required to reach this milestone (6 decimals)
    }

    /// @dev Milestone 0 is the initial state (revenueCap = 0 means always reachable at start)
    Milestone[6] private _milestones;

    // =============================================================
    //                           STATE
    // =============================================================

    /// @notice The GToken being sold
    IERC20 public immutable gToken;

    /// @notice Address that receives payment proceeds
    address public treasury;

    /// @notice Current milestone index (0-5)
    uint256 public currentMilestone;

    /// @notice Cumulative USD revenue received (6 decimals)
    uint256 public totalRevenue;

    /// @notice Cumulative GTokens sold (18 decimals)
    uint256 public totalTokensSold;

    /// @notice Per-user cumulative USD spent (6 decimals)
    mapping(address => uint256) public userTotalSpent;

    /// @notice Per-person purchase cap in USD (6 decimals), default $864
    uint256 public perPersonCapUSD = 864_000_000;

    /// @notice Whether whitelist gating is active
    bool public whitelistRequired;

    /// @notice Whitelisted buyers
    mapping(address => bool) public isWhitelisted;

    /// @notice Accepted payment tokens (USDC, USDT, etc.)
    mapping(address => bool) public acceptedTokens;

    // =============================================================
    //                          EVENTS
    // =============================================================

    event TokensPurchased(
        address indexed buyer,
        address indexed paymentToken,
        uint256 usdAmount,
        uint256 gTokenAmount,
        uint256 priceUSD,
        uint256 milestone
    );
    event MilestoneAdvanced(uint256 indexed newMilestone, uint256 newPriceUSD);
    event PaymentTokenSet(address indexed token, bool accepted);
    event TreasuryUpdated(address indexed newTreasury);
    event WhitelistRequiredUpdated(bool required);
    event WhitelistUpdated(address indexed user, bool status);
    event PerPersonCapUpdated(uint256 newCapUSD);

    // =============================================================
    //                        CONSTRUCTOR
    // =============================================================

    /**
     * @param gTokenAddress Address of the GToken ERC20
     * @param _treasury Address that receives payment proceeds
     * @param _initialOwner Owner of this contract
     */
    constructor(address gTokenAddress, address _treasury, address _initialOwner) Ownable(_initialOwner) {
        if (gTokenAddress == address(0)) revert ZeroAddress();
        if (_treasury == address(0)) revert ZeroAddress();

        gToken = IERC20(gTokenAddress);
        treasury = _treasury;

        // Initialize milestone data
        // Milestone 0: initial state — already at start, no revenue needed
        _milestones[0] = Milestone({priceUSD: 150_000, revenueCap: 0});
        // Milestone 1: Phase A-1
        _milestones[1] = Milestone({priceUSD: 168_000, revenueCap: 1_200_000_000});
        // Milestone 2: Phase A-2
        _milestones[2] = Milestone({priceUSD: 188_160, revenueCap: 4_800_000_000});
        // Milestone 3: Phase A-3
        _milestones[3] = Milestone({priceUSD: 210_739, revenueCap: 12_800_000_000});
        // Milestone 4: Phase B
        _milestones[4] = Milestone({priceUSD: 236_028, revenueCap: 49_400_000_000});
        // Milestone 5: Phase C
        _milestones[5] = Milestone({priceUSD: 264_351, revenueCap: 135_800_000_000});
    }

    // =============================================================
    //                        VIEW FUNCTIONS
    // =============================================================

    /**
     * @notice Get the current price of 1 GToken in USD (6 decimals).
     */
    function getCurrentPriceUSD() public view returns (uint256) {
        return _milestones[currentMilestone].priceUSD;
    }

    /**
     * @notice Calculate how many GTokens (18 decimals) a given USD amount buys
     *         at the current milestone price.
     * @param usdAmount Amount in USD (6 decimals)
     */
    function getTokensForUSD(uint256 usdAmount) public view returns (uint256) {
        uint256 price = getCurrentPriceUSD();
        // gTokenAmount = usdAmount * 1e18 / price
        return (usdAmount * 1e18) / price;
    }

    /**
     * @notice Get milestone details.
     * @param index Milestone index (0-5)
     */
    function getMilestone(uint256 index) external view returns (uint256 priceUSD, uint256 revenueCap) {
        Milestone memory m = _milestones[index];
        return (m.priceUSD, m.revenueCap);
    }

    /**
     * @notice How many GTokens are currently available in this contract.
     */
    function availableInventory() public view returns (uint256) {
        return gToken.balanceOf(address(this));
    }

    // =============================================================
    //                       PURCHASE LOGIC
    // =============================================================

    /**
     * @notice Purchase GTokens by paying with an accepted stablecoin.
     * @param usdAmount USD amount to spend (6 decimals, must match payment token decimals)
     * @param paymentToken Accepted ERC20 stablecoin address (must be 6-decimal USD-pegged)
     * @param minTokensOut Minimum GTokens to receive (slippage guard); pass 0 to skip
     */
    function buyTokens(uint256 usdAmount, address paymentToken, uint256 minTokensOut)
        external
        nonReentrant
        whenNotPaused
    {
        // 1. Whitelist check
        if (whitelistRequired && !isWhitelisted[msg.sender]) {
            revert NotWhitelisted(msg.sender);
        }

        // 2. Basic validation
        if (usdAmount == 0) revert ZeroAmount();
        if (!acceptedTokens[paymentToken]) revert TokenNotAccepted(paymentToken);

        // 3. Per-person cap check
        uint256 spent = userTotalSpent[msg.sender];
        if (spent + usdAmount > perPersonCapUSD) {
            revert ExceedsPerPersonCap(usdAmount, perPersonCapUSD - spent);
        }

        // 4. Calculate GToken amount
        uint256 gTokenAmount = getTokensForUSD(usdAmount);
        if (gTokenAmount == 0) revert ZeroTokensOut();

        // 5. Slippage guard
        if (minTokensOut > 0 && gTokenAmount < minTokensOut) {
            revert SlippageExceeded(gTokenAmount, minTokensOut);
        }

        // 6. Inventory check
        uint256 inventory = availableInventory();
        if (gTokenAmount > inventory) revert InsufficientInventory(gTokenAmount, inventory);

        // 7. Capture the price/milestone used for this buy (before possible auto-advance)
        uint256 pricePaid = getCurrentPriceUSD();
        uint256 milestonePaid = currentMilestone;

        // 8. Update state BEFORE external calls (CEI pattern)
        totalRevenue += usdAmount;
        totalTokensSold += gTokenAmount;
        userTotalSpent[msg.sender] = spent + usdAmount;

        // 9. Auto-advance milestone if revenue cap crossed (for next buyers)
        _advanceIfNeeded();

        // 10. Transfer payment to treasury
        IERC20(paymentToken).safeTransferFrom(msg.sender, treasury, usdAmount);

        // 11. Transfer GTokens to buyer
        gToken.safeTransfer(msg.sender, gTokenAmount);

        emit TokensPurchased(
            msg.sender,
            paymentToken,
            usdAmount,
            gTokenAmount,
            pricePaid,
            milestonePaid
        );
    }

    // =============================================================
    //                    MILESTONE ADVANCEMENT
    // =============================================================

    /**
     * @notice Internal: auto-advance milestone(s) if totalRevenue crossed their caps.
     * @dev Called after state update in buyTokens. Bounded loop (max 5 iterations).
     */
    function _advanceIfNeeded() internal {
        while (currentMilestone < 5) {
            uint256 next = currentMilestone + 1;
            if (totalRevenue < _milestones[next].revenueCap) break;
            currentMilestone = next;
            emit MilestoneAdvanced(next, _milestones[next].priceUSD);
        }
    }

    /**
     * @notice Anyone can trigger milestone advancement once revenueCap is reached.
     * @dev Prevents owner from delaying price increases. Anyone can call.
     */
    function tryAdvanceMilestone() external {
        _advanceIfNeeded();
    }

    // =============================================================
    //                       ADMIN FUNCTIONS
    // =============================================================

    /**
     * @notice Advance to the next milestone if totalRevenue has reached its revenueCap.
     * @dev Only callable by owner. Validates that cumulative revenue is sufficient.
     */
    function advanceMilestone() external onlyOwner {
        if (currentMilestone >= 5) revert AlreadyAtMaxMilestone();

        uint256 nextMilestone = currentMilestone + 1;
        uint256 required = _milestones[nextMilestone].revenueCap;

        if (totalRevenue < required) {
            revert MilestoneNotReached(totalRevenue, required);
        }

        currentMilestone = nextMilestone;
        emit MilestoneAdvanced(nextMilestone, _milestones[nextMilestone].priceUSD);
    }

    /**
     * @notice Set whether a token is accepted as payment.
     * @dev Only 6-decimal USD-pegged tokens (USDC, USDT) are permitted to ensure
     *      correct USD accounting. Tokens with any other decimal count are rejected.
     * @param token ERC20 token address
     * @param accepted True to accept, false to reject
     */
    function setPaymentToken(address token, bool accepted) external onlyOwner {
        if (token == address(0)) revert ZeroAddress();
        if (accepted) {
            uint8 decimals = IERC20Metadata(token).decimals();
            if (decimals != 6) revert InvalidTokenDecimals(token, decimals);
        }
        acceptedTokens[token] = accepted;
        emit PaymentTokenSet(token, accepted);
    }

    /**
     * @notice Enable or disable whitelist requirement.
     */
    function setWhitelistRequired(bool required) external onlyOwner {
        whitelistRequired = required;
        emit WhitelistRequiredUpdated(required);
    }

    /**
     * @notice Batch-set whitelist status for users.
     * @param users Array of addresses
     * @param status True to whitelist, false to remove
     */
    function setWhitelisted(address[] calldata users, bool status) external onlyOwner {
        for (uint256 i = 0; i < users.length; i++) {
            isWhitelisted[users[i]] = status;
            emit WhitelistUpdated(users[i], status);
        }
    }

    /**
     * @notice Update the per-person purchase cap.
     * @param capUSD New cap in USD (6 decimals)
     */
    function setPerPersonCap(uint256 capUSD) external onlyOwner {
        if (capUSD == 0) revert ZeroAmount();
        perPersonCapUSD = capUSD;
        emit PerPersonCapUpdated(capUSD);
    }

    /**
     * @notice Update the treasury address.
     * @param newTreasury New treasury address
     */
    function setTreasury(address newTreasury) external onlyOwner {
        if (newTreasury == address(0)) revert ZeroAddress();
        treasury = newTreasury;
        emit TreasuryUpdated(newTreasury);
    }

    /**
     * @notice Recover any ERC20 token accidentally sent to this contract.
     * @dev Transfers the full balance of the token to treasury.
     * @param token ERC20 token to recover
     */
    function recoverToken(address token) external onlyOwner {
        if (token == address(0)) revert ZeroAddress();
        uint256 balance = IERC20(token).balanceOf(address(this));
        if (balance > 0) {
            IERC20(token).safeTransfer(treasury, balance);
        }
    }

    /**
     * @notice Pause the sale.
     */
    function pause() external onlyOwner {
        _pause();
    }

    /**
     * @notice Unpause the sale.
     */
    function unpause() external onlyOwner {
        _unpause();
    }
}
