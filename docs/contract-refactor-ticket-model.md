# Contract Refactor: Stake+Burn → Ticket Model (Burn to Treasury)

> Status: **PLANNING — do not modify contracts until approved**
> Date: 2026-04-15
> Author: Claude (AI review) + Jason (decision maker)

---

## 1. Goal

Replace the current Stake + Burn dual mechanism with a simpler Ticket Model:

- **Current:** Users stake GToken (refundable lock) AND burn GToken (permanent destruction) to join the protocol
- **New:** Users burn GToken (transferred to Treasury, not destroyed) to join. Membership is lifetime. No exit mechanism for regular users.
- **Exception:** Node operators (DVT, KMS, etc.) still stake GToken as a security deposit, refundable minus penalties on exit.

### Mental Model: Park Ticket

```
Individual: ~0.3 GT → burn to Treasury → lifetime protocol member
Community:  ~30 GT  → burn to Treasury → lifetime protocol access
Node Operator: stake X GT (security deposit) + burn Y GT (ticket)
```

---

## 2. Affected Contracts

| Contract | Change Level | Description |
|----------|-------------|-------------|
| **GTokenStaking.sol** | MAJOR | Core logic change: split into ticket burn vs operator stake |
| **Registry.sol** | MAJOR | Remove exit for non-operators, simplify RoleConfig |
| **IGTokenStaking.sol** | MEDIUM | Interface simplification |
| **GToken.sol** | NONE | No changes needed |
| **MySBT.sol** | NONE | Already decoupled from staking since v3 |
| **SuperPaymaster.sol** | NONE | Operates on aPNTs, not GToken |
| **xPNTsToken.sol** | NONE | Independent |
| **xPNTsFactory.sol** | NONE | Independent |

---

## 3. Detailed Changes: GTokenStaking.sol

### 3.1 `lockStake()` — Split into two paths

**Current (lines 107-156):**
```solidity
function lockStake(address user, bytes32 roleId, uint256 stakeAmount, uint256 entryBurn, address payer) external {
    uint256 totalAmount = stakeAmount + entryBurn;
    GTOKEN.safeTransferFrom(payer, address(this), totalAmount);
    
    // TRUE BURN — reduces totalSupply permanently
    if (entryBurn > 0) {
        ERC20Burnable(address(GTOKEN)).burn(entryBurn);
    }
    
    // STAKE — locked in contract, refundable on exit
    stakes[user].roles[roleId] = RoleLock({ amount: stakeAmount, ... });
}
```

**New — Option A (recommended): Two separate functions**

```solidity
// For regular users (ENDUSER, COMMUNITY): ticket only, no stake
function burnTicket(address user, bytes32 roleId, uint256 ticketPrice, address payer) external onlyRegistry {
    GTOKEN.safeTransferFrom(payer, treasury, ticketPrice);  // transfer, NOT burn
    emit TicketBurned(user, roleId, ticketPrice);
}

// For operators (DVT, KMS, PAYMASTER_*): stake + ticket
function lockStakeWithTicket(address user, bytes32 roleId, uint256 stakeAmount, uint256 ticketPrice, address payer) external onlyRegistry {
    uint256 total = stakeAmount + ticketPrice;
    GTOKEN.safeTransferFrom(payer, address(this), total);
    
    // Ticket portion goes to treasury
    if (ticketPrice > 0) {
        GTOKEN.safeTransfer(treasury, ticketPrice);
    }
    
    // Stake portion stays locked
    stakes[user].roles[roleId] = RoleLock({ amount: stakeAmount, ... });
}
```

### 3.2 `unlockAndTransfer()` — Only for operators

**Current:** Called on any role exit, returns stake minus exit fee.

**New:** Only callable for operator roles (DVT, KMS, PAYMASTER_*). Regular user roles have no exit.

### 3.3 `topUpStake()` — Only for operators

Keep for operator roles only. May need top-up if minimum stake requirement increases via governance.

### 3.4 `slash()` / `slashByDVT()` — Keep, operators only

No change. Slash deducts from operator's locked stake, transfers to treasury.

### 3.5 Remove or simplify

- Remove: Exit fee logic for non-operator roles (no exit = no exit fee)
- Keep: Exit fee logic for operator roles
- Remove: `totalStaked` tracking for ticket burns (they go directly to treasury)

---

## 4. Detailed Changes: Registry.sol

### 4.1 RoleConfig — Simplify

**Current:**
```solidity
struct RoleConfig {
    uint256 minStake;
    uint256 entryBurn;
    uint32 slashThreshold;
    uint32 slashBase;
    uint32 slashInc;
    uint32 slashMax;
    uint16 exitFeePercent;
    bool isActive;
    uint256 minExitFee;
    string description;
    address owner;
    uint256 roleLockDuration;
}
```

**New:**
```solidity
struct RoleConfig {
    uint256 ticketPrice;      // burn amount (transfer to treasury)
    uint256 minStake;          // ONLY for operator roles, 0 for others
    uint32 slashThreshold;     // ONLY for operator roles
    uint32 slashBase;
    uint32 slashInc;
    uint32 slashMax;
    uint16 exitFeePercent;     // ONLY for operator roles
    bool isActive;
    bool isOperatorRole;       // NEW: distinguishes ticket-only vs stake+ticket
    uint256 minExitFee;        // ONLY for operator roles
    string description;
    address owner;
    uint256 roleLockDuration;  // ONLY for operator roles
}
```

### 4.2 Role defaults — Updated

| Role | isOperatorRole | ticketPrice | minStake | Exit? |
|------|---------------|-------------|----------|-------|
| ENDUSER | false | 0.3 GT | 0 | NO |
| COMMUNITY | false | 30 GT | 0 | NO |
| PAYMASTER_AOA | true | 3 GT | 30 GT | YES (operator exit) |
| PAYMASTER_SUPER | true | 5 GT | 50 GT | YES (operator exit) |
| DVT | true | 3 GT | 30 GT | YES (operator exit) |
| ANODE | true | 2 GT | 20 GT | YES (operator exit) |
| KMS | true | 10 GT | 100 GT | YES (operator exit) |

### 4.3 `registerRole()` — Split logic

```solidity
function registerRole(bytes32 roleId, ...) external {
    RoleConfig memory config = roleConfigs[roleId];
    
    if (config.isOperatorRole) {
        // Operators: stake + ticket
        GTOKEN_STAKING.lockStakeWithTicket(user, roleId, config.minStake, config.ticketPrice, sponsor);
    } else {
        // Regular users: ticket only
        GTOKEN_STAKING.burnTicket(user, roleId, config.ticketPrice, sponsor);
    }
    
    MYSBT.mintForRole(user, roleId, sbtData);
}
```

### 4.4 `exitRole()` — Operator-only

```solidity
function exitRole(bytes32 roleId) external {
    require(roleConfigs[roleId].isOperatorRole, "No exit for ticket-only roles");
    // ... existing exit logic for operators ...
}
```

---

## 5. Economic Flow (New Model)

```
┌─────────────┐     ticketPrice      ┌──────────────┐
│  User/       │ ──────────────────→ │   Treasury    │
│  Community   │   (burn to treasury) │  (国库)       │
└─────────────┘                      └──────┬───────┘
                                            │
                                   Governance distributes
                                            │
                                   ┌────────▼────────┐
                                   │ Node Operators   │
                                   │ (infra mining    │
                                   │  14% of 21M)     │
                                   └────────┬────────┘
                                            │
                                   GT flows back to market
                                            │
                                   ┌────────▼────────┐
                                   │  Market / DEX    │
                                   │  New users buy   │
                                   └─────────────────┘

┌─────────────┐     stake (locked)   ┌──────────────┐
│  Node        │ ──────────────────→ │  Staking     │
│  Operators   │                     │  Contract    │
│  (DVT/KMS)   │ ←──────────────── │  (保证金)     │
└─────────────┘   unstake (- fee)    └──────────────┘
```

**21M GT total supply is CONSTANT.** Nothing is destroyed. Ticket burns transfer to Treasury; operator stakes are locked (refundable). The economic cycle is closed.

---

## 6. Cascade / Impact Analysis

### 6.1 No Impact (confirmed safe)

| Component | Why safe |
|-----------|---------|
| GToken.sol | ERC20 token, no logic changes. `burn()` still exists but won't be called for tickets. |
| MySBT.sol | Decoupled from staking since v3. Only Registry calls `mintForRole`. |
| SuperPaymaster.sol | Operates on aPNTs, completely independent of GToken staking. |
| xPNTsToken/Factory | Community token layer, no GToken involvement. |
| SaleContract.sol | GToken purchase mechanism, unrelated to staking/burn. |

### 6.2 Requires Update

| Component | What changes | Risk |
|-----------|-------------|------|
| GTokenStaking.sol | Core refactor (split ticket vs stake) | HIGH — must preserve operator stake safety |
| Registry.sol | Role registration flow, exit restrictions | HIGH — must not break SBT minting |
| IGTokenStaking.sol | New interface functions | LOW — clean interface change |
| Test suite | Rewrite stake/exit tests for new model | MEDIUM — coverage must match or exceed current |
| Frontend (if any) | Registration UI flow | LOW — UI calls Registry, not staking directly |

### 6.3 Edge Cases to Test

1. **User tries to exit a ticket-only role** → must revert cleanly
2. **Operator exits and re-registers** → ticket price charged again? (YES — new ticket each time)
3. **Governance changes ticketPrice mid-operation** → should not affect in-progress registrations
4. **Treasury address is zero** → must revert on ticket burn (safeTransfer to address(0) reverts)
5. **Operator stake is slashed below minimum** → existing slash logic should still work
6. **Community registers PAYMASTER role** → must have COMMUNITY role first (existing check), ticket for COMMUNITY + stake+ticket for PAYMASTER

---

## 7. Migration Strategy

### Option A: New contract deployment (recommended)
- Deploy new GTokenStaking v4 with ticket model
- Deploy new Registry v5 pointing to new staking
- Migrate existing user registrations via admin script
- Old contracts remain functional for read-only queries

### Option B: In-place upgrade (Registry is UUPS upgradeable)
- Upgrade Registry via proxy
- Deploy new GTokenStaking and call `setStaking()` on upgraded Registry
- Risk: storage layout must be backward-compatible

**Recommendation: Option A for GTokenStaking (not upgradeable), Option B for Registry (already UUPS).**

---

## 8. Test Plan

### Unit Tests (per contract)
- [ ] `burnTicket()` — correct amount transferred to treasury
- [ ] `burnTicket()` — reverts for operator roles
- [ ] `lockStakeWithTicket()` — correct split between treasury and stake
- [ ] `lockStakeWithTicket()` — reverts for non-operator roles
- [ ] `unlockAndTransfer()` — only works for operator roles
- [ ] `exitRole()` — reverts for ENDUSER and COMMUNITY
- [ ] `exitRole()` — works correctly for DVT, KMS, PAYMASTER_*
- [ ] `slash()` — still works on operator stakes
- [ ] Governance can update `ticketPrice` for any role
- [ ] `totalSupply()` remains constant after ticket burns (transfer, not burn)

### Integration Tests
- [ ] Full user journey: buy GToken → register ENDUSER → use protocol → cannot exit
- [ ] Full operator journey: register COMMUNITY → register PAYMASTER_SUPER → operate → exit → re-register
- [ ] Community registers then upgrades to PAYMASTER: both ticket + stake collected correctly
- [ ] Slash → operator exits → net amount correct

### Scenario Tests
- [ ] 100 users register → treasury balance increases by 100 * 0.3 GT
- [ ] Operator slashed 50% → exit returns 50% of stake minus exit fee
- [ ] Governance reduces ENDUSER ticketPrice from 0.3 to 0.2 → next registration uses 0.2

---

## 9. Timeline Estimate

| Phase | Work | Duration |
|-------|------|----------|
| 1. Contract refactor | GTokenStaking v4 + Registry v5 | 3-5 days |
| 2. Unit tests | All new functions | 2-3 days |
| 3. Integration tests | Full user/operator journeys | 2-3 days |
| 4. Internal review | Codex AI multi-round review | 1-2 days |
| 5. Testnet deploy | Sepolia deployment + smoke test | 1 day |
| 6. External audit | Phase 4 budget ($25K) | TBD |

---

## 10. Open Questions (need Jason's decision)

1. **Re-registration fee:** If an operator exits and re-registers, do they pay the ticket again? (Suggested: YES)
2. **Ticket price governance:** Who can change ticketPrice? Currently `roleConfig.owner` or contract owner. Keep this?
3. **GToken.burn() function:** Keep it on the token contract? Even if we don't use it for tickets, it's part of ERC20Burnable interface. (Suggested: keep, don't call)
4. **Backward compatibility:** Existing registered users on testnet — migrate or re-register?
5. **Event naming:** Change `TokensBurned` event to `TicketPurchased` or keep generic?
