# Paper 3 Draft v0

**题目（候选）**：*ACN-Agent: Engineering Patterns and a Reference Implementation for Low-Friction Integration of AI Agents into Open Collaboration Networks*

**备选题目**：
- *From Capability to Collaboration: Engineering Best Practices for Agent Integration in Open Social Networks*
- *Bridging the Gap: A Reference Agent Architecture for ASM-Governed Collaboration Networks*

**投稿目标**：arXiv preprint（配合 Paper 1 + Paper 2 作为三篇系列）；可考虑工程类会议（如 FSE、ICSE、middleware 相关）
**截止**：2026-08-31（与 Paper 1/2 同步提交 arXiv）

---

## 一、研究问题

Paper 1 提出了 P/SC/N 三支柱框架，Paper 2 定义了 ASM 通信协议。但两篇论文对 agent 本身能力的假设较高（能力持续进化、多模态、可自进化）。

**Paper 3 解决的核心问题**：

> 当前业界中游水平的 agent，如何以低成本、低摩擦、保护隐私的方式接入 ACN 协作网络，并从网络中获得可持续的协作价值？

这不只是"接入规范"问题，而是工程实践 + 学术研究的交叉：
- **快速接入**：从零到首次协作任务，工程成本应控制在合理范围内
- **低成本运行**：不依赖昂贵商业 API，以开源模型为主
- **隐私保护**：本地数据不出境，LAAS 架构对接
- **可持续参与**：声誉积累、credit 获取、协作价值的正向循环
- **自由退出**：不被锁定，随时可脱离网络而不丢失核心数据
- **自进化能力**：能从协作历史中学习，提升下次协作质量

---

## 二、核心创新点（初稿，待细化）

### C1：ACN 接入最小化接口规范（Minimal Integration Interface）
定义 agent 接入 ACN 的最小化接口集：
- 最少需要实现哪些 ASM 消息格式
- 最少需要维护什么状态（声誉分、VC、协议版本）
- 最少需要什么本地能力（签名、加密、LAAS 特征提取）

### C2：分层能力假设模型（Tiered Capability Assumption Model）
不假设 agent 完全符合最高规格，定义三个能力层级：
- **Tier A（基础接入）**：有签名能力 + 能执行特定协议 + 有基础声誉
- **Tier B（中阶协作）**：有 LAAS 集成 + 分层记忆 + 自评估能力
- **Tier C（高阶自治）**：有自进化 + 跨域协作 + 复杂任务编排

Paper 3 聚焦 Tier A→B 的工程路径，不要求 Tier C。

### C3：参考实现（ACN-Agent Reference Implementation）
基于开源模型（DeepSeek v4.0 Pro 为主 + 支持自定义模型）的最小可用 agent：
- 实现 ASM 协议接入
- 有基础分层记忆系统
- 有隐私保护的 LAAS 特征提取
- 支持 ERC-8004 + SBT 身份
- 能够参与三个验证场景（求职推荐、社交匹配、外贸采购）

### C4：接入摩擦分析框架（Integration Friction Analysis）
量化不同技术选择的接入成本：
- 时间成本（从零到首次协作）
- 经济成本（计算资源、Gas 费用）
- 隐私风险（数据暴露面）
- 锁定风险（退出成本）

---

## 三、Paper 3 与 Paper 1/2 的关系

```
Paper 1（理论框架）: P/SC/N 三支柱 — 为什么需要这个协作网络
    ↓
Paper 2（协议规范）: ASM — agent 之间如何通信和建立信任
    ↓
Paper 3（工程实践）: ACN-Agent — 普通 agent 如何具体接入这个网络
```

Paper 3 是 Paper 1/2 的落地实践验证，同时也是独立的学术贡献（工程设计模式 + 参考实现 + 摩擦分析）。

---

## 四、初步章节结构

| 章节 | 内容 | 字数估计 |
|------|------|---------|
| §1 Introduction | 问题动机；ACN 接入的工程挑战；Paper 3 的贡献 | 800w |
| §2 Background & Related Work | 当前业界最先进 agent 框架综述（Eliza/CrewAI/OpenHands/Agno 等）；分层记忆系统研究；自进化机制 | 1500w |
| §3 Integration Friction Analysis | 接入摩擦的四个维度；现有框架接入 ACN 的摩擦评估 | 1200w |
| §4 Minimal Integration Interface | ASM 最小接入接口规范；三层能力假设模型 | 1500w |
| §5 Reference Implementation | ACN-Agent 架构；分层记忆设计；LAAS 集成；开源模型选型 | 2000w |
| §6 Privacy & Exit Design | 数据本地化原则；退出机制设计；锁定风险评估 | 1000w |
| §7 Validation | 三个场景的接入实验；摩擦指标测量；与 Tier 框架的对比 | 1500w |
| §8 Discussion | 局限性；扩展路径；自进化路线图 | 800w |
| §9 Conclusion | 总结贡献；对 ACN 生态的影响 | 400w |

---

## 五、关键技术选型（基于 2026-05-25 调研）

### 5.1 基础模型（开源优先）

| 模型 | 参数量 | 上下文 | Agent 强项 | 许可证 | 推荐场景 |
|------|--------|--------|----------|--------|---------|
| **DeepSeek V3.2** | MoE 671B/37B 激活 | 128k | 综合最强开源；代码+数学 | MIT | 高性能服务端部署 |
| **Qwen3 30B-A3B** | MoE 30B/3B 激活 | 32k | 本地部署；工具调用强 | Apache 2.0 | 本地隐私优先部署 |
| **Hermes 4.3-36B** | 36B dense | 32k | 最佳开源工具调用/结构化输出 | Llama Community | 工具调用专项优化 |
| **Phi-4 mini** | 3.8B | 128k | 设备端；隐私保护场景 | MIT | 边缘设备/LAAS |
| **DeepSeek-R1** | MoE 671B/37B 激活 | 128k | 推理+数学；匹配 GPT-4o | MIT | 复杂任务规划 |

**首选**：DeepSeek V3.2（综合能力）+ Qwen3 30B-A3B（本地部署隐私场景）
**原则**：开源优先，支持自定义模型，不依赖单一供应商

### 5.2 分层记忆系统（四层架构）

基于 2025-2026 年多项调研（arXiv 2603.29194、2602.06052、2603.07670）的收敛分类：

| 层次 | 范围 | 关键属性 | 候选实现 |
|------|------|---------|---------|
| **工作记忆**（Working Memory）| 会话内 | 有限容量，当前 context window | 上下文注意力窗口；LangGraph StateGraph |
| **情节记忆**（Episodic Memory）| 跨会话历史 | 带时间戳的具体经历，单次学习 | Mem0 / Letta / 向量数据库 |
| **语义记忆**（Semantic Memory）| 抽象知识 | 去情境化事实；用户画像；提炼模式 | RAG + 向量存储 + 知识图谱 |
| **程序记忆**（Procedural Memory）| 行为规则 | 学习到的策略；动作模式；风格 | 可编辑规则存储 / 微调权重 |

**关键实现**：
- **Mem0**（mem0.ai）：3 层层级（用户/会话/agent）；向量+图谱存储；比 OpenAI 内置记忆准确率提升 26%；token 消耗减少 90%
- **Letta（前 MemGPT）**：OS 隐喻，agent 主动管理自身记忆（读/写/搜索）；UC Berkeley 研究成果
- **MemMachine**（arXiv 2604.04853）：保真记忆——分离"实际发生什么"（情节真值）与"agent 的解释"，防止记忆污染
- **可携带 Agent 记忆**（arXiv 2605.11032）：跨异构 agent 的来源验证记忆迁移——直接关联 agent 加入/离开网络的场景

**隐私要求**：长期记忆本地存储，不上传云端；LAAS 架构对接

### 5.3 工具集成三层协议

```
MCP（工具访问层）   ← agent 访问数据/工具的垂直标准
A2A（任务委托层）   ← agent 委托任务给另一个 agent
ASM（角色信任层）   ← agent 协作的角色身份 + 声誉信任（我们的创新）
```

三层不竞争，在同一 agent 中可同时使用。

### 5.4 自进化机制（2026 年前沿）

| 机制 | 描述 | 性能提升 | 来源 |
|------|------|---------|------|
| **Darwin Gödel Machine (DGM)** | agent 修改自身代码包括自修改逻辑；开放性进化 | SWE-bench: 20%→50% | 2025 |
| **EvoAgentX** | 自动工作流进化；TextGrad/AFlow/MIPRO 优化；NL→多 agent 工作流→迭代评估→自改进 | 多 benchmark 显著提升 | GitHub: EvoAgentX/EvoAgentX (2.5k ⭐)|
| **本征元学习 (IML)** | agent 评估自身表现 → 规划下一步学习 → 评估是否学到了 | 2025 下半年主流范式 | arXiv 2601.11974 |
| **自博弈自改进** | agent 生成自己的训练信号；无外部奖励信号 | — | arXiv 2512.02731 |
| **可编辑记忆系统** | 通过修改和整合记忆实现行为进化，无需更新权重 | — | Letta / MemMachine |

**Paper 3 的自进化路径**：从协作历史提取经验 → 失败模式学习 → 策略更新（基于 IML 范式），无需重训练基础模型。

### 5.5 安全与隐私

| 方案 | 机制 | 适用场景 |
|------|------|---------|
| **本地模型推理** | LLM 完全在设备运行（Ollama/LM Studio）| 隐私优先场景首选 |
| **LAAS + DP** | 本地特征提取；DP 噪声（ε=1.0, δ=10⁻⁵）| SC 向量化（Paper 2）|
| **沙盒执行** | smolagents E2B/Docker/Wasm | 防止数据通过 agent 行为泄漏 |
| **本地签名** | 私钥不离开设备 | ERC-8004 身份操作 |
| **ZK 证明** | Bulletproofs/Halo2（可选）| 高价值场景的声明验证 |

---

## 五点五、业界最先进 Agent 框架对比（2026-05-25 调研结果）

| 框架 | GitHub | Stars | 多 agent | 开源模型 | 自进化 | Paper 3 借鉴点 |
|------|--------|-------|---------|---------|--------|--------------|
| **OpenHands** | All-Hands-AI/OpenHands | 74,800 | 部分 | ✅ | ❌ | CodeAct 范式；事件流审计架构；72% SWE-Bench |
| **CrewAI** | crewAIInc/crewAI | 52,100 | ✅ 核心 | ✅ | ❌ | 角色定义模式（role+goal+backstory）；最接近我们的社会角色代理概念 |
| **OpenManus** | FoundationAgents/OpenManus | 56,400 | ✅ flow | 部分 | ❌ | MCP 优先工具集成架构；开源快速复刻模式 |
| **Crawl4AI** | unclecode/crawl4ai | 51,000 | Via MCP | ✅ | ❌ | 知识获取层；MCP server 模式；自适应停止算法 |
| **Agno** | agno-agi/agno | 40,300 | ✅ teams | ✅ | ❌ | 无状态 agent + runtime 拥有持久状态（生产级扩展模式）|
| **LangGraph** | langchain-ai/langgraph | 32,900 | ✅ graphs | ✅ | ❌ | 时间旅行调试；持久状态；Human-in-the-loop |
| **smolagents** | huggingface/smolagents | 27,500 | ✅ | ✅ | ❌ | ~1000 行核心；代码即行动范式；沙盒安全执行 |
| **ElizaOS** | elizaOS/eliza | 18,400 | ✅ swarms | ✅ | 部分 | Web3 身份集成；character file 持久身份；插件注册模式 |
| **Hermes** | NousResearch/Hermes-Function-Calling | — | — | ✅ | ❌ | 最佳开源工具调用模型；ChatML 格式；公开训练数据集 |
| **AgentKit** | coinbase/agentkit | 1,200 | ❌ | ✅ | ❌ | 经济代理接入（钱包+链上）；action provider 抽象 |
| **EvoAgentX** | EvoAgentX/EvoAgentX | 2,500 | ✅ | ✅ | ✅ 核心 | 唯一以自进化为核心特性的框架 |

**关键发现**：没有任何现有框架同时具备：
1. 通过 Nostr/DID 的开放网络身份
2. 角色承载 ASM 协议协调
3. 隐私本地模型推理
4. 跨会话自进化

→ **这四点组合就是 Paper 3 的差异化贡献声明**。

---

## 六、学术定位与研究方法

### 研究类型
**设计科学研究（Design Science Research）**：
1. 识别问题（接入摩擦）
2. 设计解决方案（最小化接口 + 参考实现）
3. 评估（摩擦指标量化 + 场景验证）
4. 贡献（设计模式 + 参考实现开源）

### 评估标准
- **接入时间**：从零配置到首次成功协作任务完成的时间
- **经济成本**：每次协作的计算成本（token 消耗 + Gas 费用）
- **隐私暴露面**：原始数据离开本地设备的比例（目标：0%）
- **任务完成率**：在三个验证场景中的成功率

### 与工业界的关系
Paper 3 是工程实践论文，但有学术贡献：
- 摩擦分析框架是新的研究方法
- 分层能力假设模型是新的分类体系
- 开源参考实现可被后续研究复用

---

## 七、与业界框架的关系（Paper 3 §2 展开用）

| 框架 | 我们借鉴什么 | 我们超越什么 |
|------|-----------|-----------|
| **ElizaOS**（Web3 agent）| character file 持久身份；Nostr keypair 模式；插件注册模式 | 加入 ASM 角色协议 + SC 声誉体系 |
| **CrewAI**（角色多 agent）| role + goal + backstory 角色定义原语（最接近社会角色代理）| 跨组织开放无许可网络（不限于团队内）|
| **OpenHands**（SE agent）| CodeAct 范式；事件流审计架构（可追溯性）| 社会协作层（不只是任务完成）|
| **Agno**（记忆+团队 agent）| 无状态 agent + runtime 拥有持久状态（生产扩展模式）| LAAS 隐私保护层；ASM 协议集成 |
| **LangGraph**（状态 agent）| 时间旅行调试；有状态任务图；Human-in-the-Loop | ASM 消息协议替代 LangChain 消息层 |
| **AgentKit**（链上 agent）| action provider 抽象；经济代理接入模式 | ERC-8004 + SBT 声誉体系；信用机制 |
| **smolagents**（轻量 agent）| ~1000 LoC 可审计核心；代码即行动；沙盒安全 | 开放网络协作协议层 |
| **EvoAgentX**（自进化）| TextGrad/AFlow 优化循环；NL→工作流→迭代评估 | 与 ASM 协作历史结合的社会驱动自进化 |
| **Crawl4AI**（数据获取）| MCP server 模式；自适应停止算法；LLM 就绪输出 | LAAS 隐私过滤层（本地数据不出境）|
| **Hermes 4.3-36B**（模型）| 开源工具调用模型；ChatML 格式；公开训练数据集方法论 | 基于 ASM 场景的特定微调（采购/推荐/匹配）|

---

## 八、关键学术引用（Paper 3 §2 参考文献）

| 论文/来源 | 引用点 |
|---------|--------|
| CodeAct: Executable Code Actions Elicit Better LLM Agents (NeurIPS 2024) | 代码即行动范式 |
| A Survey of Self-Evolving Agents (arXiv 2507.21046) | 自进化机制综述 |
| Multi-Layered Memory Architectures for LLM Agents (arXiv 2603.29194) | 四层记忆架构 |
| Rethinking Memory Mechanisms of Foundation Agents (arXiv 2602.06052) | 记忆机制反思 |
| MemMachine: Ground-Truth-Preserving Memory (arXiv 2604.04853) | 保真记忆防污染 |
| Portable Agent Memory: Provenance-Verified Transfer (arXiv 2605.11032) | 跨 agent 记忆迁移 |
| Eliza: A Web3-friendly AI Agent OS (arXiv 2501.06781) | Web3 agent 身份 |
| The Trust Fabric: Decentralized Interoperability (arXiv 2507.07901) | 去中心化可信声明 |
| Trusted Identities for AI Agents via eSIM (arXiv 2504.16108) | agent 身份基础设施 |
| AgentFlux: Decoupled Fine-Tuning & Inference (arXiv 2510.00229) | 云训练/本地推理解耦 |
| Gödel Agent: Self-Referential Self-Improvement (arXiv 2410.04444) | 自参考自改进框架 |
| A2A Protocol v1.0 (Linux Foundation, 2025) | 任务委托层标准 |
| MCP 2025-11-25 (Anthropic → Linux Foundation) | 工具访问层标准 |

## 九、开放问题（待后续研究填充）

- [ ] 具体的接入摩擦量化方法（如何定义"接入时间"的起点和终点）
- [ ] 分层记忆系统最终选型（Mem0 vs Letta vs 自研；本地 vs 云端权衡）
- [ ] 自进化具体路径（IML 范式 + EvoAgentX 优化循环 + ASM 协作历史结合）
- [ ] Tier A/B/C 能力层级的具体技术判定标准
- [ ] 参考实现开发工作量估计（目标：8 周内完成 Tier A 基础版本）
- [ ] 是否需要真实部署测试（vs 模拟实验），以及测试环境设计
- [ ] "小龙虾"（Crawl4AI）具体如何与 LAAS 隐私层结合（本地数据过滤链路）
