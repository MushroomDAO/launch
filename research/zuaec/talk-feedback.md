# 设计讨论追踪文档 — LAAS + SC 向量化 + 人机协作框架

> **持续更新**：每次讨论后追加，保持追踪
> **最后更新**：2026-05-23

---

## 一、LAAS + 联邦学习 + SC 向量化设计（2026-05-22 讨论）

### 1.1 核心设计命题（Jason 提出）

**LAAS（Local AI As Service）**：在用户本地设备（主要是电脑，如 64G M1 Max Mac）运行小型 AI 模型，用于从本地社会数据中提取"数字向量特征"，代表用户的社会资本维度。

**核心逻辑链**：
```
原始社会数据（隐私）
  → 留在设备内，不流出边界
  → LAAS 本地模型提取特征向量
  → 特征向量（非原始数据）流通于网络
  → 向量匹配（非传统凭证核验）决定准入和路由
```

**关键创新**：向量匹配而非凭证核验 → "即便作弊，也不知道如何作弊"（攻击者需做反向工程）

---

### 1.2 挑战与 Jason 的回应

**挑战 1：特征向量本身就是隐私泄漏（模型反演攻击）**

> *Claude*：裸向量可被反推原始数据，需加差分隐私（DP）噪声

**Jason 决策**：✅ 接受，选择 DP 噪声路径

> "我意可以加DP来去增加它的安全性，否则可能会有反向去推断原始数据的风险，对吧？"

---

**挑战 2：谁来定义"维度标准"，谁就控制了网络**

> *Claude*：需要去中心化维度注册机制

**Jason 回应**：✅ 社区共识 + 可自定义维度

> "维度标准类似于一个协议。社区会推动建立一些公共的维度。你跟别人通信，可以在大家共识的维度上增减自己的维度——既保证了共性，也保护了隐私。你觉得某个维度我不想遵守，不想提供，可以增加另外一个，都可以。"

**关键洞见**：维度 = 协议的数据结构。不同社会活动场景（找工作/外贸/找对象）可以各自定义为独立协议，每个协议有自己的维度输入要求。

---

**挑战 3：LAAS 小模型的能力上限**

> *Claude*：手机可能算力不足，特征提取精度可能太低

**Jason 决策**：✅ 以电脑（非手机）为主要设备，64G M1 Max 足够

> "个人隐私数据数量不会太大。电脑完全能做到这一点。"

---

**挑战 4：本地模型本身的可信度谁来保证（模型诚实性）**

> *Claude*：建议 TEE（可信执行环境）+远程证明

**Jason 回应**：✅ 治理机制 > 技术机制，技术是兜底

> 核心逻辑：提高作恶成本 + 降低作恶收益
> - 基础门槛：付费进入（ticket 10-30元），防批量女巫攻击
> - KYC 要求：敏感操作必须做真实身份证明（国家合规要求）
> - 信用积累：持续交互形成声誉，一次被发现就降信用值
> - 现实锚定：虚假声誉最终要在肉身世界兑现才有意义，无法兑现就崩盘

**Jason 补充**：TEE 计划通过社区/俱乐部共购小型服务器（如 NXP i.MX93/95，支持 TrustZone）提供，不依赖个人设备。

---

**挑战 5：冷启动问题**

> *Claude*：新用户无历史，零向量无法入网

**Jason 回应**：✅ 不是问题，从零开始尝试交互即可

> - 可引入 ZK 证明国家合法公民身份（不透露姓名、年龄、地址）
> - 或直接引入国家要求的 KYC
> - 信用从零开始积累，这是自然的

---

**挑战 6：向量聚合的中心化陷阱**

> *Claude*：联邦学习的汇聚节点谁来做？

**Jason 回应**：🔄 待细化

> "如果我们能做到脱敏，是否可以租用外部的计算节点？这个计算节点是去中心化的，只要技术上保证计算完后完全销毁、不去记录，那是不是就OK了？"

*Claude 补充*：这接近"保密计算"（Confidential Computing）思路，加密计算节点（或 MPC 多节点）可实现，工程上有可行路径。

---

**挑战 7：跨网络 SC 迁移问题**

> *Claude*：不同网络维度不同，SC 如何跨网络迁移？

**Jason 决策**：✅ 跨网络迁移不是 v1 重心，通过具体场景切入

> "社会资本定义还比较模糊，不系统化量化，反向从问题入手。例如：'工作推荐担保'——前同事为你的职场信用担保，这个担保行为上链，agent 可证明'我曾被担保过'，这就是一种跨网络迁移（从肉身社交网络迁移到 agent 网络）。"

**"跨网络"的定义需澄清**：跨人际关系网络 / 跨物理网络 / 跨 agent 生态系统 → 论文只指出可能性，不深入展开。

---

**挑战 8："不知道怎么作弊"的安全边界**

> *Claude*：GAN 生成攻击 / 白盒梯度攻击

**Jason 回应**：✅ 核心是提升作恶成本、降低作恶收益

> - 付费门票：降低批量攻击规模
> - 肉身兑现：虚假声誉无法在现实中落地，最终崩盘
> - 一次发现：直接降信用，永久记录
> - 类比"托儿"：现实中也存在，但社区口碑机制会淘汰
> - LAAS 开源但本地运行：攻击者无法远程篡改你的本地模型

---

### 1.3 Jason 的技术决策汇总

| 问题 | 决策 |
|------|------|
| DP vs ZK 主路径 | ✅ **选 DP 噪声**（工程可行性优先） |
| TEE 依赖 | 🔄 **再考虑**，社区共购小型 TrustZone 设备可能路径 |
| 跨网络 SC 迁移 | ❌ **不是 v1 目标**，冻结接口定义留作未来 |
| LAAS 硬件要求 | ✅ **电脑为主**（64G M1 Max 级别），非手机 |
| 攻击防御核心 | ✅ **治理+机制**（作恶成本/收益），技术是兜底 |
| SC 量化方式 | ✅ **场景驱动**（找工作/外贸/找对象），非系统化理论 |

---

### 1.4 关于 DP 隐私预算的解释（Jason 追问）

**隐私预算 ε（epsilon）是什么**：
- 把隐私看作一个"账户余额"，ε 是总额度
- 每次向外分享数据（发送向量、响应查询），都消耗一部分 ε
- 当 ε 耗尽，后续的分享就没有数学意义的隐私保证了
- **"难管理"具体指**：
  1. 需要全局追踪每个用户的 ε 累积消耗
  2. 每次操作消耗多少 ε 需要预先规划
  3. ε 用尽后用户要么停止（不可用），要么放弃隐私（不安全）
  4. 多次操作的组合隐私消耗不是简单加法（Composition Theorem，数学复杂）

**工程实现**：Google 的 DP Library 提供了计算工具；Apple 在 iOS 中已用于遥测数据（实际工程可行）。对于 LAAS 场景，可以设定"每天允许 K 次向量查询"，每次消耗固定 ε 预算，超过则需要用户"重新授权"（刷新预算）。

**ZK 计算贵具体指**：
- 是的，在本地生成 ZK 证明（如证明"我的向量与目标向量距离 < δ"）计算量很大
- 128 维向量用 Bulletproofs 生成证明：约 2-10 秒（M1 Mac 级别）
- 验证很快：< 0.1 秒
- **Jason 决策**：不强依赖 ZK，DP 噪声是主路径，ZK 是可选的学术完备性补充

---

### 1.5 Paper 2 §5 改写方向 ✅ 已完成（2026-05-23）

~~当前 §5 写的是：ZK-SNARK + 密码学累加器~~
已重写为以 **DP + LAAS + 联邦学习** 为核心路径，ZK 为可选路径：

| 子节 | 完成状态 | 主要内容 |
|------|------|------|
| §5.1 Design Goals | ✅ | G1-G5 + G6（消费级硬件可行性，驱动选择 DP 主路径）|
| §5.2 LAAS Architecture | ✅ | LAAS 本地提取 + 向量匹配原理 + 维度注册机制 |
| §5.3 DP Primary Mechanism | ✅ | Gaussian 机制 + ε/δ 参数 + K次查询预算管理 |
| §5.4 Credentials & Aggregation | ✅ | VC_rep + 联邦声誉学习 + relay 路由表 |
| §5.5 Sybil & Collusion | ✅ | 协议+经济+行为三层防御 + TrustFlow 引用 |
| §5.6 ZK Optional Extension | ✅ | Bulletproofs/Halo2 + relay 分层（DP-only vs ZK-required）|
| §5.7 Device Specs & DP Params | ✅ | 64G M1 Max + ε=1.0/δ=10⁻⁵ + TEE 可选路径 |

---

## 二、协作框架层级（2026-05-22 讨论）

### 2.1 Jason 的核心论点

**目的层级**：人机协作 + 机机协作，最终都是为了提升**人和人之间的协作效率**

```
人 ←协作→ 人
↑              ↑
通过 agent 中介，突破协作障碍
（人机协作 + 机机协作）
```

**关键洞见**：
- Agent 不能替代所有人际协作（老朋友喝酒聊天，替代不了）
- 但在特定范围和领域，agent 可以大幅提效（快速找到匹配的人，再由人完成肉身验证）
- "社恐""社交圈小"的人：agent 是社交补充，而非替代

**论文定位**：
- Paper 1 + Paper 2 = 讨论**机机协作**（agent 之间的协作基础设施）
- 最终目的：通过机机协作，帮助人机协作更高效，从而让人和人之间协作更高效
- 明确声明这一目的链，在 Paper 1 §1 或 §9（Discussion）中体现

---

## 三、业界官方技术规范（2026-05-23 整理）

### 3.1 Google A2A (Agent-to-Agent Protocol)

| 项目 | 信息 |
|------|------|
| 官方公告 | https://developers.googleblog.com/en/a2a-a-new-era-of-agent-interoperability/ |
| 发布日期 | 2025年4月9日（Google Cloud Next）|
| GitHub | https://github.com/a2aproject/A2A（已捐给 Linux Foundation，23,900+ stars）|
| 官方规范 | https://a2a-protocol.org/latest/（v1.0.0，2026-03-12）|
| 许可证 | Apache 2.0 |

**核心技术特性**：
- **Agent Card**：JSON 格式能力描述文件（`/.well-known/agent.json`）
- **传输层**：HTTP + SSE + JSON-RPC 标准
- **消息结构**：parts 字段，支持多模态（文本/音频/视频）
- **任务对象**：支持即时任务和长运行任务（数小时到数天）
- **认证**：企业级 OpenAPI 认证规范

**学术引用**：
```
Surapaneni, R., Jha, M., Vakoc, M., & Segal, T. (2025, April 9). 
Announcing the Agent2Agent Protocol (A2A): A new era of agent interoperability. 
Google Developers Blog. https://developers.googleblog.com/en/a2a-a-new-era-of-agent-interoperability/

Linux Foundation / Google. (2026). Agent2Agent (A2A) Protocol specification v1.0.0.
GitHub. https://github.com/a2aproject/A2A
```

**与 ASM 差异**：A2A 解决跨系统 agent 互操作（能力层），不定义社会角色和声誉治理；ASM 在 A2A 之上增加角色语义层。

---

### 3.2 Anthropic MCP (Model Context Protocol)

| 项目 | 信息 |
|------|------|
| 官方公告 | https://www.anthropic.com/news/model-context-protocol |
| 发布日期 | 2024年11月25日 |
| GitHub（规范）| https://github.com/modelcontextprotocol/modelcontextprotocol（8,200+ stars）|
| GitHub（服务器）| https://github.com/modelcontextprotocol/servers（86,100+ stars）|
| 官方文档 | https://modelcontextprotocol.io |
| 当前规范版本 | 2025-11-25 |

**核心技术特性**：
- **三角色架构**：Hosts（LLM 应用）/ Clients（连接器）/ Servers（提供工具和上下文）
- **传输**：JSON-RPC 2.0，有状态连接
- **服务器能力**：Resources（上下文数据）/ Prompts（模板）/ Tools（可执行函数）
- **设计灵感**：借鉴 Language Server Protocol（LSP），解决 M×N 集成问题

**学术引用**：
```
Anthropic. (2024, November 25). Introducing the Model Context Protocol.
https://www.anthropic.com/news/model-context-protocol

Anthropic. (2025). Model Context Protocol specification 2025-11-25.
https://modelcontextprotocol.io/specification/2025-11-25
```

**与 ASM 差异**：MCP 解决单 LLM 访问工具的"垂直集成"（模型↔工具，client-server 调用）；ASM 解决 agent 之间的"水平协作"（agent↔agent），是 MCP 之上的社会协作协议层。

---

### 3.3 Anthropic 多智能体工程实践

| 项目 | 信息 |
|------|------|
| 工程博文 | https://www.anthropic.com/engineering/built-multi-agent-research-system |
| 研究文档 | https://www.anthropic.com/research/building-effective-agents |

**关键架构创新分类**：

*INTRA-agent（单个 agent 内部，非我们的聚焦点）*：
- Extended Thinking Mode（任务前规划）
- Memory Persistence Layer（上下文截断后策略续接）
- Effort Scaling（简单查询 1 agent，复杂研究 10+ subagent）
- Search Strategy Guidance（短→宽查询→渐进收窄）

*INTER-agent（agent 之间协调，与我们相关）*：
- **Orchestrator-Worker Pattern**：Lead agent（Opus 4）分析 → 派发 3-5 个 subagent 并行 → 综合结果
- **Task Decomposition with Boundary**：每个 subagent 有明确任务边界，防止重复
- **Parallel Tool Execution**：并行 subagent，复杂研究缩短 90% 时间
- **Synchronous Coordination（当前局限）**：同步等待最慢 subagent → 制造瓶颈；Anthropic 承认"未来方向：异步执行"

**对 Paper 2 的价值**：Anthropic 承认同步协调创造"信息流瓶颈"且"Lead 无法中途干预 subagent"——这正是 ASM 的 relay-mediated discovery + 状态机 要解决的开放网络场景问题。

**学术引用**：
```
Anthropic Engineering. (2025). How we built our multi-agent research system.
Anthropic. https://www.anthropic.com/engineering/built-multi-agent-research-system
（访问日期：2026-05-23）

Anthropic. (2024). Building effective agents.
Anthropic Research. https://www.anthropic.com/research/building-effective-agents
```

---

### 3.4 OpenAI 相关文档

**Practical Guide to Building Agents（2025）**：
```
OpenAI. (2025, April 17). A practical guide to building agents.
https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/
PDF: https://cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf
```

**Practices for Governing Agentic AI Systems（2023）**：
```
Shavit, Y., Agarwal, S., Brundage, M., et al. (2023). 
Practices for governing agentic AI systems. OpenAI.
https://cdn.openai.com/papers/practices-for-governing-agentic-ai-systems.pdf
```

**Paper 2 引用价值**：OpenAI 2023 的七项治理实践（限制行动空间/设置默认行为/可关闭可控）可用于 Paper 2 §1.3（Threat Landscape）作为行业 safety baseline，ASM 的威胁模型在协议层提供这些保障。

---

## 四、Paper 1 & 2 定位对齐（2026-05-23 讨论）

### 4.1 Jason 原文（语音转文字，保留原始）

> 我们再对齐一下paper一和paper2的定位。paper一是一个scope over这个paper review我们re了100多篇甚至200篇然后呢尝试找到AG的发展的趋势和方向啊，并且从中找到支持我们的理论和逻辑。当然可能也有反对或者弥补我们的这种逻辑。然后呢从而建立一个AG的协作网络啊，基于我的核心的几个观点啊，应该如何建立这个协作的网络，啊，有哪些需要注意的问题。我们给出的是什么方案，包括关键的协作网络，如果要建立的话有哪几个核心的组件和步骤或者过程。我希望paper一解决这个问题。那paper二本身呢实际上它是呃呃类似于一个一个系统的设计。对，我们尝试把我们在paper一分析出的这些组件流程规范啊，各种东西然后以这种啊系统设计的方式，或者说呃我不知道这个词用的准确不准确来去完成paper2这个paper2本身呢就是把我们的思考和设计进一步的具象化。啊这个agent的写作网络啊真正的设计出来，并且呃如果可能的话，我希望是有初步的demo出来，能够验证A是可以跑通的。在某些场景上它能够高效的解决我们提出的这个问题，对吧？啊，大概是这个思路。

> （第二轮补充）我在那个文件里输入的原文，你为什么不保留啊，你给我删除，然后又没有很好的总结，这个我担心原始信息丢失啊。呃，你总结分析的挺好的。但实际上我们的PSC和N3支柱框架本身就是一个很模糊的观点，它需要review啊这个学术界的有价值的思考，来让它丰满，甚至修改改变它，这都是有可能的。我们是一个开放的心态去分析和形成这个呃框架的过程。对，而不是说带着这个主义去去去来论证它可行，这不可能。对，因为实际我们的观点也好，我们的核心的这个也是在形成的过程中啊，对吧？包括你说了一点这个比如说啊这种随机拓扑网络剩余设计的网络。那我我就是这样认为的，我们做的这种nstr。去中心化的网络不就是让大家任意的去建立节点，建立注册，然后建立连接和协作嘛？这不就是随机的吗？我们又不是建一个中心化的网络，这不可能啊，这说明你对我的观点还没有理解透彻，也说明可能我的观点，也在论证和完善完善过程中。那用简单点的话说，配置一就是review加呃这个一个研究分析。对，它不提出完整的。但是他提出过程，提出组件，然后做一些分析，是这意思吧？然后呢，当然我们可能提出一个观点，在这个观点，它不是那种系统化的设计，对，对吧？然后paper二呢是基于我们paper一的研究，然后深入的展开。比如说我们细化我们选择了一些场景，啊，反向的以问题入手，然后呢去结合我们paper一的思考和设计，来去细化这些流程关键的组件相关的协议，真正的落地到一个啊这种能够让AG的协作的网络上。当他这个网络不仅仅包括网络网络模型通信协议啊，reportation呢，啊，包括整个的。技术战怎么实现，对吧？这个我们都来嗯把它就是真正的实政落到系统上。我不知道配per二算是什么类型的配per啊，但你觉得这样好不好？因为最终的目目的是通过paper一和paper2逐渐从学术和实践中推导出来。呃，这个我们要参加浙大第八届这个创业大赛。嗯，这个实际的产品。然后呢当然这个产品可能还有很多欠缺，但至少初步的嗯无论从学术从设计系统设计还是实际的场景落地上，我们有一个啊相对比较充足的论据说明。因这个有可能是在现实世界可可行的，有可能代表的AIagent的一个发展的方向？

---

### 4.2 核心洞见提炼

**关于 P/SC/N 框架的性质（Jason 明确）**：
- P/SC/N 是一个**开放的假设**，不是先验结论
- Scoping review 的任务是让它丰满、修正它，甚至改变它
- 带着主义去论证可行性 = 不可能 = 不是我们的做法

**关于"随机拓扑 vs 我们的 N 支柱"（Jason 纠正了我的错误分析）**：
- 我之前把 MacNet"随机拓扑优于精心设计"当成反对 N 支柱的张力
- Jason 的回应：Nostr 式无许可网络**本身就是随机拓扑**——任何人可以建节点、注册、连接
- 我们从来没有打算建中心化设计的网络拓扑
- **结论：MacNet 实际上支持 N 支柱，不是反对** → 之前的分析错误，需要在论文里修正这个引用的方向

---

### 4.3 确认后的定位

**Paper 1 = Review + Research Analysis（不是完整系统设计）**
- 回顾 100-200 篇文献 → 发现趋势和规律
- 既找支持性证据，也找反对/修正性证据（开放心态）
- 从 review 中归纳出：要建 ACN 需要哪些**核心组件/步骤/过程**
- 提出一个方向性观点（P/SC/N），但不是系统化的完整设计
- 结论是**过程性、探索性**的，不是封闭的定论

**Paper 2 = System Design（落地系统）**
- 基于 Paper 1 的研究，深入展开
- 选择具体场景，**以问题为起点反向推导**
- 结合 Paper 1 思考 → 细化流程、组件、协议
- 覆盖范围：网络模型 + 通信协议 + 声誉系统 + **整个技术栈的实现**
- 目标：真正落地到一个能跑通的 agent 协作网络

**两篇合在一起的使命（ZUAEC 维度）**：
- 从学术（Paper 1） + 系统设计（Paper 2） + 场景落地（demo），形成完整论据链
- 证明这个方向**在现实世界是可行的**，代表 AI agent 的一个发展方向
- 为参加浙大第八届创业大赛的产品提供学术与工程支撑

---

## 五、待解决的开放问题

### 论文相关
- [x] Paper 2 §5 按 LAAS + DP 路径重写（已完成 2026-05-23）
- [ ] Paper 2 §2 更新：加入 A2A、MCP 官方引用（已有草稿，需加官方 URL）
- [ ] Paper 1 §1 加入 Anthropic 的"同步协调瓶颈"作为机机协作问题的工业证据
- [ ] Paper 1 §9（Discussion）加入"人机协作→机机协作→人人协作"的目的链

### 设计相关
- [ ] LAAS 聚合节点的具体方案：MPC 多节点 vs 加密计算节点（保密计算）
- [ ] TEE 的最终决策：全依赖社区共购设备，还是有 fallback 方案？
- [ ] "跨网络"的正式定义：论文中需要明确划定边界（不作深入展开）
- [ ] 维度注册表的协议设计：公共基础维度 + 可自定义扩展维度的协议格式

### 引用相关
- [ ] A2A v1.0.0 规范（2026-03-12）加入 Paper 2 §2 引用列表
- [ ] MCP spec 2025-11-25 加入 Paper 2 §2 引用列表
- [ ] Anthropic Engineering Blog 加入 Paper 2 §1（Motivation）
- [ ] OpenAI Governing Agentic AI（2023）加入 Paper 2 §1.3（Threat Landscape）
