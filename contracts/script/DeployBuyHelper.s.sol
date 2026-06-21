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
    // Rebound to the canonical SuperPaymaster GToken/aPNTs (path A reconciliation,
    // 2026-06-21) + the freshly redeployed sale stack bound to those tokens.
    address constant USDC    = 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;
    address constant GTOKEN  = 0x20a051502a7AE6e40cfFd6EBe59057538E698984;
    address constant APNTS   = 0x9e66B457E0ABb1F139FD8A596d00f784eBA2873b;
    address constant SALE_GT = 0x29eE47dEBD0E60d426352415749b4899057D913F;
    address constant SALE_AP = 0x136654d4141d151e9C237af65E98c03e22afc142;

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
