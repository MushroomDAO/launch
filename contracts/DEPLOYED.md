# Deployed Contracts

## Sepolia Testnet (Current)

| Contract | Address | Etherscan |
|---|---|---|
| GToken (SuperPaymaster) | 0xa592ec5a05c3909917d038ab01aaf7bccf2d90f0 | [link](https://sepolia.etherscan.io/address/0xa592ec5a05c3909917d038ab01aaf7bccf2d90f0) |
| SaleContract v1.2.1 | 0x9cA2520D4Fa7e207211Ef5903E7918F06B3faDBA | [link](https://sepolia.etherscan.io/address/0x9ca2520d4fa7e207211ef5903e7918f06b3fadba) |

Treasury (Safe): 0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114
Owner (deployer): 0xEcAACb915f7D92e9916f449F7ad42BD0408733c9
Accepted Payment: USDC (0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238)
Whitelist: Disabled (open sale)
Starting Price: $0.15 / GToken
Inventory: 4,200,000 GT

## Deployment Details (v1.2.1)

- Network: Sepolia (Chain ID: 11155111)
- Deploy Date: 2026-04-09
- Constructor Args: `(gToken=0xa592ec5a05c3909917d038ab01aaf7bccf2d90f0, treasury=0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114, owner=0xEcAACb915f7D92e9916f449F7ad42BD0408733c9)`
- Post-deploy config:
  - `setPaymentToken(USDC, true)` - USDC accepted
  - `setWhitelistRequired(false)` - open sale
  - `mint(saleContract, 4_200_000e18)` - GToken inventory loaded
- Verified on Etherscan: Yes
- Security: Codex-reviewed (3 rounds), 79 tests pass

## Deprecated

| Contract | Address | Reason |
|---|---|---|
| SaleContract v1.0.0 | 0x1da9e61ABa8363Efe7D2910d96662fDc544eE2E7 | superseded by v1.2.1 |
| SaleContract v1.0.0 | 0x6b9f8132389Ac377dBd097656a8F55bCf46E5889 | superseded by v1.2.1 |
