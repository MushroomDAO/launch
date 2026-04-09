// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

/**
 * @title SaleContractE2E
 * @notice End-to-end tests against the live Sepolia deployment of SaleContract v1.2.1.
 *
 * Run with:
 *   forge test --match-path test/SaleContractE2E.t.sol \
 *     --fork-url $SEPOLIA_RPC_URL2 -vvv
 *
 * All tests fork Sepolia at the latest block and interact with the real contract.
 * USDC and GToken are dealt via vm.deal / deal() on the forked state.
 */

import {Test, console} from "forge-std/Test.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface ISaleContract {
    function buyTokens(uint256 usdAmount, address paymentToken, uint256 minTokensOut) external;
    function version() external view returns (string memory);
    function currentMilestone() external view returns (uint256);
    function totalRevenue() external view returns (uint256);
    function totalTokensSold() external view returns (uint256);
    function userTotalSpent(address) external view returns (uint256);
    function availableInventory() external view returns (uint256);
    function getCurrentPriceUSD() external view returns (uint256);
    function getTokensForUSD(uint256 usdAmount) external view returns (uint256);
    function getMilestone(uint256 index) external view returns (uint256 priceUSD, uint256 revenueCap);
    function acceptedTokens(address) external view returns (bool);
    function whitelistRequired() external view returns (bool);
    function perPersonCapUSD() external view returns (uint256);
    function treasury() external view returns (address);
    function owner() external view returns (address);
    function pause() external;
    function unpause() external;
    function paused() external view returns (bool);
    function setWhitelistRequired(bool) external;
    function setWhitelisted(address[] calldata, bool) external;
    function isWhitelisted(address) external view returns (bool);
    function tryAdvanceMilestone() external;
    function advanceMilestone() external;
    function recoverToken(address) external;
    function setPerPersonCap(uint256) external;
    function VERSION() external view returns (uint256);
}

contract SaleContractE2ETest is Test {
    // ── Live contract addresses ──────────────────────────────────────────────
    ISaleContract constant SALE =
        ISaleContract(0x9cA2520D4Fa7e207211Ef5903E7918F06B3faDBA);
    IERC20 constant USDC =
        IERC20(0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238);
    IERC20 constant GTOKEN =
        IERC20(0xa592eC5a05C3909917d038AB01AAF7bcCF2D90f0);

    address constant OWNER = 0xEcAACb915f7D92e9916f449F7ad42BD0408733c9;
    address constant TREASURY = 0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114;

    // Test users (fresh addresses, no on-chain history)
    address alice   = makeAddr("alice");
    address bob     = makeAddr("bob");
    address carol   = makeAddr("carol");
    address dave    = makeAddr("dave");

    uint256 constant PRICE_M0 = 150_000;   // $0.15 (6 dec)
    uint256 constant PER_CAP  = 864_000_000; // $864

    // ── Helpers ──────────────────────────────────────────────────────────────

    /// Give `user` some USDC by overwriting their balance slot (Sepolia USDC)
    function _dealUsdc(address user, uint256 amount) internal {
        deal(address(USDC), user, amount);
    }

    /// Approve USDC and buy tokens
    function _buy(address user, uint256 usdAmount) internal {
        vm.startPrank(user);
        USDC.approve(address(SALE), usdAmount);
        SALE.buyTokens(usdAmount, address(USDC), 0);
        vm.stopPrank();
    }

    // ── Setup ────────────────────────────────────────────────────────────────

    function setUp() public {
        // Verify we're connected to the right contract
        assertEq(SALE.VERSION(), 10201, "wrong VERSION constant");
    }

    // =========================================================================
    //  E1 — Contract metadata
    // =========================================================================

    function test_E1_Version() public view {
        assertEq(SALE.version(), "1.2.1");
        assertEq(SALE.VERSION(), 10201);
        console.log("E1 PASS: version = 1.2.1");
    }

    function test_E1_InitialState() public view {
        assertEq(SALE.currentMilestone(), 0);
        assertEq(SALE.getCurrentPriceUSD(), PRICE_M0);
        assertEq(SALE.whitelistRequired(), false);
        assertEq(SALE.owner(), OWNER);
        assertEq(SALE.treasury(), TREASURY);
        assertTrue(SALE.acceptedTokens(address(USDC)));
        assertEq(SALE.perPersonCapUSD(), PER_CAP);
        console.log("E1 PASS: initial state correct");
    }

    function test_E1_Inventory() public view {
        uint256 inv = SALE.availableInventory();
        assertEq(inv, 4_200_000 * 1e18);
        console.log("E1 PASS: inventory =", inv / 1e18, "GT");
    }

    // =========================================================================
    //  E2 — Normal purchase
    // =========================================================================

    function test_E2_BuyTokens_Basic() public {
        uint256 usdAmount = 150 * 1e6; // $150
        uint256 expected = SALE.getTokensForUSD(usdAmount); // 1000 GT

        _dealUsdc(alice, usdAmount);
        uint256 gtBefore = GTOKEN.balanceOf(alice);
        uint256 invBefore = SALE.availableInventory();
        uint256 treasuryUsdcBefore = USDC.balanceOf(TREASURY);

        _buy(alice, usdAmount);

        assertEq(GTOKEN.balanceOf(alice) - gtBefore, expected);
        assertEq(invBefore - SALE.availableInventory(), expected);
        assertEq(USDC.balanceOf(TREASURY) - treasuryUsdcBefore, usdAmount);
        assertEq(SALE.totalRevenue(), usdAmount);
        assertEq(SALE.userTotalSpent(alice), usdAmount);
        console.log("E2 PASS: bought", expected / 1e18, "GT for $150");
    }

    function test_E2_BuyTokens_USDC_FlowsToTreasury() public {
        uint256 usd = 300 * 1e6;
        _dealUsdc(bob, usd);
        uint256 before = USDC.balanceOf(TREASURY);
        _buy(bob, usd);
        assertEq(USDC.balanceOf(TREASURY) - before, usd);
        console.log("E2 PASS: USDC flows directly to treasury");
    }

    function test_E2_MultiUser_IndependentCaps() public {
        uint256 usd = 200 * 1e6;
        _dealUsdc(alice, usd);
        _dealUsdc(bob, usd);
        _buy(alice, usd);
        _buy(bob, usd);
        assertEq(SALE.userTotalSpent(alice), usd);
        assertEq(SALE.userTotalSpent(bob), usd);
        assertEq(SALE.totalRevenue(), usd * 2);
        console.log("E2 PASS: two users buy independently, totalRevenue =", SALE.totalRevenue() / 1e6, "USD");
    }

    function test_E2_PriceCalculation() public view {
        // $0.15 → 1000 GT per $150
        assertEq(SALE.getTokensForUSD(150 * 1e6), 1000 * 1e18);
        // $0.15 → 1 GT per $0.15
        assertEq(SALE.getTokensForUSD(150_000), 1e18);
        console.log("E2 PASS: price calculation correct");
    }

    // =========================================================================
    //  E3 — Slippage guard
    // =========================================================================

    function test_E3_SlippageGuard_Passes() public {
        uint256 usd = 150 * 1e6;
        uint256 expected = SALE.getTokensForUSD(usd);
        _dealUsdc(alice, usd);
        vm.startPrank(alice);
        USDC.approve(address(SALE), usd);
        // minTokensOut = exactly expected → should pass
        SALE.buyTokens(usd, address(USDC), expected);
        vm.stopPrank();
        assertEq(GTOKEN.balanceOf(alice), expected);
        console.log("E3 PASS: slippage guard passes at exact expected");
    }

    function test_E3_SlippageGuard_Reverts() public {
        uint256 usd = 150 * 1e6;
        uint256 expected = SALE.getTokensForUSD(usd);
        _dealUsdc(alice, usd);
        vm.startPrank(alice);
        USDC.approve(address(SALE), usd);
        // minTokensOut = expected + 1 → must revert
        vm.expectRevert();
        SALE.buyTokens(usd, address(USDC), expected + 1);
        vm.stopPrank();
        console.log("E3 PASS: slippage reverts when minTokensOut > actual");
    }

    // =========================================================================
    //  E4 — Per-person cap
    // =========================================================================

    function test_E4_PerPersonCap_Enforced() public {
        _dealUsdc(alice, PER_CAP + 1e6);
        vm.startPrank(alice);
        USDC.approve(address(SALE), PER_CAP + 1e6);
        vm.expectRevert();
        SALE.buyTokens(PER_CAP + 1, address(USDC), 0);
        vm.stopPrank();
        console.log("E4 PASS: per-person cap enforced");
    }

    function test_E4_PerPersonCap_ExactAllowed() public {
        _dealUsdc(alice, PER_CAP);
        _buy(alice, PER_CAP);
        assertEq(SALE.userTotalSpent(alice), PER_CAP);
        console.log("E4 PASS: exact cap purchase succeeds");
    }

    function test_E4_PerPersonCap_TwoPurchases() public {
        uint256 half = PER_CAP / 2;
        _dealUsdc(alice, PER_CAP);
        _buy(alice, half);
        _buy(alice, half);
        assertEq(SALE.userTotalSpent(alice), PER_CAP);
        // Third buy over cap must revert
        _dealUsdc(alice, 1e6);
        vm.startPrank(alice);
        USDC.approve(address(SALE), 1e6);
        vm.expectRevert();
        SALE.buyTokens(1e6, address(USDC), 0);
        vm.stopPrank();
        console.log("E4 PASS: cumulative cap enforced across two purchases");
    }

    // =========================================================================
    //  E5 — Input validation
    // =========================================================================

    function test_E5_Revert_ZeroAmount() public {
        vm.prank(alice);
        vm.expectRevert();
        SALE.buyTokens(0, address(USDC), 0);
        console.log("E5 PASS: zero amount reverts");
    }

    function test_E5_Revert_UnacceptedToken() public {
        address fake = makeAddr("fakeToken");
        vm.prank(alice);
        vm.expectRevert();
        SALE.buyTokens(100e6, fake, 0);
        console.log("E5 PASS: unaccepted token reverts");
    }

    // =========================================================================
    //  E6 — Pause / unpause
    // =========================================================================

    function test_E6_Pause_BlocksBuys() public {
        vm.prank(OWNER);
        SALE.pause();
        assertTrue(SALE.paused());

        _dealUsdc(alice, 100e6);
        vm.startPrank(alice);
        USDC.approve(address(SALE), 100e6);
        vm.expectRevert();
        SALE.buyTokens(100e6, address(USDC), 0);
        vm.stopPrank();

        vm.prank(OWNER);
        SALE.unpause();
        assertFalse(SALE.paused());
        console.log("E6 PASS: pause blocks buys, unpause restores");
    }

    // =========================================================================
    //  E7 — Whitelist
    // =========================================================================

    function test_E7_Whitelist_BlocksNonWhitelisted() public {
        vm.prank(OWNER);
        SALE.setWhitelistRequired(true);

        _dealUsdc(alice, 100e6);
        vm.startPrank(alice);
        USDC.approve(address(SALE), 100e6);
        vm.expectRevert();
        SALE.buyTokens(100e6, address(USDC), 0);
        vm.stopPrank();

        // Whitelist alice, then she can buy
        address[] memory list = new address[](1);
        list[0] = alice;
        vm.prank(OWNER);
        SALE.setWhitelisted(list, true);
        assertTrue(SALE.isWhitelisted(alice));
        _buy(alice, 100e6);
        assertGt(GTOKEN.balanceOf(alice), 0);

        // Re-disable whitelist
        vm.prank(OWNER);
        SALE.setWhitelistRequired(false);
        console.log("E7 PASS: whitelist blocks non-whitelisted, allows whitelisted");
    }

    // =========================================================================
    //  E8 — Auto-advance milestone
    // =========================================================================

    function test_E8_AutoAdvance_TriggeredByBuy() public {
        // Milestone 1 revenueCap = $1,200,000 (1_200_000_000 in 6 dec)
        // Fund many buyers to cross the cap
        uint256 capM1 = 1_200_000_000;
        uint256 perBuy = PER_CAP; // $864 per buyer
        uint256 needed = (capM1 / perBuy) + 2; // enough buyers

        for (uint256 i = 0; i < needed; i++) {
            address buyer = address(uint160(0xbeef + i));
            _dealUsdc(buyer, perBuy);
            _buy(buyer, perBuy);
            if (SALE.currentMilestone() == 1) break;
        }

        assertEq(SALE.currentMilestone(), 1, "should have auto-advanced to M1");
        assertEq(SALE.getCurrentPriceUSD(), 168_000, "price should be M1");
        console.log("E8 PASS: milestone auto-advanced to 1, price now $0.168");
    }

    function test_E8_TryAdvanceMilestone_PublicCallable() public {
        // Anyone can call tryAdvanceMilestone (no-op if cap not reached)
        uint256 mBefore = SALE.currentMilestone();
        SALE.tryAdvanceMilestone(); // should not revert even if cap not met
        assertEq(SALE.currentMilestone(), mBefore, "no advance if cap not met");
        console.log("E8 PASS: tryAdvanceMilestone callable by anyone, no-op if cap not met");
    }

    // =========================================================================
    //  E9 — recoverToken (owner only)
    // =========================================================================

    function test_E9_RecoverToken_NonOwnerReverts() public {
        vm.prank(alice);
        vm.expectRevert();
        SALE.recoverToken(address(USDC));
        console.log("E9 PASS: recoverToken reverts for non-owner");
    }

    // =========================================================================
    //  E10 — getMilestone view
    // =========================================================================

    function test_E10_GetMilestone_AllSix() public view {
        uint256[6] memory prices  = [uint256(150_000), 168_000, 188_160, 210_739, 236_028, 264_351];
        uint256[6] memory caps    = [uint256(0), 1_200_000_000, 4_800_000_000, 12_800_000_000, 49_400_000_000, 135_800_000_000];
        for (uint256 i = 0; i < 6; i++) {
            (uint256 p, uint256 c) = SALE.getMilestone(i);
            assertEq(p, prices[i], "price mismatch");
            assertEq(c, caps[i],   "cap mismatch");
        }
        console.log("E10 PASS: all 6 milestones verified");
    }
}
