# Gasless 购买 GToken — 完整方案与实施计划

> 最后更新：2026-04-17
> 状态：计划确认中，待启动

---

## 0. 目标

让**任何 EOA 用户**（典型画像：从 CEX 提了 USDC/USDT，钱包里 0 ETH）能够用一次签名购买 GToken，无需持有任何 ETH。

核心约束：
- 支持 USDC 和 USDT（必须都能用）
- 用户无需持有 ETH
- 用户钱包可以是标准 MetaMask/Ambire/Rabby 等支持 EIP-7702 的 EOA 钱包
- 不强制使用 AA 账户或 SuperPaymaster 生态，但**复用**现有基础设施

---

## 1. 用户端体验（End-to-End UX）

### 1.1 典型路径：USDC 用户，0 ETH，第一次购买

```
[进入 sale.html]
    │
    ▼
[连接钱包]
    │  检测：USDC 余额 ✓, ETH = 0, 钱包支持 7702
    ▼
[选择金额]
    │  例如输入 $50
    │  页面显示：
    │    · 你将支付 50 USDC
    │    · 你将收到约 333 GT（按当前 milestone 价格 $0.15）
    │    · 其中 0.3 GT 作为社区成员入会费（SBT ticket）
    │    · Gas 由 Mycelium 社区赞助，你无需持有 ETH
    ▼
[点击「购买」]
    │
    │  弹出 2 次签名确认：
    │  ① EIP-7702 Authorization
    │     "允许将此钱包临时升级为智能账户（AirAccountDelegate）"
    │  ② UserOp Signature（EIP-712）
    │     "购买 333 GT，支付 50 USDC"
    │
    ▼
[提交到 relayer]
    │  POST /relay
    │  前端轮询状态
    │
    ▼
[链上执行 ~5-15 秒]
    │
    ▼
[成功页]
    ├─ 你收到了 332.7 GT（扣除 0.3 GT SBT 入会费后的净额）
    ├─ 你的 SBT #tokenId 已发放（Mycelium 社区成员）
    ├─ Etherscan 交易链接
    └─ 下一步：加入社区 Discord / 阅读协议文档
```

### 1.2 用户最终获得

- ✅ GToken（扣除 SBT 入会费后的净额）
- ✅ Mycelium ENDUSER SBT（社区成员身份）
- ✅ EOA 已通过 7702 升级为 AirAccountDelegate（未来可通过持有 aPNTs 持续 gasless）
- ✅ USDC 按数额扣除（转入社区金库 Safe）
- ✅ ETH 余额不变（0 全程）
- ✅ 无任何债务记录

### 1.3 其他路径的分支

| 场景 | 走哪条路 |
|------|---------|
| 用户有 ETH + USDC/USDT | 传统 `SaleContract.buyTokens()`，不走 gasless 路径 |
| 用户 0 ETH，USDC | 本方案 gasless 路径，USDC 用 EIP-2612 permit（跳过 7702 也可能，待权衡） |
| 用户 0 ETH，USDT | 本方案 gasless 路径，**必须走 7702**（USDT 无 permit） |
| 钱包不支持 7702 | 前端提示升级钱包，或引导购买少量 ETH |
| 用户已有 SBT（重复购买） | 跳过 safeMintForRole 步骤，其余流程不变 |

### 1.4 重复购买（第二次及之后）

- 第一次购买时已获得 SBT + 7702 delegation
- 之后再买：bundler 检测到已有 SBT，跳过 SBT 发放；7702 delegation 也保留
- 流程更简短：只需签 UserOp，不需要再签 7702 auth

---

## 2. 架构总览

```
┌──────────────────┐          ┌──────────────────┐
│     Frontend     │          │   User's Wallet  │
│   sale.html      │◀────────▶│  (MetaMask 12+)  │
│   (Cloudflare)   │  签名请求  │    EOA + USDC    │
└────────┬─────────┘          └──────────────────┘
         │ POST /relay
         ▼
┌──────────────────────────────┐
│  Relayer (Cloudflare Worker) │
│  - 解析 UserOp                │
│  - 规则校验                   │
│  - 编排链上 multicall         │
│  - Hot wallet 付 ETH gas     │
└────────┬─────────────────────┘
         │
         ▼ Type 4 tx (authList + multicall)
┌──────────────────────────────────────────────────┐
│                    On-chain                      │
│                                                  │
│  ┌────────────┐  ┌──────────────┐  ┌──────────┐ │
│  │  Registry  │  │  MPNTs Token │  │EntryPoint│ │
│  │ (SBT发放)  │  │(mint给user) │  │(handleOps│ │
│  └────────────┘  └──────────────┘  └────┬─────┘ │
│                                          │       │
│        ┌──────────────────┐  ┌─────────▼──────┐ │
│        │ AirAccountDelegate│  │ SuperPaymaster │ │
│        │ (7702 运行时)    │◀▶│ (validate+burn)│ │
│        └──────────┬───────┘  └────────────────┘ │
│                   │                              │
│        ┌──────────▼──────┐   ┌──────────────┐  │
│        │  SaleContract   │──▶│   Treasury   │  │
│        │  (buyTokens)    │   │    (Safe)    │  │
│        └─────────────────┘   └──────────────┘  │
└──────────────────────────────────────────────────┘
```

### 2.1 关键角色说明

| 角色 | 职责 | 是否新建 |
|------|------|---------|
| **MushroomCommunity** | 在 Registry 注册的社区身份，有 `ROLE_COMMUNITY` + `ROLE_PAYMASTER_SUPER` | 新建（链上注册动作，无合约代码）|
| **MushroomOperator** | 与 MushroomCommunity 同地址，在 SuperPaymaster 作为 operator 配置 | 同上 |
| **MPNTs (xPNTs)** | Mycelium 社区发行的 gas 积分 token | 新建（通过 xPNTsFactory.createToken）|
| **SaleContract** | 已部署在 Sepolia `0x9cA2520D...`，**零改动** | 已存在 |
| **AirAccountDelegate** | 7702 delegate 合约，实现 ERC-4337 账户接口 | 已存在（`airaccount-contract` 仓库）|
| **SuperPaymaster** | 已部署，**需要一个小 PR 恢复 burnFromWithOpHash** | 已存在（需修复）|
| **Relayer** | Cloudflare Worker，编排链上 multicall，付 gas | 新建 |
| **sale.html** | 销售前端页面 | 新建（替换 join.html）|

---

## 3. 核心机制：两次扣款（恢复 V3 原始设计）

SuperPaymaster 原始设计是"两次扣款"：
1. **扣用户 xPNTs 余额**（MushroomOperator 的 MPNTs token）—— 用 `burnFromWithOpHash`
2. **扣社区 aPNTs 池**（SuperPaymaster 里预存的 operator 预算池）

这个设计在 V3.2 "simplify" 时被删除了（commit `4148c5b`），改为仅记债（`recordDebt`）。我们这次顺带通过 PR 恢复。

### 3.1 为什么这个设计对新用户合理

- 用户通过 bundler **预先**获得足够的 MPNTs 余额（pre-mint）
- 交易执行时 SuperPaymaster 直接从用户余额 burn
- 不产生债务 → 不依赖信用 / reputation
- 语义清晰：付费即用

---

## 4. 交易流程（链上动作详解）

### 4.1 第一次购买（完整流程）

**前置状态**：
- User EOA：USDC > 0, ETH = 0, 无 SBT, 无 MPNTs, 无 7702 delegation
- MushroomOperator：aPNTs 池已预存充足额度（社区金库维护）

**Relayer 提交一个 Type-4 tx，包含：**

```
authorizationList: [
  { chainId, address: AirAccountDelegate, nonce: user.nonce, sig: userSignedAuth }
]

calldata: multicall([
  // 步骤 A: 注册用户为 ENDUSER
  Registry.safeMintForRole(
    ROLE_ENDUSER, 
    user, 
    encode(EndUserRoleData{community: MushroomCommunity, ...})
  ),
  
  // 步骤 B: Mint MPNTs 给用户（覆盖本次 UserOp 的 xPNTs 预估）
  MPNTs.mint(user, predictedXPNTsForThisOp),
  
  // 步骤 C: 初始化 AirAccountDelegate（如果首次）
  //   注：可能需要以 user 的身份自调用，细节待实现阶段确认
  user.initialize(noGuardians, unlimitedDailyLimit),
  
  // 步骤 D: 执行 UserOp
  EntryPoint.handleOps([userOp], beneficiary)
])
```

**UserOp 内容**：
```
sender: user EOA (已通过 7702 升级)
callData: executeBatch([
  USDC.approve(SaleContract, usdcAmount),
  SaleContract.buyTokens(usdAmount, USDC, minTokensOut)
])
paymasterAndData: [SuperPaymaster | gasLimits | MushroomOperator | maxRate]
signature: 用户签的 EIP-712
```

**handleOps 内部执行**：

```
EntryPoint → SuperPaymaster.validatePaymasterUserOp(userOp, hash, maxCost)
  ├─ isEligibleForSponsorship(user)？ → ✓ (刚才发了 SBT)
  ├─ operator 未 paused？ → ✓
  ├─ maxCost 计算：aPNTsAmount 估算
  ├─ config.aPNTsBalance >= aPNTsAmount？ → ✓ (社区池有钱)
  └─ config.aPNTsBalance -= aPNTsAmount  ← 第二次扣款：社区 aPNTs 池

EntryPoint → user.validateUserOp(userOp, hash)
  └─ 验证签名，返回 valid

EntryPoint → user.execute(callData) （通过 AirAccountDelegate.executeBatch）
  ├─ USDC.approve(SaleContract, amount)
  ├─ SaleContract.buyTokens(usd, USDC, minOut)
  │     ├─ 把用户 USDC 转到 Treasury
  │     ├─ 把 GToken 转给 user
  │     └─ Emit TokensPurchased
  └─ 成功返回

EntryPoint → SuperPaymaster.postOp(mode, context, actualGasCost)
  ├─ 计算 finalCharge in xPNTs
  ├─ try: burnFromWithOpHash(user, xPNTsAmount, userOpHash)   ← 第一次扣款：用户 MPNTs
  │     └─ 成功：用户 MPNTs 从 predictedXPNTs 降到 ~0
  ├─ catch: fallback 到 recordDebt（仅在 balance 不足时）
  └─ 退差额到 aPNTs 池（若 actual < estimated）
```

**最终状态**：

| 账户 | 变化 |
|------|------|
| User EOA | USDC -50, GToken +332.7, SBT +1, MPNTs = 0, ETH 不变, 7702 delegation ✓ |
| Treasury | USDC +50 |
| MushroomCommunity | (一次性)GT -0.3 (ticketPrice) |
| MushroomOperator aPNTs 池 | -actualGasCost 等价 |
| Relayer hot wallet | ETH -gas |

### 4.2 第二次购买（简化版）

用户已经是 SBT 持有者、已有 7702 delegation，所以：

```
Relayer 提交一个普通 tx（不再需要 Type-4）：

multicall([
  MPNTs.mint(user, predictedXPNTsForThisOp),
  EntryPoint.handleOps([userOp], beneficiary)
])
```

---

## 5. 两条并行开发轨道

### 轨道 A：SuperPaymaster 恢复 burnFromWithOpHash（PR）

**状态**：独立任务，目标是把 V3.2 "simplify" 砍掉的两次扣款逻辑加回来。

#### 改动清单

1. **`contracts/src/paymasters/superpaymaster/v3/SuperPaymaster.sol`**
   - `postOp` 的 line 860 和 line 873：把 `recordDebt` 改为 "try `burnFromWithOpHash` first, fallback to `recordDebt`"
   - `userOpHash` 已在 context 里（line 813），可直接传给 `burnFromWithOpHash`

2. **测试新增**
   - `burn-success-path`：用户有足够 MPNTs 余额 → burn 成功，余额减少，无 debt
   - `debt-fallback-path`：用户无余额 → burn revert → 走 `recordDebt`，行为兼容现状
   - `replay-protection`：同一 userOpHash 不能被 burn 两次
   - `single-tx-limit`：超过 MAX_SINGLE_TX_LIMIT 时 revert
   - `exchange-rate-correctness`：xPNTs 扣除量 = aPNTsAmount × exchangeRate
   - `postOp-revert-safety`：burn 失败 → fallback → protocolRevenue 正确结算

3. **UUPS 升级**
   - SuperPaymaster 是 UUPS 可升级，技术上可以部署新实现并调 `upgradeTo`
   - 部署脚本：新增 `scripts/UpgradeSuperPaymasterV3_6.s.sol`（版本号待定）
   - 上线：Sepolia 先升级验证，然后主网

#### PR 内容模板

```
Title: restore: use burnFromWithOpHash in postOp (reverse V3.2 simplification)

Summary:
Original V3 paymaster had a "two-deduction" model:
  (1) validation → burnFromWithOpHash(user, xPNTs, hash)  — burn from user balance
  (2) validation → config.aPNTsBalance -= aPNTsAmount     — deduct operator pool

Commit 4148c5b ("simplify credit system debt recording") removed (1) because 
userOpHash wasn't available in postOp context at that time. This left only the
operator-pool deduction + recordDebt in postOp.

Current state:
- burnFromWithOpHash() is fully implemented in xPNTsToken (with replay 
  protection), but unused by SuperPaymaster
- userOpHash is now available in postOp context (SP.sol:813)
- The design gap blocks use cases (e.g. onboarding) where pre-funded xPNTs 
  balance is the natural payment model, not credit/debt

This PR:
- In postOp: try burnFromWithOpHash first; if revert (balance insufficient), 
  fallback to recordDebt
- Fully backward compatible: existing operators that rely on debt model 
  continue working
- Onboarding operators (new paymaster users with pre-minted xPNTs) can now 
  use the direct-burn path

Tests:
- New test suite: SuperPaymaster_BurnFallback.t.sol (6 scenarios)
- All existing 400 tests pass
- Gas measurements unchanged within ±2%

Security review:
- replay protection: userOpHash uniqueness enforced by xPNTsToken
- fallback safety: if burn reverts, state is consistent (try/catch outer)
- single-tx cap: xPNTsToken.MAX_SINGLE_TX_LIMIT still applies
```

#### 时间估算
- 代码 + 单测：1-2 天
- Codex review + 修改：1-2 天
- @fanhousanbu review + 修改：1-2 天（取决于响应）
- Sepolia 升级部署 + 验证：0.5 天
- 总计：4-7 天

---

### 轨道 B：Launch 侧销售开发（并行）

**假设前提**：轨道 A 在销售上线前 merge 并升级到 Sepolia。如果没按时：
- 先用 Sepolia 的老 SP（带 recordDebt）做联合测试，账本上会有 DebtRecorded event（但不影响功能）
- 等 A merge 后重新验收

#### B.1 合约动作（非新合约，纯部署/配置）

所有步骤在一个部署脚本里完成 `contracts/script/v3/DeployMushroomCommunityAndOperator.s.sol`：

1. **注册 MushroomCommunity**
   ```
   Registry.registerRole(
     ROLE_COMMUNITY,
     mushroomAdminEOA,
     encode(CommunityRoleData{
       name: "Mycelium",
       ensName: "mycelium.eth",
       website: "https://launch.mushroom.cv",
       description: "Mycelium Protocol — digital public goods garden",
       logoURI: "...",
       stakeAmount: 0  // 用默认 minStake (0 for COMMUNITY) + 30 GT ticketPrice
     })
   )
   ```
   - 需要 MushroomCommunity 地址预先有 30 GT（从社区金库转入）

2. **注册 MushroomCommunity 为 PAYMASTER_SUPER**
   ```
   Registry.registerRole(ROLE_PAYMASTER_SUPER, mushroomAdminEOA, roleData)
   ```

3. **通过 xPNTsFactory 发行 MPNTs**
   ```
   xPNTsFactory.createToken(
     name: "Mycelium Gas Points",
     symbol: "MPNTs",
     exchangeRate: 1e18  // 1 MPNTs = 1 aPNTs
   )
   ```
   - 工厂自动将 SuperPaymaster 加入 `autoApprovedSpenders`

4. **SuperPaymaster.configureOperator**
   ```
   SuperPaymaster.configureOperator(
     xPNTsToken: MPNTsAddress,
     treasury: mushroomTreasurySafe,
     exchangeRate: 1e18
   )
   ```

5. **预存 aPNTs 到 MushroomOperator 池**
   ```
   aPNTsToken.approve(SuperPaymaster, 1000e18)
   SuperPaymaster.deposit(1000e18)  // 例如先存 1000 aPNTs 做 Sepolia 测试
   ```

#### B.2 Relayer 开发（Cloudflare Worker）

**目录**：`services/relayer/`

```
services/relayer/
├── src/
│   ├── index.ts              # Worker 入口，POST /relay
│   ├── validators/
│   │   ├── userOpParser.ts   # 解析 callData 确认形状
│   │   └── intentCheck.ts    # 校验 deadline / chainId / amount cap
│   ├── builders/
│   │   ├── multicall.ts      # 构造 multicall calldata
│   │   └── type4Tx.ts        # 构造 EIP-7702 Type-4 tx
│   ├── submit/
│   │   ├── hotWallet.ts      # viem WalletClient, private key in env
│   │   └── retry.ts          # 失败重试（仅幂等操作）
│   ├── rate-limit.ts         # 每 buyer 地址 5 分钟最多 3 次
│   └── config.ts             # 各合约地址
├── wrangler.toml
├── package.json
└── README.md
```

**关键 endpoint**：
- `POST /relay` — 接收 `{userOp, authorization, intent}`，提交上链
- `GET /health` — 健康检查
- `GET /price` — 返回当前 milestone 价格 + 剩余库存（给前端）

**规则校验（`validators/userOpParser.ts`）**：
```typescript
function validateSaleUserOp(userOp) {
  // 1. 解析 callData = executeBatch(targets[], values[], data[])
  const decoded = decodeFunctionData({
    abi: AirAccountDelegateAbi,
    data: userOp.callData
  });
  
  assert(decoded.functionName === 'executeBatch');
  const [targets, values, datas] = decoded.args;
  assert(targets.length === 2);
  
  // 2. 第 1 笔必须是 USDC/USDT.approve(SaleContract, *)
  assert(targets[0] === USDC_ADDRESS || targets[0] === USDT_ADDRESS);
  const approveCall = decodeFunctionData({ abi: erc20Abi, data: datas[0] });
  assert(approveCall.functionName === 'approve');
  assert(approveCall.args[0] === SALE_CONTRACT_ADDRESS);
  
  // 3. 第 2 笔必须是 SaleContract.buyTokens(...)
  assert(targets[1] === SALE_CONTRACT_ADDRESS);
  const buyCall = decodeFunctionData({ abi: saleContractAbi, data: datas[1] });
  assert(buyCall.functionName === 'buyTokens');
  
  // 4. 检查 paymaster 指向 MushroomOperator
  const operator = extractOperator(userOp.paymasterAndData);
  assert(operator === MUSHROOM_OPERATOR_ADDRESS);
  
  return { approvedAmount, buyIntent };
}
```

**上链流程（`builders/multicall.ts`）**：
```typescript
async function buildAndSubmit({ userOp, authorization, isFirstTime }) {
  const calls = [];
  
  if (isFirstTime) {
    // 发 SBT
    calls.push({
      target: REGISTRY,
      data: encodeFunctionData(Registry.safeMintForRole, [
        ROLE_ENDUSER, userOp.sender, encodeEndUserData(...)
      ])
    });
  }
  
  // Mint MPNTs (预估 gas × 1.2 倍安全系数)
  const predictedXPNTs = estimateXPNTs(userOp, 1.2);
  calls.push({
    target: MPNTS,
    data: encodeFunctionData(MPNTs.mint, [userOp.sender, predictedXPNTs])
  });
  
  // handleOps
  calls.push({
    target: ENTRY_POINT,
    data: encodeFunctionData(EntryPoint.handleOps, [[userOp], BENEFICIARY])
  });
  
  // 构造 Type-4 tx（authList + multicall）
  const tx = {
    type: 0x04,
    authorizationList: isFirstTime ? [authorization] : [],
    to: MULTICALL3,
    data: encodeMulticall3(calls)
  };
  
  return await hotWalletClient.sendTransaction(tx);
}
```

**Hot wallet**：
- 环境变量 `RELAYER_PRIVATE_KEY`（Cloudflare Secrets）
- 初始余额 0.1 ETH on Sepolia，0.5 ETH on mainnet
- 告警：余额 < 0.05 ETH 时通过 Slack/email 告警

**速率限制**：
- Cloudflare KV：`rate:${buyerAddress}` → `{count, resetAt}`
- 每 buyer 每 5 分钟最多 3 次（防滥用）
- 全局每小时最多 1000 次（保护 hot wallet 余额）

#### B.3 前端开发（`site/sale.html`）

**替换现有 `site/join.html`**。

**技术栈**：
- 纯静态 HTML + `viem@2` 通过 esm.sh CDN
- 禁止 ethers.js（全局规则）
- 钱包连接：MetaMask / AirAccount / YetAnotherAA（禁止 WalletConnect）
- 部署：Cloudflare Pages

**关键交互**：

```javascript
// 1. 连接钱包
import { createWalletClient, custom } from 'https://esm.sh/viem';
const client = createWalletClient({ transport: custom(window.ethereum) });

// 2. 检测 7702 支持
const supports7702 = await detect7702Capability(client);

// 3. 读取余额 + 价格
const usdcBalance = await readContract({ ... });
const currentPrice = await readContract({ address: SALE, functionName: 'getCurrentPriceUSD' });

// 4. 签 7702 authorization
const authorization = await client.signAuthorization({
  chainId: SEPOLIA_ID,
  contractAddress: AIR_ACCOUNT_DELEGATE,
  nonce: await getNonce(user)
});

// 5. 构造并签 UserOp
const userOp = {
  sender: user,
  nonce: 0,
  callData: encodeExecuteBatch([
    { target: USDC, data: encodeApprove(SALE, amount) },
    { target: SALE, data: encodeBuy(usdAmount, USDC, minOut) }
  ]),
  paymasterAndData: encodePaymaster(MUSHROOM_OPERATOR, maxRate),
  // ... gas limits ...
};
const userOpHash = computeUserOpHash(userOp);
const signature = await client.signTypedData({ ... userOpHash ... });
userOp.signature = signature;

// 6. POST 到 relayer
const response = await fetch('/relay', {
  method: 'POST',
  body: JSON.stringify({ userOp, authorization })
});
const { txHash } = await response.json();

// 7. 轮询 tx 状态
const receipt = await waitForTransactionReceipt({ hash: txHash });

// 8. 显示成功
```

**UI 状态**：
- 初始：连接钱包
- 连接后：显示余额 + 购买表单
- 签名中：loading 动画 + "请在钱包中确认"
- 提交中：loading + "交易广播中…"
- 上链中：loading + etherscan 链接（pending）
- 成功：绿色 check + GT 数量 + SBT tokenId + Discord 邀请
- 失败：红色 × + 错误原因 + "联系社区"

---

## 6. 集成测试阶段（在轨道 A merge 后）

1. **Sepolia 部署 MushroomCommunity + Operator + MPNTs**
2. **部署升级后的 SuperPaymaster（已含 burnFromWithOpHash fix）**
3. **Relayer 部署到 Cloudflare Workers（staging env）**
4. **sale.html 部署到 launch.mushroom.cv/sale**
5. **PoC 测试场景**：
   - [ ] 一个 Sepolia EOA 从 0 ETH 开始，成功买到 GT
   - [ ] 验证：用户 USDC -amount, GT +net, SBT +1, MPNTs = 0, ETH = 0, 无 debt
   - [ ] 第二次购买流程正确（跳过 SBT 发放）
   - [ ] Relayer 规则校验：伪造 callData（比如加第三笔非法调用）应被拒
   - [ ] 速率限制生效（同一地址短时间内多次请求被限）
   - [ ] aPNTs 池耗尽后，SP 验证失败，tx 不上链
   - [ ] MPNTs mint 不足时，burn fallback 到 debt
6. **账本对账脚本**：扫链 + 导出 CSV，交叉验证每笔 tx 的收支
7. **主网上线 checklist**：
   - [ ] Sepolia PoC 连续跑通 10 笔真实用户测试
   - [ ] Codex/安全 review 过关
   - [ ] 主网 SuperPaymaster 升级
   - [ ] 主网 MushroomCommunity + Operator 配置
   - [ ] Treasury Safe 签名多签就位
   - [ ] 应急暂停按钮（SuperPaymaster 有 pause）验证

---

## 7. 风险与回滚

### 7.1 轨道 A（SP PR）相关

| 风险 | 缓解 |
|------|------|
| Burn fallback 路径引入 replay | `burnFromWithOpHash` 已含 `usedOpHashes` 映射防重放 |
| 升级引入 storage 冲突 | UUPS + `__gap[50]` 已留，但需严格按 UUPS 规范审计 |
| 现有 operator 因行为变更出问题 | `try/catch` 保持向后兼容，balance 不足时回退到原 recordDebt |

### 7.2 轨道 B（销售）相关

| 风险 | 缓解 |
|------|------|
| Relayer hot wallet 私钥泄露 | Cloudflare Secrets 存储、限额 0.5 ETH、每日限额、可一键 pause |
| aPNTs 池被耗尽 | 监控告警；紧急情况下 SaleContract 可 pause |
| 7702 delegation 被恶意利用 | `AirAccountDelegate.execute` 只接受 EntryPoint 或 self 调用；用户未调 `initialize` 时 `execute` revert |
| MPNTs 被用户拿去干别的 | bundler 只 mint 刚好够本次 gas 的量（预估 × 1.2）；买完余额 ~0 |
| 销售合约漏洞 | v1.2.1 已 Codex 3 轮 review + 79 tests + 20 E2E，短期不升级 |

### 7.3 回滚预案

- **轨道 A 升级出问题**：UUPS 可 `upgradeTo` 回滚到旧实现
- **Relayer 出问题**：Cloudflare instant rollback；或直接下线 /relay 端点
- **前端出问题**：Cloudflare Pages 回滚到上一版本
- **MushroomOperator 被恶用**：SuperPaymaster.setOperatorPaused(MushroomOp, true) — Owner only

---

## 8. 里程碑时间表

假设起点 2026-04-17，按顺序推进：

| 里程碑 | 任务 | 预计完成 |
|--------|------|---------|
| M1 | 轨道 A：SP burnFromWithOpHash restore PR 起草 + 本地测试通过 | +3 天 |
| M2 | 轨道 B：MushroomCommunity/Operator/MPNTs 部署脚本 + Sepolia 配置 | +5 天（并行）|
| M3 | 轨道 B：Relayer v0 完成，本地跑通规则校验 | +7 天（并行）|
| M4 | 轨道 B：sale.html UI 完成，能完整走完签名流程（mock relayer）| +10 天（并行）|
| M5 | 轨道 A：PR review + merge + Sepolia 升级 | +10 天 |
| M6 | 集成测试：端到端 PoC 跑通 | +12 天 |
| M7 | Sepolia 连续 10 笔真实用户测试 | +14 天 |
| M8 | 主网上线 | +17 天（视 review + 审计需求）|

---

## 9. MILESTONES.md 同步

本计划完成后，`MILESTONES.md §2` 的 gasless 购买 TODO 清单要按本文档节奏同步更新：
- §2.1 合约层 → 改为 "SP restore burn PR" + "零新合约"
- §2.2 Relayer → 保留，细化到本文档 §5.B.2
- §2.3 sale.html → 保留，细化到本文档 §5.B.3
- §2.4 新增：MushroomCommunity/Operator/MPNTs 部署脚本

---

## 10. 开放问题（实施阶段解决）

- [ ] `AirAccountDelegate.initialize()` 首次调用由谁发起？是否能在 Type-4 multicall 内完成？
- [ ] `AirAccountDelegate` 如果不 initialize 能否先只用 `validateUserOp` + `execute`？（看是否有 `NotInitialized` revert）
- [ ] SBT 的 0.3 GT ticketPrice 具体从哪里扣：SaleContract 内扣 vs 前端告知后用户接受 vs MushroomCommunity 金库先付
- [ ] USDC 路径是否也强制走 7702？还是 USDC 走 EIP-2612 permit 单独路径省一次签名？
- [ ] Relayer 的 UserOp 打包是否用 Multicall3 / Multicall2 / 自写 helper 合约？
- [ ] 主网 L 层选择：Ethereum mainnet（gas 贵但兼容度最高）vs OP mainnet（gas 便宜但 7702 支持需确认）

---

*本计划随实施进展更新。实施过程中的关键决策和变更记录在各 PR/commit message 中。*
