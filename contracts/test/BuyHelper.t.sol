// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Test} from "forge-std/Test.sol";
import {BuyHelper} from "../src/BuyHelper.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

/// @notice Non-fork unit tests for BuyHelper's relayer whitelist + access control
/// (the onlyRelayer guard added during the release-gate hardening, then upgraded
/// to a mutable set per AAStarCommunity/dvt#5). No fork needed — the relayer check
/// short-circuits before any on-chain interaction.
contract BuyHelperUnitTest is Test {
    BuyHelper helper;
    address owner = makeAddr("owner");
    address relayer1 = makeAddr("relayer1");
    address relayer2 = makeAddr("relayer2");
    address attacker = makeAddr("attacker");

    function setUp() public {
        address[] memory relayers = new address[](2);
        relayers[0] = relayer1;
        relayers[1] = relayer2;
        helper = new BuyHelper(
            makeAddr("usdc"), makeAddr("gtoken"), makeAddr("apnts"),
            makeAddr("saleGT"), makeAddr("saleAP"), owner, relayers
        );
    }

    function test_initial_relayers_whitelisted() public view {
        assertTrue(helper.isRelayer(relayer1), "relayer1 whitelisted");
        assertTrue(helper.isRelayer(relayer2), "relayer2 whitelisted");
        assertFalse(helper.isRelayer(attacker), "attacker not whitelisted");
        assertEq(helper.owner(), owner, "owner set");
    }

    function test_executeBuy_rejects_non_relayer() public {
        BuyHelper.BuyIntent memory intent;
        BuyHelper.TransferAuthExtras memory auth =
            BuyHelper.TransferAuthExtras({validAfter: 0, v: 27, r: bytes32(0), s: bytes32(0)});
        vm.prank(attacker);
        vm.expectRevert(abi.encodeWithSelector(BuyHelper.NotRelayer.selector, attacker));
        helper.executeBuy(intent, hex"", auth);
    }

    function test_addRelayer() public {
        address newRelayer = makeAddr("relayer3");
        vm.prank(owner);
        helper.addRelayer(newRelayer);
        assertTrue(helper.isRelayer(newRelayer), "added relayer whitelisted");
    }

    function test_removeRelayer() public {
        vm.prank(owner);
        helper.removeRelayer(relayer1);
        assertFalse(helper.isRelayer(relayer1), "removed relayer no longer whitelisted");
    }

    function test_addRelayer_owner_only() public {
        vm.prank(attacker);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, attacker));
        helper.addRelayer(attacker);
    }

    function test_removeRelayer_owner_only() public {
        vm.prank(attacker);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, attacker));
        helper.removeRelayer(relayer1);
    }

    function test_addRelayer_zero_reverts() public {
        vm.prank(owner);
        vm.expectRevert(BuyHelper.ZeroRelayer.selector);
        helper.addRelayer(address(0));
    }

    function test_constructor_zero_relayer_reverts() public {
        address[] memory relayers = new address[](1);
        relayers[0] = address(0);
        vm.expectRevert(BuyHelper.ZeroRelayer.selector);
        new BuyHelper(
            makeAddr("usdc"), makeAddr("gtoken"), makeAddr("apnts"),
            makeAddr("saleGT"), makeAddr("saleAP"), owner, relayers
        );
    }
}
