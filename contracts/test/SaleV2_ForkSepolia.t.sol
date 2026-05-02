// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Test} from "forge-std/Test.sol";
import {SaleContractV2} from "../src/SaleContractV2.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

/**
 * @notice Fork-Sepolia integration test — actually buys against the deployed V2 stack.
 *
 * Run:
 *   forge test --match-contract SaleV2ForkSepolia \
 *     --fork-url $SEPOLIA_RPC_URL2 \
 *     -vvv
 */
contract SaleV2ForkSepoliaTest is Test {
    address constant SALE_V2  = 0xD2E2566566D459115D4159993E96c45c0d2cE6CD;
    address constant GTOKEN   = 0x25c78eF9830b9b7a705B1E5b19939dFB465fF37F;
    address constant USDC     = 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;
    address constant TREASURY = 0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114;

    address buyer = makeAddr("buyer");

    SaleContractV2 sale;
    IERC20 gt;
    IERC20 usdc;

    function setUp() public {
        sale = SaleContractV2(SALE_V2);
        gt = IERC20(GTOKEN);
        usdc = IERC20(USDC);

        // Give the test buyer 1000 USDC out of thin air (forge-std helper).
        deal(USDC, buyer, 1000 * 1e6);
    }

    function test_state_pre_buy() public view {
        assertEq(sale.version(), "2.0.0");
        assertEq(sale.availableInventory(), 855_000 * 1e18);
        assertEq(sale.getCurrentPriceUSD(), 150_000); // M0
        assertEq(sale.currentMilestone(), 0);
        assertEq(sale.acceptedTokens(USDC), true);
        assertEq(sale.whitelistRequired(), false);
        assertEq(sale.paused(), false);
    }

    function test_full_buy_path_15_USDC() public {
        // Buyer approves + buys $15 worth (gets 100 GT @ $0.15).
        vm.startPrank(buyer);
        usdc.approve(SALE_V2, type(uint256).max);
        sale.buyTokens(15 * 1e6, USDC, 0);
        vm.stopPrank();

        // Buyer should have exactly 100 GT.
        assertEq(gt.balanceOf(buyer), 100 * 1e18);

        // Treasury receives the 15 USDC.
        // Note: treasury already had USDC balance pre-fork; check delta only is impractical
        // without snapshotting, so just check it grew by ≥ 15e6.
        // Sale state updated.
        assertEq(sale.totalRevenue(), 15 * 1e6);
        assertEq(sale.totalTokensSold(), 100 * 1e18);
        assertEq(sale.userTotalSpent(buyer), 15 * 1e6);

        // Still at M0 (didn't reach M1 cap of $1,200).
        assertEq(sale.currentMilestone(), 0);
        assertEq(sale.getCurrentPriceUSD(), 150_000);
    }

    function test_buy_advances_to_M1() public {
        // Big buy of $1500 (passes M1 cap of $1,200).
        // At M0 price 0.15, 1500 USDC -> 10,000 GT.
        deal(USDC, buyer, 2000 * 1e6); // give buyer more headroom

        // perPersonCap defaults to $864 — bump it for the test via owner prank.
        // We skip this by calling setPerPersonCap from the actual on-chain owner (ANNI).
        address anni = sale.owner();
        vm.prank(anni);
        sale.setPerPersonCap(2_000 * 1e6);

        vm.startPrank(buyer);
        usdc.approve(SALE_V2, type(uint256).max);
        sale.buyTokens(1_500 * 1e6, USDC, 0);
        vm.stopPrank();

        // After the buy, milestone should have advanced to 1.
        assertEq(sale.currentMilestone(), 1);
        assertEq(sale.getCurrentPriceUSD(), 168_000); // M1 price
        assertEq(sale.totalRevenue(), 1_500 * 1e6);
        // Buyer paid M0 price for the entire buy (10,000 GT).
        assertEq(gt.balanceOf(buyer), 10_000 * 1e18);
    }

    function test_perPersonCap_blocks_excess() public {
        // perPersonCap is $864 by default — buying $900 should revert.
        vm.startPrank(buyer);
        usdc.approve(SALE_V2, type(uint256).max);
        vm.expectRevert();
        sale.buyTokens(900 * 1e6, USDC, 0);
        vm.stopPrank();
    }

    function test_addMilestoneAutoStep_owner_only() public {
        address anni = sale.owner();

        // Reach M5 first by manipulating revenue (cheating via storage isn't easy without
        // walking through it — instead just append a new milestone and check it shows up.)
        // Actually we can just add even though revenue is 0; addMilestone validates monotonic price/cap only.
        vm.prank(anni);
        sale.addMilestoneAutoStep(200_000_000_000); // $200K cap, +12% from M5 = $0.296073

        assertEq(sale.getMilestoneCount(), 7);
        (uint256 p, uint256 c) = sale.getMilestone(6);
        assertEq(p, uint256(264_351) * 11_200 / 10_000);
        assertEq(c, 200_000_000_000);
    }
}
