// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Test} from "forge-std/Test.sol";
import {BuyHelper} from "../src/BuyHelper.sol";

/// @notice Non-fork unit tests for BuyHelper access control (the onlyRelayer
/// guard added during the release-gate hardening). These don't need a fork
/// because the relayer check short-circuits before any on-chain interaction.
contract BuyHelperUnitTest is Test {
    BuyHelper helper;
    address relayer = makeAddr("relayer");
    address attacker = makeAddr("attacker");

    function setUp() public {
        helper = new BuyHelper(
            makeAddr("usdc"),
            makeAddr("gtoken"),
            makeAddr("apnts"),
            makeAddr("saleGT"),
            makeAddr("saleAP"),
            relayer
        );
    }

    function test_relayer_set() public view {
        assertEq(helper.RELAYER(), relayer);
    }

    function test_executeBuy_rejects_non_relayer() public {
        BuyHelper.BuyIntent memory intent;
        BuyHelper.TransferAuthExtras memory auth =
            BuyHelper.TransferAuthExtras({validAfter: 0, v: 27, r: bytes32(0), s: bytes32(0)});

        vm.prank(attacker);
        vm.expectRevert(abi.encodeWithSelector(BuyHelper.NotRelayer.selector, attacker));
        helper.executeBuy(intent, hex"", auth);
    }

    function test_constructor_zero_relayer_reverts() public {
        vm.expectRevert(BuyHelper.ZeroRelayer.selector);
        new BuyHelper(
            makeAddr("usdc"),
            makeAddr("gtoken"),
            makeAddr("apnts"),
            makeAddr("saleGT"),
            makeAddr("saleAP"),
            address(0)
        );
    }
}
