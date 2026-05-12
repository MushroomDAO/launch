# 07 — 销售路径现状 + Gasless TODO 待办

> **快照时间**：2026-05-02
> **目的**：把"用户路径有几条 / 哪条已通 / 哪条卡在哪"摊清楚，作为后续工作的源真相。
> **背景**：5-18 杭州路演前，**MetaMask + USDC 直购**这条路已经可演示；EIP-7702 gasless 这条路还有 4 个外部依赖待部署。

---

## A. 用户路径全图

```
                      ┌──────────────────────────┐
                      │  用户打开 launch.mushroom.cv  │
                      └────────────┬─────────────┘
                                   │
                       连接 MetaMask（Sepolia）
                                   │
            ┌──────────────────────┴──────────────────────┐
            │                                              │
       账户有 ETH ✅                              账户没 ETH ❌
            │                                              │
            ▼                                              ▼
  ┌─────────────────┐                          ┌──────────────────────┐
  │ 流程 A：USDC 直购 │                          │ 流程 B：EIP-7702 gasless │
  │ （已通，路演可演示）│                          │ （代码完成，部署阻塞）  │
  └─────────────────┘                          └──────────────────────┘
            │                                              │
            ▼                                              ▼
  USDC.approve(SaleV2)                       签 7702 delegation →
  Sale.buyTokens($, USDC, 0)                 AirAccountDelegate
            │                                              │
            ▼                                              ▼
  user 自付 gas                              relayer 代付 gas
            │                                              │
            ▼                                              ▼
   收到 GT （SBT 门票预备）                          同上
```

---

## B. 现状盘点（什么能跑、什么不能）

### B.1 ✅ 流程 A：USDC 直购（已通）

| 维度 | 状态 |
|------|------|
| 销售合约 | `SaleContractV2` 部署 + verified, `0xD2E2566566D459115D4159993E96c45c0d2cE6CD` |
| Token | `MockGToken` 部署 + verified, `0x25c78eF9830b9b7a705B1E5b19939dFB465fF37F` |
| 库存 | **855,000 GT** 已注入 SaleV2 |
| 接受支付 | **USDC**（Circle Sepolia 官方 `0x1c7D4B...`）|
| Owner | ANNI `0xEcAACb91...`（可调 milestone 扩展）|
| Whitelist | 关闭（任何人可买）|
| Per-person cap | $864 |
| 前端 | `site/join.html` 已切到 V2 地址 + version v2.0.0 |
| 部署 | launch.mushroom.cv 已 wrangler 推到 main 分支 |
| Fork 测试 | 5/5 通过（实际链上 V2 合约 + 真实 milestone 跳变 + per-person cap 守护）|

**用户操作步骤（路演演示版）**：
1. 打开 https://launch.mushroom.cv/join.html
2. MetaMask 切 Sepolia + 连接
3. 钱包需有 Sepolia ETH（faucet）+ Sepolia USDC（[Circle faucet](https://faucet.circle.com/)）
4. 输入金额（建议 $15 试水）
5. MetaMask 弹两次签名：① `USDC.approve(SaleV2, $)` ② `SaleV2.buyTokens($, USDC, 0)`
6. 链上确认后钱包多 100 GT（在 MetaMask 里 Add Token import `0x25c78eF9...37F` 才能看到余额）

### B.2 ❌ 流程 B：EIP-7702 Gasless（部署阻塞中）

| 阻塞项 | 状态 | 谁来解 |
|--------|------|--------|
| Relayer 代码 | ✅ 完成 + 2 轮 review fix（services/relayer/）| — |
| Relayer 部署到 Cloudflare | ⚠️ URL 占位 `mycelium-relayer.workers.dev`，未真正 wrangler deploy | 我（拿到所有依赖地址后）|
| **SuperPaymaster 合约（指向 MockGToken）** | ❌ 未部署 | **你** 部 → 把地址给我 |
| **Registry 合约（指向 MockGToken）** | ❌ 未部署 | **你** 部 → 把地址给我 |
| **AirAccountDelegate 合约** | ❌ 未部署 | **你** 部 → 把地址给我 |
| **mPNTs (Membership PNTs) 合约** | ❌ 未部署 | **你** 部 → 把地址给我 |
| Relayer wrangler vars 配置 | ⏸️ 等上面 4 个地址 | 我 |
| `launch.html` 4 个 TODO 常量填入 | ⏸️ 等上面 4 个地址 | 我 |
| join.html ETH 自动检测分流 | ⏸️ 中等前端工作 | 我（路演后做）|
| 单页融合（join + launch）| ⏸️ 中等前端工作 | 我（路演后做）|

**当前请求状态**：所有 gasless 请求被 `services/relayer/src/index.ts:101` 守卫拦截，返回 503 `INFRA_NOT_READY`。

---

## C. 等你回填的地址（路演后整合）

请在以下合约部署完后，按格式发给我：

```
SUPERPAYMASTER (Sepolia)        : 0x________________________________
REGISTRY (Sepolia, MockGToken-bound)   : 0x________________________________
AIRACCOUNT_DELEGATE (Sepolia)   : 0x________________________________
MPNTS (Sepolia)                  : 0x________________________________
RELAYER_OPERATOR_ADDRESS         : 0x________________________________
（OPERATOR_PK 走 wrangler secret，不要发明文）
```

收到后我会做：

1. **wrangler vars 配置**
   ```toml
   # services/relayer/wrangler.toml
   REGISTRY_ADDRESS = "..."
   MPNTS_ADDRESS = "..."
   AIRACCOUNT_DELEGATE = "..."
   ```
2. **launch.html 4 个 const 填入**
   ```js
   const SUPERPAYMASTER     = "0x...";
   const MUSHROOM_OPERATOR  = "0x...";
   const AIRACCOUNT_DELEGATE = "0x...";
   const MPNTS              = "0x...";
   ```
3. **wrangler deploy** services/relayer/ 到 Cloudflare（拿到真正的 worker URL，替换 launch.html 的 RELAYER_URL）
4. **fork-Sepolia 集成测试**：模拟无 ETH 用户的完整 7702 流程
5. **launch.html 端到端 demo**

---

## D. 关于 USDT / 多币种支付

- **Sepolia 测试网没有 Circle 或 Tether 官方 USDT**——社区版本质量不一，无权威。
- **SaleV2 当前不接受 USDT**。如果想支持：需要 ANNI 调 `setPaymentToken(usdtAddr, true)`，前提是该 token 是 6 decimals。
- **主网（Ethereum / Optimism）**：上线时再接 Circle USDC + Tether USDT，两个都是 6 decimals 兼容 V2 合约。
- 当前优先级：**低**——MVP 先用 USDC 跑通，主网再加 USDT。

---

## E. 路演 5-18 演示脚本（USDC 直购版）

如果你在 demo day 想现场演示买入：

1. 浏览器打开 https://launch.mushroom.cv/join.html
2. 切到 MetaMask Sepolia 网络（提前在 MetaMask 加好 Sepolia）
3. 钱包预先准备好：≥ 0.01 Sepolia ETH + ≥ $15 Sepolia USDC（提前 faucet）
4. 点击 Connect Wallet → 输入 `15` → 点 Buy
5. **第一次签名**：USDC.approve（钱包弹"允许 SaleV2 花你的 USDC"）
6. **第二次签名**：buyTokens（实际花费 $15 USDC、收到 100 GT）
7. 等 12-15 秒区块确认 → UI 显示 "Purchase complete"
8. 切到 Etherscan tab：粘贴 SaleV2 地址，看 `totalRevenue` / `totalTokensSold` 实时更新
9. 切到 MetaMask tokens：Import token `0x25c78eF9...37F` → 看到 100 GT

**风险预案**：
- 如果 Sepolia 网络拥堵 → gas 飙高 → 演示卡住，说"测试网偶尔慢，主网上线时用 SuperPaymaster gasless 化"
- 如果 USDC 余额不够 → 当场 faucet 拿、或换更小金额（最小 1 USDC）
- 如果 MetaMask 拒签 → 检查是否 Sepolia 网络

---

## F. 时间窗口建议

| 阶段 | 内容 | 截止 |
|------|------|------|
| **5-18 路演前** | 流程 A（USDC 直购）现场演示。Gasless 留作"已开发、待部署" | 2026-05-18 |
| **路演后 1 周内** | 你部署 SP/Registry/Delegate/mPNTs → 给我地址 | 2026-05-25 |
| **路演后 2 周内** | 我接入 + relayer 部署 + 端到端测试 | 2026-06-01 |
| **路演后 3-4 周** | join.html ETH 自动检测分流 + 单页融合 | 2026-06-15 |
| **主网上线前** | 接 Circle USDC（主网）+ Tether USDT 双支付 | 待定 |
