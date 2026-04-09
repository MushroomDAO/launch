# AirAccount / YetAnotherAA 集成参考

> 当前状态：**准备阶段** — sale.html 已预留 TODO 注释，实际集成待后端服务就绪后进行。

## 关键结论

| 特性 | AirAccount SDK | YetAnotherAA |
|------|---------------|--------------|
| npm 包 | `@aastar/airaccount@0.19.0` | 未发布（私有 monorepo） |
| CDN | 无 | 无 |
| 全局对象 | 无 `window.airaccount` | 无 |
| 交互方式 | 需要后端 API | REST API |
| 认证 | WebAuthn Passkey | WebAuthn Passkey |
| 签名 | BLS 12-381 + ECDSA P256 | BLS + Guardian |
| ERC-4337 | v0.6 / v0.7 / v0.8 | v0.6 / v0.7 |
| Gas 赞助 | SuperPaymaster 自动 | Paymaster 选择器 |

## 参考 Repo 路径

```
/Users/jason/Dev/mycelium/my-exploration/projects/airAccount-contract  — 合约层
/Users/jason/Dev/mycelium/my-exploration/projects/aastar-sdk            — SDK 入口
/Users/jason/Dev/aastar/YetAnotherAA                                    — 全栈 demo
  └── aastar-frontend/lib/api.ts      ← 前端 REST API 封装
  └── packages/sdk/src/               ← 后端 SDK（viem 2.x）
  └── packages/airaccount/src/        ← AirAccount 核心
```

## AirAccount SDK 集成方案

### 1. 安装

```bash
pnpm add @aastar/airaccount
```

### 2. 初始化（前端）

```typescript
import { YAAAClient } from "@aastar/airaccount";

const yaaa = new YAAAClient({
  apiURL: "https://your-backend-api/v1",     // 需要自建后端
  tokenProvider: () => localStorage.getItem("token"),
  bls: {
    seedNodes: ["https://signer1.aastar.io"], // BLS 节点
    discoveryTimeout: 5000,
  },
});
```

### 3. 用户认证

```typescript
// 注册（首次）
const { user, token } = await yaaa.passkey.register({
  email: "user@example.com",
  username: "JohnDoe",
});

// 登录（后续）
const result = await yaaa.passkey.authenticate();
```

### 4. 与 viem 集成购买 GToken

```typescript
import { createPublicClient, http } from "viem";
import { sepolia } from "viem/chains";

// 步骤1: Passkey 验证交易意图
const verification = await yaaa.passkey.verifyTransaction({
  to: SALE_CONTRACT,
  value: "0",
  data: encodeFunctionData({ abi: SALE_ABI, functionName: "buyTokens", args: [...] }),
});

// 步骤2: 后端接收签名，构建 ERC-4337 UserOp，提交到 bundler
// (需要后端服务实现)
```

## YetAnotherAA REST API 集成方案

### 前端 API 封装（参考 aastar-frontend/lib/api.ts）

```typescript
// 步骤1: 发起 Passkey 交易验证
const beginResp = await authAPI.beginTransactionVerification();

// 步骤2: 用户 WebAuthn 生物认证
import { startAuthentication } from "@simplewebauthn/browser";
const credential = await startAuthentication(beginResp.data);

// 步骤3: 执行转账（支持 ERC-20）
const tx = await transferAPI.execute({
  to: SALE_CONTRACT_ADDRESS,
  amount: usdAmount,
  passkeyCredential: credential,
  usePaymaster: true,            // SuperPaymaster 免 gas
  tokenAddress: USDC_ADDRESS,
});

// 步骤4: 轮询状态
const status = await transferAPI.getStatus(tx.data.transferId);
```

## 集成前置条件

集成 AirAccount / YetAnotherAA 需要：

1. **后端 API 服务** — 处理 Passkey 注册/验证、构建 UserOp、提交 bundler
2. **BLS 节点** — 用于 BLS 聚合签名（可使用 AAStar 提供的节点）
3. **Bundler** — ERC-4337 UserOp bundler（如 StackUp, Alchemy AA, 自建）
4. **Paymaster**（可选）— SuperPaymaster 赞助 gas

## 当前 sale.html 状态

- **已实现**：viem v2 ESM，标准 EIP-1193 钱包（MetaMask 等），USDC approve + buyTokens
- **TODO 注释位置**：`site/sale.html` → `connectWallet()` 函数上方
- **下一步**：等待 AAStar 后端 API 服务部署后，替换 `connectWallet()` 实现
