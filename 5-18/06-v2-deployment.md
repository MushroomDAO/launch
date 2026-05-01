# 06 — V2 部署记录（Sepolia）

> **部署时间**：2026-05-01
> **部署人**：ANNI 账户（broadcast）
> **目的**：把销售合约从 V1（4.2M GT 超额、6 段固定 milestone）升级到 V2（动态 milestone + 自动 +12% + 干净 token 供给）。

---

## 部署地址

| 合约 | 地址 | 角色 |
|------|------|------|
| **MockGToken**（GT V2） | `0x25c78eF9830b9b7a705B1E5b19939dFB465fF37F` | 测试网 governance token，owner = ANNI |
| **SaleContractV2** | `0xD2E2566566D459115D4159993E96c45c0d2cE6CD` | 动态 milestone 销售合约，owner = ANNI |
| Treasury Safe（不变） | `0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114` | Sepolia/Optimism 同地址多签 |
| USDC Sepolia（不变） | `0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238` | 接受的支付 token |

**Etherscan 验证**：两个合约都已提交，1–2 分钟内出验证结果。
- https://sepolia.etherscan.io/address/0x25c78eF9830b9b7a705B1E5b19939dFB465fF37F
- https://sepolia.etherscan.io/address/0xD2E2566566D459115D4159993E96c45c0d2cE6CD

---

## V2 vs V1 关键差异

| 维度 | V1 (`0x9cA2520D...`) | V2 (`0xD2E25665...`) |
|------|----------------------|----------------------|
| Milestone 存储 | `Milestone[6]` 固定 | `Milestone[]` 动态 |
| 扩展 milestone | ❌ 不能 | ✅ `addMilestone(price, cap)` / `addMilestoneAutoStep(cap)` |
| 自动 +12% 步进 | ❌ 不支持 | ✅ `addMilestoneAutoStep(cap)` 一行调用 |
| GToken owner | EIP-7702 委托账户（被 Alchemy 拒）| ANNI EOA |
| 销售容量 | 4.2M GT（超 6.86 倍）| 855K GT（精确到 $200K 上限）|
| 库存补充 | 不便 | 任何人 `transfer()` 即可（balanceOf 即库存）|
| Codex review | ✅ 三轮 | ⏳ 未做（路演前不做）|
| E2E test | 20 个 | 15 个（V2 测试，全过）|

---

## 当前状态（链上实查）

```
MockGToken
  totalSupply: 855,000 GT （全在 Treasury Safe）
  Treasury 余额: 855,000 GT
  SaleContractV2 余额: 0 GT  ← 等多签转账

SaleContractV2 v2.0.0
  owner:         ANNI ✅
  treasury:      Treasury Safe ✅
  gToken:        MockGToken ✅
  milestoneCount: 6
  currentMilestone: 0 (M0, $0.150/GT)
  inventory:     0  ← 等 Phase 2 转账
  USDC accepted: ✅
  whitelist:     ❌ (开放销售)
```

---

## Phase 2（待你手动操作）：Treasury → SaleV2

### 步骤
打开 **Sepolia Safe UI**（同 Optimism 多签门槛和签名人）：

🔗 https://app.safe.global/home?safe=sep:0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114

发起交易：
| 字段 | 值 |
|------|-----|
| **To** | `0x25c78eF9830b9b7a705B1E5b19939dFB465fF37F`（MockGToken）|
| **Method** | `transfer(address to, uint256 amount)` |
| **to** | `0xD2E2566566D459115D4159993E96c45c0d2cE6CD`（SaleContractV2）|
| **amount** | `855000000000000000000000`（= 855,000 × 10^18）|

按多签门槛收集签名 → 执行。

### 验证
```bash
cast call 0xD2E2566566D459115D4159993E96c45c0d2cE6CD 'availableInventory()(uint256)' \
  --rpc-url $SEPOLIA_RPC_URL2
# 应返回 855000000000000000000000 (8.55e23)
```

---

## V1 怎么办（参考 / 等定）

V1 (`0x9cA2520D...`) 仍然挂着 4.2M 老 GT (`0xa592eC5a...`)。两种处理方式：

| 选项 | 操作 | 结果 |
|------|------|------|
| **A. 直接放弃 V1** | 不动 V1，前端只指向 V2 | V1 那 4.2M 老 GT 还在合约里、销售可继续但走的是老 token；潜在混淆 |
| **B. 暂停 V1 + 撤回 GT** | 用 ANNI（V1 owner）调 `pause()` + `recoverToken(GTokenV1)` 把 4.2M 老 GT 退回 Treasury | 干净——V1 进入休眠态 |

**推荐 B**：杭州回来后任何时候都能跑（owner 是 ANNI）。

---

## 路线图：milestone 扩展示例

V2 跑完 $135.8K 后想接第二阶段销售：

```bash
# 例：$200K 后 +12% 阶梯到 $400K
cast send $SALE2 'addMilestoneAutoStep(uint256)' 200000000000 \
  --private-key $PRIVATE_KEY_ANNI --rpc-url $RPC
# → M6 = $0.296073 / GT @ $200K cap

cast send $SALE2 'addMilestoneAutoStep(uint256)' 280000000000 \
  --private-key $PRIVATE_KEY_ANNI --rpc-url $RPC
# → M7 = $0.331602 / GT @ $280K cap

# 也可直接指定价格（不走 +12%）
cast send $SALE2 'addMilestone(uint256,uint256)' 350000 400000000000 \
  --private-key $PRIVATE_KEY_ANNI --rpc-url $RPC
# → M8 = $0.350 / GT @ $400K cap
```

每次扩展后，库存可由 Treasury 多签 `transfer` 追加（GT 在合约里余额即库存，无特殊函数）。

---

## 下一步（路演前剩余）

- [ ] **Phase 2**：Treasury 多签转 855K GT 到 SaleV2（你做）
- [ ] **Etherscan 验证完成**（1-2 分钟自动）
- [ ] **Phase 3（可选）**：选项 B，pause + recoverToken V1
- [ ] **站点引用更新**（join.html / launch.html / token.html / relayer wrangler.toml）——等 Phase 2 完成后改
- [ ] **launch.html + join.html 合并 + ETH 自动检测分流**——路演后做
