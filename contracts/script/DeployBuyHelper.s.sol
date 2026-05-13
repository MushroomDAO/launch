// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {BuyHelper} from "../src/BuyHelper.sol";

/**
 * @notice Deploy BuyHelper to Sepolia.
 *
 *  Run:
 *    forge script script/DeployBuyHelper.s.sol \
 *      --rpc-url $SEPOLIA_RPC_URL2 \
 *      --private-key $PRIVATE_KEY_ANNI \
 *      --broadcast --verify
 */
contract DeployBuyHelper is Script {
    address constant USDC    = 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;
    address constant GTOKEN  = 0x4e6A1125B8619d6D05c99AB2F30BDFc96C843B67;
    address constant APNTS   = 0x4C4EC2e866f0c43DCA4670A6033e962a05B4C772;
    address constant SALE_GT = 0x3e4e0A663682a2d58d626D0057142328Ef0b626a;
    address constant SALE_AP = 0xf1a5FE670dbf6c5219000B30500a98F772EF1F14;

    function run() external returns (BuyHelper helper) {
        console.log("=== Deploying BuyHelper ===");
        console.log("Broadcaster:", msg.sender);
        console.log("USDC:       ", USDC);
        console.log("GTOKEN:     ", GTOKEN);
        console.log("APNTS:      ", APNTS);
        console.log("SALE_GT:    ", SALE_GT);
        console.log("SALE_AP:    ", SALE_AP);

        vm.startBroadcast();
        helper = new BuyHelper(USDC, GTOKEN, APNTS, SALE_GT, SALE_AP);
        vm.stopBroadcast();

        console.log("");
        console.log("BuyHelper deployed at:", address(helper));
        console.log("DOMAIN_SEPARATOR:", uint256(helper.DOMAIN_SEPARATOR()));
        console.log("");
        console.log("=== Next steps ===");
        console.log("1. Update services/relayer/src/rules/whitelist.ts with BUY_HELPER");
        console.log("2. Update services/relayer/wrangler.toml with BUY_HELPER");
        console.log("3. Update site/join-gasless.html with BUY_HELPER constant");
        console.log("4. Update docs/gasless-eoa-enhance/02-architecture-decision-eip3009.md");
    }
}
