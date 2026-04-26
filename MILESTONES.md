# Mycelium Launch — Milestones & TODO (Canonical)

> 合并来源：`docs/Roadmap/{Roadmap,Plan,Doing,logs-Progress}.md`、`contracts/docs/sale-plan.md`、`research/SuperPaymaster/1.8todo.md`
> 这里是单一事实来源（single source of truth）。其他文档保留历史上下文，但状态以本页为准。
> 最后更新：2026-04-17

---

## 0. 当前聚焦

**本轮目标**：GToken 销售合约 + 销售页面，支持"USDC/USDT 一笔签名购买"。用户无需 ETH，relayer 代付 gas。

---

## 1. 状态总览

### 1.1 合约（`contracts/src/`）

| 合约 | 版本 | 状态 | 部署 |
|------|------|------|------|
| `SaleContract` (GToken) | v1.2.1 | ✅ 上线 | Sepolia `0x9cA2520D...` |
| `APNTsSaleContract` (aPNTs) | — | ✅ 代码完成 | ❌ 未部署 |
| `SaleContract.buyWithPermit` (gasless) | — | ⏳ 待开发 | — |
| `APNTsSaleContract.buyWithPermit` | — | ⏳ 待开发 | — |
| `Relayer`（链下服务） | — | ⏳ 待开发 | — |

### 1.2 站点（`site/`）

| 页面 | 状态 | 说明 |
|------|------|------|
| `index.html` | ✅ 在线 | 首页 |
| `token.html` | ✅ 在线 | GToken 介绍 |
| `for-communities.html` | ✅ 在线 | 面向社区 |
| `sustainability.html` | ✅ 在线 | 可持续 |
| `dashboard.html` | ✅ 在线 | 仪表盘 |
| `architecture.html` | ✅ 在线 | 架构 |
| `join.html` | 🟡 主干保留 | 旧购买页，将替换为 `sale.html` |
| `sale.html` | 🟡 `feat/site-sale` 分支有草稿 | **本轮重做**：一笔签名 gasless 购买 |
| `cold-launch.html` | 🟡 feature 分支 | 冷启动叙事页，待合并 |

### 1.3 分支状态

| 仓库 | 分支 | 状态 | 处置 |
|------|------|------|------|
| launch | `main` | 当前主干 | — |
| launch | `feat/sale-contract` | v1.2.1 合约+测试，历史功能分支 | 大部分已 cherry-pick 到 main，可归档 |
| launch | `feat/site-sale` | 旧版购买页雏形 | 将被新的 gasless 实现取代 |
| launch | `feat/site-refine` | 页面细节优化 | 与 main 对比后决定合并 / 丢弃 |
| launch | `feat/site-docs-sync` | docs 同步 | 对比后处置 |
| SuperPaymaster | PR #84 `feat/ticket-model` | review 已 fix，等 @fanhousanbu re-review | 等 merge |
| SuperPaymaster | PR #88 `feat/remove-account-to-user` | 400 tests pass，等 #84 先 merge | 串联 |
| SuperPaymaster | PR #89 `chore/dependabot-scope-excludes` | 独立，等 merge | 可先 merge |

---

## 2. 本轮 TODO — GToken Gasless 销售

### 2.1 合约层

- [ ] 设计 `BuyIntent` EIP-712 结构：`{buyer, paymentToken, usdAmount, minTokensOut, deadline, nonce}`
- [ ] 设计 USDC/USDT 授权路径：
  - USDC（已支持 ERC-2612 permit）：`buyWithPermit(intent, sig, permit)` 直接走 `permit + transferFrom`
  - USDT（无 permit）：走 Permit2（Uniswap）`permitTransferFrom`，或先引导用户一次 approve（退化方案）
- [ ] `SaleContract.buyWithPermit(...)`：保持现有 milestone / whitelist / inventory 逻辑，仅新增入口
- [ ] `APNTsSaleContract.buyWithPermit(...)`：同构
- [ ] 测试：
  - [ ] 正常路径（USDC + permit）
  - [ ] USDT + Permit2
  - [ ] 过期 deadline / 复用 nonce / 错误 chainId 必须 revert
  - [ ] relayer 调用，状态变更归属于 `intent.buyer`（不是 relayer）
- [ ] 部署到 Sepolia，`DEPLOYED.md` 更新地址

### 2.2 Relayer（`services/relayer/`，新建）

- [ ] Cloudflare Worker：`POST /relay` 接收 `{intent, intentSig, permit, permitSig}`
- [ ] 本地预检：`deadline` 未过、`chainId` 正确、`buyer != 0`、inventory 够、gas 预估通过
- [ ] 提交 `buyWithPermit(...)` 到链上，等收据返回 tx hash
- [ ] Hot wallet：按 `OPERATOR_PK` 签名，限额单笔 ≤ $N gas
- [ ] 速率限制：每个 buyer 地址 N 分钟 M 次；每小时总额上限
- [ ] 失败处理：链上 revert → 直接返回给前端让用户查看 reason；不重试

### 2.3 销售页 `site/sale.html`

- [ ] 只用 `viem`（禁止 `ethers.js`，符合全局规则）
- [ ] 钱包连接：AirAccount / YetAnotherAA（禁止 WalletConnect）+ 浏览器钱包 fallback
- [ ] 读取 USDC/USDT 余额 + 当前 milestone 价格 + 剩余库存
- [ ] 用户输入美元数额 → 显示预计 GToken 数量 + 滑点提示
- [ ] 一次签名流程：
  1. 签 Permit（USDC 是 EIP-2612；USDT 走 Permit2）
  2. 签 BuyIntent（EIP-712）
  3. POST `/relay`，轮询 tx 确认
- [ ] 成功页：显示购买数量、etherscan 链接、提示加入社区
- [ ] 中文界面（全局规则）

### 2.4 文档 & 发布

- [ ] `contracts/DEPLOYED.md` 更新 gasless 版合约地址
- [ ] `docs/gasless-buy-flow.md` 新建：图示 + 字段定义 + 安全模型
- [ ] 本 `MILESTONES.md` 随进度打勾

---

## 3. 销售模型（背景，不改）

v1.2.1 已固化的规则：
- 起始价 $0.15 / GToken，6 个 revenue milestone
- 库存 4,200,000 GT（单次销售池）
- Treasury：`0x51eDf11fDb0A4F66220eFb8efA54Eca77232E114`（Safe 多签）
- 接受支付：USDC（已开）、USDT（待开白名单）
- 当前 whitelist 关闭（公开销售）

aPNTs 定价：固定 $0.02 / aPNTs（可 owner 调整），主要用于 SuperPaymaster gas 赞助。

> 详细叙事与阶段设计见 `contracts/docs/sale-plan.md` 和 `docs/Roadmap/Plan.md`（不重复）。

---

## 4. 远期（非本轮）

- OP 主网部署（Phase 2 结束节点）
- DAO 治理启动 + 金库多签转治理
- Uniswap V3/V4 二级流动性池（触发条件：月净收入 × 6 ≥ LP 规模）
- MyShop / MyTask / MyVote 应用套件
- SuperPaymaster v5 主网
- CoS72 Registry flow + SDK

> 详见 `docs/Roadmap/Roadmap.md` 和 `docs/Roadmap/Plan.md`。

---

## 5. 归档 / 已完成

- ✅ 2026-04-16 — License 清理：纯 Apache 2.0 + NOTICE + TRADEMARK
- ✅ 2026-04-09 — SaleContract v1.2.1 部署 Sepolia，Codex 3 轮 review，79 tests pass
- ✅ 2026-04-09 — 20 E2E tests 对 live Sepolia 合约全通过
- ✅ 2026-04-08 — 26 用户场景测试 + coverage report
- ✅ 2026-03-14 — SaleContract 重写为 revenue-based milestone（去除 GovernanceToken）
- ✅ SuperPaymaster V5.1 Registry 重构（accountToUser 删除 + ticket model）

---

## 附：贡献约定

- 新增任务：直接改本文件第 2/4 节，commit message 说明
- 状态变更：就地打勾，不要单独开 PR
- 旧文档：`docs/Roadmap/` 下文件保留历史，不再更新状态字段，只更新叙事部分
