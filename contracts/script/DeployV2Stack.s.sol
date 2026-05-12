// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {MockGToken} from "../src/MockGToken.sol";
import {SaleContractV2} from "../src/SaleContractV2.sol";

/**
 * @notice Deploys the V2 stack: MockGToken + SaleContractV2.
 *
 *  Steps:
 *    1. Deploy MockGToken (owner = OWNER_ADDRESS, default = broadcaster).
 *    2. Mint 855_000 GT to TREASURY_ADDRESS (covers $200K cap, see V2 milestones).
 *    3. Deploy SaleContractV2 pointing at MockGToken.
 *    4. Accept USDC (and USDT if configured) as payment.
 *    5. Disable whitelist (open sale).
 *
 *  Treasury still has to manually transfer 855_000 GT to SaleContractV2 after deploy
 *  via Safe UI:  GToken.transfer(SaleContractV2, 855000e18)
 *
 *  Required env:
 *    TREASURY_ADDRESS   - Optimism Safe address (works on Sepolia at same address)
 *    PRIVATE_KEY_ANNI   - Broadcaster (becomes Owner of both contracts unless OWNER_ADDRESS set)
 *
 *  Optional:
 *    OWNER_ADDRESS      - Override owner; defaults to broadcaster
 *    USDT_SEPOLIA       - If set, accept USDT too
 *
 *  Run:
 *    forge script script/DeployV2Stack.s.sol \
 *      --rpc-url $SEPOLIA_RPC_URL2 \
 *      --private-key $PRIVATE_KEY_ANNI \
 *      --broadcast --verify
 */
contract DeployV2Stack is Script {
    address constant USDC_SEPOLIA = 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;
    /// @notice GT inventory minted to treasury — supports launch sale up to ~$200K cap.
    /// Math: M0→M5 needs 611,667 GT; M5 buffer to $200K needs 242,866 GT; total = 854,533. Round to 855K.
    uint256 constant TREASURY_INITIAL_MINT = 855_000 * 1e18;

    function run() external returns (MockGToken token, SaleContractV2 sale) {
        address treasury = vm.envAddress("TREASURY_ADDRESS");
        address deployer = vm.envOr("DEPLOYER_ADDRESS", address(0));
        address owner = vm.envOr("OWNER_ADDRESS", deployer != address(0) ? deployer : msg.sender);
        address usdtSepolia = vm.envOr("USDT_SEPOLIA", address(0));

        require(treasury != address(0), "TREASURY_ADDRESS not set");

        console.log("=== V2 Stack Deployment ===");
        console.log("Treasury:        ", treasury);
        console.log("Owner (Mock+V2): ", owner);
        console.log("USDC (Sepolia):  ", USDC_SEPOLIA);
        console.log("Initial mint -> treasury:", TREASURY_INITIAL_MINT / 1e18, "GT");

        vm.startBroadcast();

        // 1. Deploy MockGToken
        token = new MockGToken(owner);
        console.log("MockGToken deployed at:", address(token));

        // 2. Mint 855K GT to Treasury
        token.mint(treasury, TREASURY_INITIAL_MINT);
        console.log("Minted to Treasury:", token.balanceOf(treasury) / 1e18, "GT");

        // 3. Deploy SaleContractV2
        sale = new SaleContractV2(address(token), treasury, owner);
        console.log("SaleContractV2 deployed at:", address(sale));

        // 4. Accept USDC
        sale.setPaymentToken(USDC_SEPOLIA, true);
        console.log("Accepted USDC");
        if (usdtSepolia != address(0)) {
            sale.setPaymentToken(usdtSepolia, true);
            console.log("Accepted USDT:", usdtSepolia);
        }

        // 5. Disable whitelist
        sale.setWhitelistRequired(false);
        console.log("Whitelist disabled (open sale)");

        vm.stopBroadcast();

        console.log("");
        console.log("=== Next steps (manual) ===");
        console.log("From Treasury Safe (sep:0x51eDf...) - transfer 855,000 GT to SaleContractV2:");
        console.log("  GToken:", address(token));
        console.log("  to:    ", address(sale));
        console.log("  amount: 855000000000000000000000  (= 855_000 * 1e18)");
        console.log("");
        console.log("After transfer, SaleContractV2.availableInventory() should return 855e21.");
    }
}
