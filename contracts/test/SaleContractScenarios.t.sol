// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {SaleContract} from "../src/SaleContract.sol";
import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {Pausable} from "openzeppelin-contracts/contracts/utils/Pausable.sol";

// =============================================================
//                       MOCK TOKENS
// =============================================================

contract MockGToken is ERC20 {
    constructor() ERC20("GToken", "GT") {}

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}

contract MockUSDC is ERC20 {
    constructor() ERC20("USD Coin", "USDC") {}

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}

contract MockUSDT is ERC20 {
    constructor() ERC20("Tether USD", "USDT") {}

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}

// =============================================================
//                    SCENARIO TEST SUITE
// =============================================================

contract SaleContractScenariosTest is Test {
    // --- Contracts ---
    SaleContract public sale;
    MockGToken public gToken;
    MockUSDC public usdc;
    MockUSDT public usdt;

    // --- Addresses ---
    address public owner = makeAddr("owner");
    address public treasury = makeAddr("treasury");
    address public earlyBacker = makeAddr("earlyBacker");
    address public communityOp = makeAddr("communityOp");
    address public builder = makeAddr("builder");
    address public whale = makeAddr("whale");
    address public user1 = makeAddr("user1");
    address public user2 = makeAddr("user2");
    address public user3 = makeAddr("user3");
    address public user4 = makeAddr("user4");
    address public user5 = makeAddr("user5");
    address public user6 = makeAddr("user6");

    // --- Constants from contract ---
    uint256 constant PRICE_M0 = 150_000;
    uint256 constant PRICE_M1 = 168_000;
    uint256 constant PRICE_M2 = 188_160;
    uint256 constant PRICE_M3 = 210_739;
    uint256 constant REVENUE_CAP_M1 = 1_200_000_000;
    uint256 constant REVENUE_CAP_M2 = 4_800_000_000;
    uint256 constant REVENUE_CAP_M3 = 12_800_000_000;
    uint256 constant PER_PERSON_CAP = 864_000_000;
    uint256 constant INVENTORY = 5_000_000 * 1e18;

    // --- Storage slots (verified via forge inspect) ---
    uint256 constant SLOT_CURRENT_MILESTONE = 14;
    uint256 constant SLOT_TOTAL_REVENUE = 15;

    // =============================================================
    //                          SETUP
    // =============================================================

    function setUp() public {
        gToken = new MockGToken();
        usdc = new MockUSDC();
        usdt = new MockUSDT();

        vm.startPrank(owner);
        sale = new SaleContract(address(gToken), treasury, owner);
        sale.setPaymentToken(address(usdc), true);
        vm.stopPrank();

        gToken.mint(address(sale), INVENTORY);

        address[12] memory users = [earlyBacker, communityOp, builder, whale,
                                     user1, user2, user3, user4, user5, user6,
                                     address(0), address(0)];
        for (uint256 i = 0; i < 10; i++) {
            usdc.mint(users[i], 10_000 * 1e6);
            usdt.mint(users[i], 10_000 * 1e6);
        }
    }

    // =============================================================
    //           HELPERS
    // =============================================================

    function _buyUsdc(address buyer, uint256 usdAmount) internal {
        vm.startPrank(buyer);
        usdc.approve(address(sale), usdAmount);
        sale.buyTokens(usdAmount, address(usdc), 0);
        vm.stopPrank();
    }

    function _buyUsdt(address buyer, uint256 usdAmount) internal {
        vm.startPrank(buyer);
        usdt.approve(address(sale), usdAmount);
        sale.buyTokens(usdAmount, address(usdt), 0);
        vm.stopPrank();
    }

    function _setTotalRevenue(uint256 amount) internal {
        vm.store(address(sale), bytes32(SLOT_TOTAL_REVENUE), bytes32(amount));
    }

    function _setCurrentMilestone(uint256 index) internal {
        vm.store(address(sale), bytes32(SLOT_CURRENT_MILESTONE), bytes32(index));
    }

    // =============================================================
    //           GROUP A — NORMAL PURCHASE PATHS
    // =============================================================

    function test_A1_EarlyBackerMinBuy() public {
        uint256 usdAmount = 12 * 1e6;
        uint256 expectedGTokens = (usdAmount * 1e18) / PRICE_M0;

        _buyUsdc(earlyBacker, usdAmount);

        assertEq(gToken.balanceOf(earlyBacker), expectedGTokens, "A1: gToken balance mismatch");
        assertEq(sale.totalRevenue(), usdAmount, "A1: totalRevenue mismatch");
        assertEq(sale.userTotalSpent(earlyBacker), usdAmount, "A1: userTotalSpent mismatch");
        console.log("A1 PASS: earlyBacker got gTokens for $12");
    }

    function test_A2_CommunityOpBuy() public {
        uint256 usdAmount = 80 * 1e6;
        uint256 expectedGTokens = (usdAmount * 1e18) / PRICE_M0;

        _buyUsdc(communityOp, usdAmount);

        assertEq(gToken.balanceOf(communityOp), expectedGTokens, "A2: gToken balance mismatch");
        assertEq(sale.totalRevenue(), usdAmount, "A2: totalRevenue mismatch");
        assertEq(sale.userTotalSpent(communityOp), usdAmount, "A2: userTotalSpent mismatch");
        console.log("A2 PASS: communityOp bought $80 successfully");
    }

    function test_A3_BuilderBuy() public {
        uint256 usdAmount = 336 * 1e6;
        uint256 expectedGTokens = (usdAmount * 1e18) / PRICE_M0;

        _buyUsdc(builder, usdAmount);

        assertEq(gToken.balanceOf(builder), expectedGTokens, "A3: gToken balance mismatch");
        assertEq(sale.totalRevenue(), usdAmount, "A3: totalRevenue mismatch");
        console.log("A3 PASS: builder bought $336 successfully");
    }

    function test_A4_WhaleBuyAtCap() public {
        uint256 capAmount = PER_PERSON_CAP;
        uint256 expectedGTokens = (capAmount * 1e18) / PRICE_M0;

        _buyUsdc(whale, capAmount);

        assertEq(gToken.balanceOf(whale), expectedGTokens, "A4: gToken balance mismatch");
        assertEq(sale.userTotalSpent(whale), capAmount, "A4: userTotalSpent mismatch");

        vm.startPrank(whale);
        usdc.approve(address(sale), 1 * 1e6);
        vm.expectRevert(
            abi.encodeWithSelector(SaleContract.ExceedsPerPersonCap.selector, 1 * 1e6, 0)
        );
        sale.buyTokens(1 * 1e6, address(usdc), 0);
        vm.stopPrank();

        console.log("A4 PASS: whale capped at $864, extra $1 correctly reverted");
    }

    // =============================================================
    //           GROUP B — MULTI-BUY & CROSS-MILESTONE
    // =============================================================

    function test_B1_BatchBuyReachCap() public {
        _buyUsdc(user1, 400 * 1e6);
        assertEq(sale.userTotalSpent(user1), 400 * 1e6, "B1: after 1st buy");

        _buyUsdc(user1, 400 * 1e6);
        assertEq(sale.userTotalSpent(user1), 800 * 1e6, "B1: after 2nd buy");

        // $100 would exceed cap ($800 + $100 = $900 > $864)
        vm.startPrank(user1);
        usdc.approve(address(sale), 100 * 1e6);
        vm.expectRevert(
            abi.encodeWithSelector(SaleContract.ExceedsPerPersonCap.selector, 100 * 1e6, 64 * 1e6)
        );
        sale.buyTokens(100 * 1e6, address(usdc), 0);
        vm.stopPrank();

        // Corrected: $64 → exactly $864
        _buyUsdc(user1, 64 * 1e6);
        assertEq(sale.userTotalSpent(user1), 864 * 1e6, "B1: total at cap");

        console.log("B1 PASS: $400+$400+$64=$864, $100 correctly blocked");
    }

    function test_B2_CrossMilestonePurchase() public {
        uint256 buyAmount = 100 * 1e6;

        // Milestone 0 purchase
        _buyUsdc(user2, buyAmount);
        uint256 gTokenAmount1 = gToken.balanceOf(user2);

        // Force revenue to M1 cap and advance
        _setTotalRevenue(REVENUE_CAP_M1);
        vm.prank(owner);
        sale.advanceMilestone();
        assertEq(sale.currentMilestone(), 1, "B2: should be at milestone 1");
        assertEq(sale.getCurrentPriceUSD(), PRICE_M1, "B2: M1 price mismatch");

        // Milestone 1 purchase (user2 has $764 remaining in cap)
        _buyUsdc(user2, buyAmount);
        uint256 gTokenAmount2 = gToken.balanceOf(user2) - gTokenAmount1;

        assertLt(gTokenAmount2, gTokenAmount1, "B2: M1 tokens should be fewer (price increased)");
        console.log("B2 PASS: M0 tokens > M1 tokens for same $100 spend");
    }

    function test_B3_SmallAccumulativeBuys() public {
        uint256 singleBuy = 100 * 1e6;
        uint256 totalGTokens = 0;

        for (uint256 i = 0; i < 5; i++) {
            uint256 prevRevenue = sale.totalRevenue();
            _buyUsdc(user3, singleBuy);
            assertEq(sale.totalRevenue(), prevRevenue + singleBuy, "B3: revenue not incremented correctly");
            totalGTokens += (singleBuy * 1e18) / PRICE_M0;
        }

        assertEq(sale.userTotalSpent(user3), 500 * 1e6, "B3: userTotalSpent should be $500");
        assertEq(sale.totalRevenue(), 500 * 1e6, "B3: totalRevenue should be $500");
        assertEq(gToken.balanceOf(user3), totalGTokens, "B3: gToken balance mismatch");
        console.log("B3 PASS: 5x$100 accumulated correctly to $500");
    }

    // =============================================================
    //           GROUP C — MILESTONE ADVANCEMENT
    // =============================================================

    function test_C1_NormalMilestoneAdvance() public {
        address[10] memory buyers = [earlyBacker, communityOp, builder, whale,
                                      user1, user2, user3, user4, user5, user6];
        for (uint256 i = 0; i < buyers.length; i++) {
            _buyUsdc(buyers[i], 130 * 1e6);
        }

        assertGe(sale.totalRevenue(), REVENUE_CAP_M1, "C1: revenue should be >= cap");

        // Auto-advance fired inside buyTokens when cap was crossed — no owner call needed
        assertEq(sale.currentMilestone(), 1, "C1: should be at milestone 1");
        assertEq(sale.getCurrentPriceUSD(), PRICE_M1, "C1: price should be M1");
        console.log("C1 PASS: 10 users x $130 = $1300 > $1200, auto-advanced to milestone 1");
    }

    function test_C2_AdvanceMilestoneRevertInsufficientRevenue() public {
        _buyUsdc(user1, 500 * 1e6);

        vm.prank(owner);
        vm.expectRevert(
            abi.encodeWithSelector(
                SaleContract.MilestoneNotReached.selector,
                500 * 1e6,
                REVENUE_CAP_M1
            )
        );
        sale.advanceMilestone();
        console.log("C2 PASS: $500 revenue correctly blocked milestone advance (need $1200)");
    }

    function test_C3_ConsecutiveMilestoneAdvances() public {
        uint256[3] memory caps = [REVENUE_CAP_M1, REVENUE_CAP_M2, REVENUE_CAP_M3];
        uint256[3] memory expectedPrices = [PRICE_M1, PRICE_M2, PRICE_M3];

        assertEq(sale.getCurrentPriceUSD(), PRICE_M0, "C3: initial price should be M0");

        for (uint256 i = 0; i < 3; i++) {
            _setTotalRevenue(caps[i]);
            vm.prank(owner);
            sale.advanceMilestone();

            assertEq(sale.currentMilestone(), i + 1, "C3: milestone index mismatch");
            assertEq(sale.getCurrentPriceUSD(), expectedPrices[i], "C3: price mismatch");
            console.log("C3: advanced to milestone", i + 1);
        }

        console.log("C3 PASS: 3 consecutive milestones advanced with correct prices");
    }

    function test_C4_AdvanceBeyondMaxMilestone() public {
        _setCurrentMilestone(5);
        assertEq(sale.currentMilestone(), 5, "C4: should be at milestone 5");

        vm.prank(owner);
        vm.expectRevert(SaleContract.AlreadyAtMaxMilestone.selector);
        sale.advanceMilestone();
        console.log("C4 PASS: AlreadyAtMaxMilestone correctly triggered at milestone 5");
    }

    // =============================================================
    //           GROUP D — MULTI-USER CONCURRENT
    // =============================================================

    function test_D1_TenUsersConcurrentBuy() public {
        address[10] memory buyers = [earlyBacker, communityOp, builder, whale,
                                      user1, user2, user3, user4, user5, user6];
        uint256 eachAmount = 80 * 1e6;
        uint256 expectedGTokenEach = (eachAmount * 1e18) / PRICE_M0;

        for (uint256 i = 0; i < 10; i++) {
            _buyUsdc(buyers[i], eachAmount);
        }

        assertEq(sale.totalRevenue(), eachAmount * 10, "D1: totalRevenue mismatch");
        for (uint256 i = 0; i < 10; i++) {
            assertEq(gToken.balanceOf(buyers[i]), expectedGTokenEach, "D1: gToken balance mismatch");
        }
        console.log("D1 PASS: 10 users x $80 = $800 total, all balances correct");
    }

    function test_D2_WhaleProtection() public {
        vm.startPrank(whale);
        usdc.approve(address(sale), 5000 * 1e6);
        vm.expectRevert(
            abi.encodeWithSelector(
                SaleContract.ExceedsPerPersonCap.selector,
                5000 * 1e6,
                PER_PERSON_CAP
            )
        );
        sale.buyTokens(5000 * 1e6, address(usdc), 0);
        vm.stopPrank();

        address[5] memory regularUsers = [user1, user2, user3, user4, user5];
        for (uint256 i = 0; i < 5; i++) {
            _buyUsdc(regularUsers[i], 172 * 1e6);
            assertGt(gToken.balanceOf(regularUsers[i]), 0, "D2: user should have gTokens");
        }

        assertEq(sale.totalRevenue(), 172 * 1e6 * 5, "D2: totalRevenue mismatch");
        console.log("D2 PASS: $5000 whale blocked, 5 regular users x $172 succeeded");
    }

    function test_D3_DualTokenPayment() public {
        vm.prank(owner);
        sale.setPaymentToken(address(usdt), true);
        assertTrue(sale.acceptedTokens(address(usdt)), "D3: USDT should be accepted");

        _buyUsdc(user4, 100 * 1e6);
        _buyUsdt(user5, 100 * 1e6);

        assertEq(sale.totalRevenue(), 200 * 1e6, "D3: totalRevenue should be $200");
        assertGt(gToken.balanceOf(user4), 0, "D3: user4 should have gTokens");
        assertGt(gToken.balanceOf(user5), 0, "D3: user5 should have gTokens");
        assertEq(gToken.balanceOf(user4), gToken.balanceOf(user5), "D3: equal USD = equal gTokens");
        console.log("D3 PASS: $100 USDC + $100 USDT = $200 total revenue");
    }

    // =============================================================
    //           GROUP E — WHITELIST
    // =============================================================

    function test_E1_WhitelistRequired_UnauthorizedRevert() public {
        vm.prank(owner);
        sale.setWhitelistRequired(true);

        vm.startPrank(user1);
        usdc.approve(address(sale), 50 * 1e6);
        vm.expectRevert(
            abi.encodeWithSelector(SaleContract.NotWhitelisted.selector, user1)
        );
        sale.buyTokens(50 * 1e6, address(usdc), 0);
        vm.stopPrank();
        console.log("E1 PASS: non-whitelisted user correctly blocked");
    }

    function test_E2_WhitelistedUserCanBuy() public {
        vm.prank(owner);
        sale.setWhitelistRequired(true);

        address[] memory wl = new address[](1);
        wl[0] = user1;
        vm.prank(owner);
        sale.setWhitelisted(wl, true);

        assertTrue(sale.isWhitelisted(user1), "E2: user1 should be whitelisted");

        _buyUsdc(user1, 50 * 1e6);

        assertGt(gToken.balanceOf(user1), 0, "E2: user1 should have gTokens");
        assertEq(sale.userTotalSpent(user1), 50 * 1e6, "E2: userTotalSpent mismatch");
        console.log("E2 PASS: whitelisted user bought $50 successfully");
    }

    function test_E3_WhitelistDisabled_AnyoneCanBuy() public {
        vm.prank(owner);
        sale.setWhitelistRequired(true);

        vm.prank(owner);
        sale.setWhitelistRequired(false);

        assertFalse(sale.whitelistRequired(), "E3: whitelist should be disabled");

        _buyUsdc(user6, 80 * 1e6);

        assertGt(gToken.balanceOf(user6), 0, "E3: user6 should have gTokens");
        console.log("E3 PASS: whitelist disabled, any user can purchase");
    }

    // =============================================================
    //           GROUP F — ADMIN OPERATIONS
    // =============================================================

    function test_F1_PauseUnpause() public {
        vm.prank(owner);
        sale.pause();

        vm.startPrank(user1);
        usdc.approve(address(sale), 100 * 1e6);
        vm.expectRevert(Pausable.EnforcedPause.selector);
        sale.buyTokens(100 * 1e6, address(usdc), 0);
        vm.stopPrank();

        vm.prank(owner);
        sale.unpause();

        _buyUsdc(user1, 100 * 1e6);
        assertGt(gToken.balanceOf(user1), 0, "F1: should have gTokens after unpause");
        console.log("F1 PASS: pause blocked buy, unpause allowed buy");
    }

    function test_F2_TreasuryChange() public {
        address newTreasury = makeAddr("newTreasury");

        vm.prank(owner);
        sale.setTreasury(newTreasury);
        assertEq(sale.treasury(), newTreasury, "F2: treasury not updated");

        _buyUsdc(user1, 50 * 1e6);

        assertEq(usdc.balanceOf(newTreasury), 50 * 1e6, "F2: newTreasury should receive $50");
        assertEq(usdc.balanceOf(treasury), 0, "F2: old treasury should have 0");
        console.log("F2 PASS: treasury updated, $50 USDC flowed to newTreasury");
    }

    function test_F3_AdjustPerPersonCap() public {
        _buyUsdc(user1, 800 * 1e6);
        assertEq(sale.userTotalSpent(user1), 800 * 1e6, "F3: after $800");

        // $200 should fail ($64 remaining in $864 cap)
        vm.startPrank(user1);
        usdc.approve(address(sale), 200 * 1e6);
        vm.expectRevert(
            abi.encodeWithSelector(SaleContract.ExceedsPerPersonCap.selector, 200 * 1e6, 64 * 1e6)
        );
        sale.buyTokens(200 * 1e6, address(usdc), 0);
        vm.stopPrank();

        // Owner raises cap to $1000
        vm.prank(owner);
        sale.setPerPersonCap(1000 * 1e6);
        assertEq(sale.perPersonCapUSD(), 1000 * 1e6, "F3: cap should be $1000");

        // Now $200 succeeds (total = $1000)
        _buyUsdc(user1, 200 * 1e6);
        assertEq(sale.userTotalSpent(user1), 1000 * 1e6, "F3: total spent should be $1000");
        console.log("F3 PASS: cap raised $864->$1000, extra $200 succeeded");
    }

    function test_F4_RecoverToken() public {
        usdc.mint(address(sale), 100 * 1e6);
        assertEq(usdc.balanceOf(address(sale)), 100 * 1e6, "F4: contract should have USDC");

        uint256 treasuryBefore = usdc.balanceOf(treasury);

        vm.prank(owner);
        sale.recoverToken(address(usdc));

        assertEq(usdc.balanceOf(treasury), treasuryBefore + 100 * 1e6, "F4: treasury should receive USDC");
        assertEq(usdc.balanceOf(address(sale)), 0, "F4: contract should have 0 USDC");
        console.log("F4 PASS: 100 USDC recovered from contract to treasury");
    }

    // =============================================================
    //           GROUP G — EDGE CASES & ERRORS
    // =============================================================

    function test_G1_ZeroAmountRevert() public {
        vm.prank(user1);
        vm.expectRevert(SaleContract.ZeroAmount.selector);
        sale.buyTokens(0, address(usdc), 0);
        console.log("G1 PASS: ZeroAmount error for 0 USD purchase");
    }

    function test_G2_UnknownTokenRevert() public {
        address unknownToken = makeAddr("unknownToken");
        vm.prank(user1);
        vm.expectRevert(
            abi.encodeWithSelector(SaleContract.TokenNotAccepted.selector, unknownToken)
        );
        sale.buyTokens(100 * 1e6, unknownToken, 0);
        console.log("G2 PASS: TokenNotAccepted for unknown token");
    }

    function test_G3_InsufficientInventoryRevert() public {
        vm.prank(owner);
        sale.recoverToken(address(gToken));
        assertEq(gToken.balanceOf(address(sale)), 0, "G3: inventory should be 0");

        uint256 buyAmount = 100 * 1e6;
        uint256 expectedGTokens = (buyAmount * 1e18) / PRICE_M0;

        vm.startPrank(user1);
        usdc.approve(address(sale), buyAmount);
        vm.expectRevert(
            abi.encodeWithSelector(SaleContract.InsufficientInventory.selector, expectedGTokens, 0)
        );
        sale.buyTokens(buyAmount, address(usdc), 0);
        vm.stopPrank();
        console.log("G3 PASS: InsufficientInventory error when stock depleted");
    }

    function test_G4_NonOwnerAdminFunctionsRevert() public {
        vm.prank(user1);
        vm.expectRevert(
            abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user1)
        );
        sale.pause();

        vm.prank(user1);
        vm.expectRevert(
            abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user1)
        );
        sale.advanceMilestone();

        vm.prank(user1);
        vm.expectRevert(
            abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user1)
        );
        sale.setTreasury(makeAddr("newTreasury"));

        vm.prank(user1);
        vm.expectRevert(
            abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user1)
        );
        sale.setPerPersonCap(1000 * 1e6);

        console.log("G4 PASS: all admin functions reject non-owner callers");
    }

    function test_G5_SetTreasuryZeroAddressRevert() public {
        vm.prank(owner);
        vm.expectRevert(SaleContract.ZeroAddress.selector);
        sale.setTreasury(address(0));
        console.log("G5 PASS: ZeroAddress error for setTreasury(address(0))");
    }
}
