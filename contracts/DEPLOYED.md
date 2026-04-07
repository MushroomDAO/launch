# Deployed Contracts

## Sepolia Testnet

| Contract | Address | Etherscan |
|---|---|---|
| GToken (SuperPaymaster) | 0xa592ec5a05c3909917d038ab01aaf7bccf2d90f0 | [link](https://sepolia.etherscan.io/address/0xa592ec5a05c3909917d038ab01aaf7bccf2d90f0) |
| SaleContract | 0x1da9e61ABa8363Efe7D2910d96662fDc544eE2E7 | [link](https://sepolia.etherscan.io/address/0x1da9e61aba8363efe7d2910d96662fdc544ee2e7) |

Treasury (Safe): 0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114
Deployer: 0xb5600060e6de5E11D3636731964218E53caadf0E
Accepted Payment: USDC (0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238)
Whitelist: Disabled (open sale)
Starting Price: $0.15 / GToken

## Deployment Details

- Network: Sepolia (Chain ID: 11155111)
- Deploy Date: 2026-04-07
- Constructor Args: `(gToken=0xa592ec5a05c3909917d038ab01aaf7bccf2d90f0, treasury=0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114, owner=0xb5600060e6de5E11D3636731964218E53caadf0E)`
- Post-deploy config:
  - `setPaymentToken(USDC, true)` - USDC accepted
  - `setWhitelistRequired(false)` - open sale
- Verified on Etherscan: Yes
