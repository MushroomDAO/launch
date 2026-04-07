---
created: 2026-04-07
status: active
---

# Three-Branch Development Plan

> 规划基于对 site/、contracts/、submodules/mushroomdao-site、submodules/mushroomdao-docs 的全面分析。

---

## 分支一：`feat/site-refine` — Launch 站点信息完整性

### 当前页面结构
```
index.html (= cold-launch.html)  起源故事 / 三阶段资金 / 参与方式
architecture.html                技术架构图
sustainability.html              可持续规划
dashboard.html                   社区监控看板
```

### 从参与者视角：关键信息缺口

**① 最高优先级缺口：无法"验证"**

一个认真考虑参与的人会问：
- GToken 部署在哪条链？合约地址是什么？有没有 Etherscan 链接？
- 有没有安全审计报告？谁审的？
- 21M 总量、20/20/60 分配这些是链上可查的吗？

目前网站对这些完全没有披露。对于任何理性参与者，这是最大的阻塞点。

**② GToken 实际用途不清晰**

冷启动页面把 GToken 定位为"门票而非投资"，但没有告诉用户门票能进哪扇门：
- 持有 → 治理投票（提案、参数修改）
- 质押 → 在 Registry 注册协议角色（Community / Operator / DVT / KMS）
- 销毁机制（burn-on-join/exit）→ 稀缺性来源
- 21M 硬顶上限

这些是 GToken 核心价值所在，但在 launch 站点上完全缺失。用户看到的只是"支持协议发展"，没有具体的权益清单。

**③ 代币经济学（Tokenomics）未披露**

合约里有明确分配：20% Sale / 20% HyperCapital / 60% Community Treasury。但网站上：
- 没有 HyperCapital 是谁的说明
- 没有各部分的锁仓/释放规则
- 没有当前流通量 vs 计划供给的对比
- 没有购买量上限说明（每人上限、单次上限）

**④ 购买流程不可操作**

当前参与方式只有三类（赞助者/共建者/Guardian），没有面向普通用户的"我要买 GToken"流程：
- 用哪个钱包？支持哪些链？
- 接受哪些支付代币（USDC/USDT/ETH/WBTC）？
- 最低购买额是多少？
- KYC/白名单要求？

**⑤ 团队/问责信息**

协议发起者是谁？GitHub 里有 jhfnetboy 但网站没有任何创始人/核心成员介绍。开源不等于匿名——公开透明需要可问责的人。缺少：姓名/GitHub/背景/职责分工。

**⑥ 进度和当前状态**

Phase 1 已完成（网站/文档/SDK），但：
- Phase 2 目前已筹集多少（$X/$1,200）？
- 当前 GToken 价格是 $0.15 还是已经涨了？
- 没有实时进度条，阻塞了"现在参与是否还有早鸟优势"的判断

**⑦ 不参与的原因/风险披露**

公开透明意味着也要说清楚风险：
- 这是实验性协议，没有回报承诺
- GToken 无法在二级市场流通（目前）
- 合约未经外部审计
- 法律合规状态（哪个司法管辖区）

目前网站完全没有风险提示，这本身就是不透明。

---

### 建议新增页面规划

**Page A：Token — Utility & Value**（路径 `site/token.html`）

内容结构：
```
1. GToken 是什么（60字以内，直白）
2. 持有者权益清单
   - 治理投票权（链接提案示例）
   - 质押→角色注册（Community/Operator/KMS）
   - 协议服务折扣/优先级
3. 代币经济学
   - 总量：21,000,000（硬顶，链上可查）
   - 分配：Sale 20% / HyperCapital 20% / Treasury 60%
   - 销毁机制：join/exit 销毁，通缩
4. 价格里程碑表（当前 $0.15，+12%/阶段）
5. 合约地址 + Etherscan（部署后填入）
```

**Page B：For Communities — Public Goods Guide**（路径 `site/for-communities.html`）

内容结构：
```
1. 两类受益者
   - 社区（使用 Cos72 + SuperPaymaster 搭建自己的协作工具）
   - 个人用户（AirAccount 无私钥 / AirDrop 无 gas）
2. 社区如何加入协议
   - Step 1: 持有并质押 GToken → 在 Registry 注册
   - Step 2: 部署/接入 Cos72 Community OS
   - Step 3: 参与治理，共同决定协议方向
3. 个人用户路径
   - AirAccount：社交登录，无私钥，无 gas
   - 参与社区任务 → 积累 PNTs/SBT → 建立链上身份
4. 开源免费 vs 服务支持的区别
   - MIT/GPL 条款，可自行部署
   - 需要托管服务 → 购买 aPNTs 门票
5. 当前可用工具状态（Beta/Alpha/计划中）
```

**cold-launch.html 需要的 refine：**
- 加入购买交互区（合约就绪后）：当前价格 / 进度条 / 支付入口
- 加入合约地址区块 + Etherscan 链接
- 加入风险披露段落
- 修复 localhost:6420 链接 → www.mushroom.cv
- 加入团队/问责信息
- 加入社区频道链接

---

## 分支二：`feat/site-docs-sync` — 主站与文档内容同步

### 数据不一致清单

| 数据项 | cold-launch.html（基准） | docs cold-launch-en/zh | 主站 index.html |
|---|---|---|---|
| Phase B（Protocol Community）预算 | **$36,600**（含$3,000一次性） | $33,600 ❌ | $33,600 ❌ |
| 累计总额（所有阶段） | **$135,800** | $129,200 ❌ | 未明确显示 |
| Phase A 中间档（$3,600 Claude Max+服务器） | 有 ✅ | 无 ❌ | 无 ❌ |
| Phase 命名结构 | A/B/C 三大阶 + 子阶段 | Phase 1-6 ❌ 不一致 | Phase 2-5 ❌ 不一致 |
| GToken 起始价格 | $0.15 | $0.15 ✅ | $0.15 ✅ |
| 12% 涨幅机制 | 按里程碑/revenue | 按收入里程碑 ✅ | 按 Phase 触发 ✅ |
| 购买入口链接 | 暂无 | 暂无 | 现指向 launch.mushroom.cv ✅ |

### 主站 `mushroomdao-site/index.html` 需要做的调整

1. **Phase 4 金额**：`$33,600` → `$36,600`（英文和中文各一处）
2. **Launch Panel 说明文字**：当前只有 Phase 2-5 四个条目，建议合并为"Phase A/B/C"与冷启动页一致，或保持 4 条但金额更正
3. **"Launch Site ↗" 按钮**：已指向 launch.mushroom.cv ✅

### Docs (`mushroomdao-docs`) 需要的调整

`cold-launch-en.md` 和 `cold-launch-zh.md` 均需：
1. Phase 4 目标金额：$33,600 → $36,600，说明新增一次性 $3,000 工具费
2. 累计总额：$129,200 → $135,800
3. Tier 3 个人上限：$336（约 1,786 GT）→ 按新价格重新计算
4. 补充 Phase A 中间档（$3,600/yr Claude Max + 服务器节点）
5. Phase 命名统一（建议采用 A/B/C 与 HTML 一致，同时保留 "Phase 2-5" 作为括号说明）

### 叙事一致性补充

docs 里的 burn-on-join/exit 机制没有在主站和 launch 站体现，需补充。

---

## 分支三：`feat/sale-contract` — 销售合约开发

### GToken 合约策略（已确认）

**使用 SuperPaymaster 标准合约，不复制 fork：**
- Sepolia 已部署地址：`0xa592ec5a05c3909917d038ab01aaf7bccf2d90f0`
- SaleContract 通过 `IERC20(GTOKEN_ADDRESS)` 引用，只做 transfer 调用
- 若 GToken 需新增 feature（如加 ERC20Votes）→ 在 SuperPaymaster 仓库拉新分支提 PR
- launch/contracts/ 只保留：SaleContract.sol + APNTsSaleContract.sol + 相关测试和脚本

### 现有合约 vs 设计目标的差距

**最大冲突：价格**

| | SaleContract.sol（现状） | 设计文档 / 网站（目标） |
|---|---|---|
| 起始价格 | **$1.00** / GT | **$0.15** / GT ❌ 相差 6.7 倍 |
| 触发机制 | 代币数量阈值 | 收入达成里程碑 ❌ 根本不同 |
| 阶段数量 | 3 段固定 | 5+ 段，admin 可配置 |
| 支付代币 | 任意 ERC20（假设 USDC 1:1） | USDC/USDT（稳定币 USD 计价）|
| 每人限购 | 一次性 one-buy-per-address | 需要 per-tier 上限 |
| 白名单 | EIP-712（TODO 未实现） | 分阶段可开关 |
| 预言机 | 无 | 若接受 ETH/WBTC 需要 Chainlink |

### 建议新合约架构：Revenue-Based Milestone Sale

**设计原则：**
1. **不要 oracle**：接受稳定币（USDC/USDT），USD 计价直接，无价格波动风险
2. **不强制 one-buy**：用户可分多次买，但每阶段设 per-person cap（防鲸）
3. **白名单可选**：合约支持 open / whitelist 两种模式切换
4. **进度透明**：public 变量暴露 currentRevenue / currentMilestone / currentPriceUSD
5. **紧急暂停**：Owner 可 pause（OZ Pausable）
6. **最小依赖**：OZ Ownable + ReentrancyGuard + Pausable + SafeERC20，不用 Thirdweb

**里程碑对应表：**
```
Milestone 0 (初始):  revenueCap=$0        price=$0.15000 / GT
Milestone 1 (Phase A-1): revenueCap=$1,200   price=$0.16800 (+12%)
Milestone 2 (Phase A-2): revenueCap=$4,800   price=$0.18816 (+12%)
Milestone 3 (Phase A-3): revenueCap=$12,800  price=$0.21074 (+12%)
Milestone 4 (Phase B):   revenueCap=$49,400  price=$0.23603 (+12%)
Milestone 5 (Phase C):   revenueCap=$135,800 price=$0.26435 (+12%)
```

**触发方式：** admin 手动调用 `advanceMilestone()`，合约验证 `totalRevenue >= milestones[current].revenueCap`

### Registry 与 GToken 使用关系

```
GToken 买家 → 质押到 GTokenStaking → Registry 注册角色
  COMMUNITY:  建立社区节点，获 ENS 子域名
  ENDUSER:    建立个人链上身份
  PAYMASTER:  运营 gas 支付服务
  KMS:        运营密钥管理服务
  DVT/ANODE:  运营验证节点
```

**建议前端一键流程：** buy GToken → approve stake → register role（三步合一的 UI 引导）

### 购买界面设计（launch 首页新增交互区）

```
┌─────────────────────────────────────┐
│  当前价格：$0.15 / GT               │
│  当前阶段：Phase A-1 ($643/$1,200)  │
│  ████░░░░░░░░░░░░░░ 53%             │
├─────────────────────────────────────┤
│  支付方式：[USDC] [USDT]            │
│  输入金额：[ $______ ]              │
│  预计获得：______ GT                │
│  [连接钱包]  →  [确认购买]          │
└─────────────────────────────────────┘
```

---

## 执行优先级

```
1. feat/sale-contract
   ① 删除 GovernanceToken.sol（使用 SuperPaymaster 标准合约）
   ② 重写 SaleContract（revenue-based milestones, $0.15 起价）
   ③ 完整测试 + Sepolia 部署

2. feat/site-docs-sync
   ① docs: 更新 Phase B 金额 $33,600→$36,600，累计 $135,800
   ② 主站: 同步金额
   ③ 统一 Phase 命名

3. feat/site-refine
   ① 新增 token.html（Token 用途和价值）
   ② 新增 for-communities.html（社区视角指南）
   ③ cold-launch.html 加入购买交互区（合约地址就绪后）
   ④ 加入风险披露 + 合约地址区块
   ⑤ 修复进度条链接（localhost:6420 → www.mushroom.cv）
```

---

## 待填信息（需用户提供）

以下信息是信息披露完整性的阻塞项，请逐一确认：

### 合约相关
- [ ] Treasury 地址（接收 USDC/USDT 收入）：`0x_________`
- [ ] 接受支付代币：`[ ] USDC+USDT only  [ ] 还需要 ETH/WBTC`
- [ ] 早期白名单：`[ ] 完全开放  [ ] Tier 1/2 需白名单`
- [ ] 每人单阶段购买上限（USD）：`$_____`

### 信息披露相关
- [ ] 团队核心成员（可用 GitHub 昵称）：`创始人: _____  核心贡献者: _____`
- [ ] HyperCapital 一句话说明：`_____`（显示在 tokenomics 页）
- [ ] 社区频道：`Telegram: _____  Twitter/X: _____`
- [ ] 当前 Phase 2 已筹：`$_____ / $1,200`
- [ ] 风险披露是否包含：`[ ] 无回报承诺  [ ] 未审计  [ ] 无二级市场  [ ] 实验性`
- [ ] 法律合规声明：`[ ] 简单免责声明即可  [ ] 需要详细法律文本`
