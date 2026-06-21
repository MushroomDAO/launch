# Deployed Contracts

## Sepolia — Path A (canonical-bound stack, 2026-06-21) — CURRENT

Sale stack redeployed bound to the **canonical SuperPaymaster GToken / aPNTs** (the
authoritative ecosystem tokens), replacing the earlier test-token-bound deployment.

| Contract | Address |
|---|---|
| GToken (canonical, SuperPaymaster) | `0x20a051502a7AE6e40cfFd6EBe59057538E698984` |
| aPNTs (canonical) | `0x9e66B457E0ABb1F139FD8A596d00f784eBA2873b` |
| SaleContractV2 (→ canonical GToken) | `0x29eE47dEBD0E60d426352415749b4899057D913F` |
| APNTsSaleContract (→ canonical aPNTs) | `0x136654d4141d151e9C237af65E98c03e22afc142` |
| BuyHelper (gasless, → canonical + new sales) | `0x0EA2AEd239574F4e875Ae570C67825da845E7e66` |
| USDC (payment) | `0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238` |
| Deployer / treasury / owner | `0xb5600060e6de5E11D3636731964218E53caadf0E` |

- Prices: GToken $0.15 · aPNTs $0.02. Inventory funded: 500 GT → SaleV2, 5000 aPNTs → APNTsSale.
- Verified on-chain: self-pay buy succeeded (canonical GT received). Gasless requires the
  relayer whitelist to be updated to the new BuyHelper + canonical tokens.
- **TODO (relayer)**: whitelist BuyHelper `0x0EA2AE…`, sales `0x29eE47…`/`0x136654…`, and
  target tokens `0x20a051…`/`0x9e66B…` in `services/relayer` (whitelist.ts + wrangler.toml).

## Sepolia Testnet (legacy — test-token-bound, superseded by Path A above)

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
