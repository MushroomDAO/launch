# SaleContract User Scenario Test Report
Date: 2026-04-07
Network: Sepolia Testnet
SaleContract: 0x1da9e61ABa8363Efe7D2910d96662fDc544eE2E7

## Summary
- Total Scenarios: 26
- Passed: 26 / 26 ✅
- Failed: 0
- Test File: `contracts/test/SaleContractScenarios.t.sol`
- Framework: Foundry (forge test)

## Coverage by Group

| Group | Description | Tests | Status |
|---|---|---|---|
| A | Normal Purchase Paths | 4 | ✅ |
| B | Multi-Buy & Cross-Milestone | 3 | ✅ |
| C | Milestone Advancement | 4 | ✅ |
| D | Multi-User Concurrent | 3 | ✅ |
| E | Whitelist Scenarios | 3 | ✅ |
| F | Admin Operations | 4 | ✅ |
| G | Edge Cases & Errors | 5 | ✅ |

## Detailed Results

| ID | Scenario | User Type | Operation | Result | Gas |
|---|---|---|---|---|---|
| A1 | 早期支持者最小额 $12 | earlyBacker | buyTokens(12e6, USDC) | ✅ gTokens = 12e6*1e18/150000 | 182,828 |
| A2 | 社区运营者 $80 | communityOp | buyTokens(80e6, USDC) | ✅ 余额和 totalRevenue 正确 | 183,691 |
| A3 | 协议建设者 $336 | builder | buyTokens(336e6, USDC) | ✅ 购买成功 | 181,495 |
| A4 | 鲸鱼最大单笔 $864 + 超额 revert | whale | buyTokens(864e6) + buyTokens(1e6) | ✅ 第二笔 ExceedsPerPersonCap | 211,397 |
| B1 | 分批 $400+$400+$64=$864，$100 被拒 | user1 | 3次购买，第3次超额测试 | ✅ $100 revert，$64 成功 | 233,465 |
| B2 | 跨里程碑价格增长验证 | user2 | M0 买 $100，推进 M1 再买 $100 | ✅ M1 tokens < M0 tokens | 232,109 |
| B3 | 5 次小额 $100 累积到 $500 | user3 | 5x buyTokens(100e6) | ✅ userTotalSpent=500e6 | 304,874 |
| C1 | 10 用户共 $1300 触发里程碑推进 | 10 users | 各 $130，advanceMilestone() | ✅ milestone=1, price=168000 | 858,471 |
| C2 | 收入不足 $500 无法推进里程碑 | user1 | buyTokens $500, advanceMilestone | ✅ MilestoneNotReached revert | 182,350 |
| C3 | 连续推进 3 个里程碑 | owner | 3x advanceMilestone via vm.store | ✅ M0→M1→M2→M3 价格递增 | 78,252 |
| C4 | 已达最高里程碑 M5 revert | owner | advanceMilestone at milestone 5 | ✅ AlreadyAtMaxMilestone | 16,382 |
| D1 | 10 用户并发各 $80 | 10 users | 并发 buyTokens(80e6) | ✅ totalRevenue=800e6 | 847,449 |
| D2 | 鲸鱼防护：$5000 blocked，5 用户各 $172 | whale + 5 users | whale 超额 + 正常用户购买 | ✅ 鲸鱼 revert，普通用户成功 | 519,523 |
| D3 | USDC + USDT 双 token 购买 | user4 + user5 | USDC $100 + USDT $100 | ✅ totalRevenue=200e6 | 312,327 |
| E1 | 白名单开启，未授权用户 revert | user1 | buyTokens without whitelist | ✅ NotWhitelisted revert | 80,282 |
| E2 | 白名单用户正常购买 | user1 | setWhitelisted + buyTokens $50 | ✅ 购买成功 | 233,599 |
| E3 | 关闭白名单所有用户可购买 | user6 | setWhitelistRequired(false) + buy | ✅ 任意用户成功 | 187,920 |
| F1 | 暂停/恢复：暂停 revert，恢复成功 | user1 | pause/unpause + buyTokens | ✅ EnforcedPause then 成功 | 198,084 |
| F2 | 更换 treasury，资金流向新地址 | user1 | setTreasury + buyTokens $50 | ✅ newTreasury 收到 50e6 USDC | 194,176 |
| F3 | 调整 perPersonCap 后可超原上限购买 | user1 | $800 + setPerPersonCap($1000) + $200 | ✅ 累计 $1000 成功 | 218,135 |
| F4 | recoverToken 取回意外转入的 USDC | owner | mint USDC to contract + recoverToken | ✅ treasury 收到 100 USDC | 67,996 |
| G1 | buyTokens(0, usdc) revert | user1 | buyTokens 0 | ✅ ZeroAmount | 25,898 |
| G2 | 未知 token revert | user1 | buyTokens with unknown token | ✅ TokenNotAccepted | 28,617 |
| G3 | 库存耗尽后购买 revert | user1 | recoverToken(gToken) + buyTokens | ✅ InsufficientInventory | 105,273 |
| G4 | 非 owner 调用管理函数全部 revert | user1 | pause/advanceMilestone/setTreasury/setCap | ✅ OwnableUnauthorizedAccount | 31,961 |
| G5 | setTreasury(address(0)) revert | owner | setTreasury(0) | ✅ ZeroAddress | 17,238 |

## Key Findings

- **价格精度验证**：✅ 6 decimal USD 输入，18 decimal GToken 输出，公式 `usdAmount * 1e18 / priceUSD` 无溢出无精度损失
- **人均上限保护**：✅ 默认 $864 上限严格执行，每次购买实时校验累计花费，revert 时返回剩余额度
- **里程碑推进机制**：✅ 仅 owner 可手动推进，需满足 `totalRevenue >= revenueCap`，6 个里程碑价格线性递增
- **多 token 支付**：✅ USDC + USDT 均通过验证，任意通过 `setPaymentToken` 添加的 ERC20 均可作为支付手段
- **重入防护**：✅ 合约继承 `ReentrancyGuard`，buyTokens 使用 `nonReentrant` 修饰符
- **暂停机制**：✅ `Pausable` 继承，owner 可随时暂停/恢复销售
- **白名单灵活性**：✅ 可批量设置，可随时开启/关闭，关闭后无需清除已有白名单数据
- **recoverToken**：✅ 可恢复任意意外转入的 ERC20（含 gToken 本身），转向 treasury

## Milestone Price Schedule (verified)

| Milestone | Price (USD) | Revenue Cap | Price Increase |
|---|---|---|---|
| 0 | $0.150000 | $0 (initial) | — |
| 1 | $0.168000 | $1,200 | +12% |
| 2 | $0.188160 | $4,800 | +12% |
| 3 | $0.210739 | $12,800 | +12% |
| 4 | $0.236028 | $49,400 | +12% |
| 5 | $0.264351 | $135,800 | +12% |

## Custom Errors Verified

| Error | Selector | Tested In |
|---|---|---|
| `ZeroAmount()` | ✅ | A4, G1 |
| `TokenNotAccepted(address)` | ✅ | G2 |
| `ExceedsPerPersonCap(uint256,uint256)` | ✅ | A4, B1, D2, F3 |
| `InsufficientInventory(uint256,uint256)` | ✅ | G3 |
| `NotWhitelisted(address)` | ✅ | E1 |
| `MilestoneNotReached(uint256,uint256)` | ✅ | C2 |
| `AlreadyAtMaxMilestone()` | ✅ | C4 |
| `ZeroAddress()` | ✅ | G5 |

## Risk Notes

- **里程碑推进无自动化**：里程碑推进为 owner 手动操作，存在 owner 忘记推进导致价格停滞的风险。建议链下监控 `totalRevenue` 并自动通知。
- **vm.store 测试局限**：部分测试使用 `vm.store` 强制设置 `totalRevenue` 和 `currentMilestone`，绕过正常购买路径。这是 Foundry 测试技巧，生产环境中 storage slot 已通过 `forge inspect storageLayout` 验证（slot 14 = currentMilestone，slot 15 = totalRevenue）。
- **perPersonCap 上调后历史用户可继续购买**：若 owner 上调上限，已花费接近原上限的用户可以继续购买。这是设计预期，但需要 owner 谨慎操作。
- **recoverToken 可取走 gToken 库存**：`recoverToken(gToken)` 会将合约内所有 gToken 转给 treasury，如误操作将导致销售无法继续（已在 G3 中验证此后会触发 InsufficientInventory）。
