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

## 五、关键技术选型（待研究后确认）

### 5.1 基础模型
- **首选**：DeepSeek v4.0 Pro（开源、性能强、可本地部署）
- **备选**：Qwen2.5-72B、Llama-3.3-70B
- **原则**：开源优先，支持自定义模型接入

### 5.2 记忆系统
- 分层记忆：工作记忆（context window）/ 情节记忆（向量数据库）/ 语义记忆（知识图谱）/ 程序记忆（工具/技能库）
- 候选实现：MemGPT / Zep / Mem0 / 自研
- **隐私要求**：长期记忆本地存储，不上传云端

### 5.3 工具集成
- MCP 协议（工具标准层）
- A2A 协议（任务委托层）
- ASM 协议（角色信任层）

### 5.4 自进化机制（待研究）
- 从协作历史中提取经验
- 失败模式学习
- 策略更新频率控制

### 5.5 安全与隐私
- LAAS 本地特征提取
- DP 噪声保护（ε=1.0, δ=10⁻⁵）
- 本地签名（不暴露私钥给云端）
- ZK 证明（可选，高价值场景）

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

## 七、与业界框架的关系（待 Paper3 §2 详细展开）

| 框架 | 我们借鉴什么 | 我们超越什么 |
|------|-----------|-----------|
| Eliza（Web3 agent）| 链上身份集成方式 | 加入 ASM 角色协议 + SC 声誉 |
| CrewAI（角色多 agent）| 角色定义模式 | 跨组织开放网络（不限于团队内）|
| OpenHands（SE agent）| 任务执行框架 | 社会协作层（不只是任务完成）|
| Agno/Phidata（记忆 agent）| 分层记忆系统设计 | LAAS 隐私保护层 |
| LangGraph（状态 agent）| 有状态任务图 | ASM 消息协议替代 LangChain 消息 |
| AgentKit（链上 agent）| 链上交易集成 | ERC-8004 + SBT 声誉体系 |

---

## 八、开放问题（待后续研究填充）

- [ ] 具体的接入摩擦量化方法（如何定义"接入时间"的起点和终点）
- [ ] 分层记忆系统的具体技术选型（MemGPT vs Mem0 vs Zep vs 自研）
- [ ] 自进化机制的具体实现路径（RL? DPO? RAG 更新?）
- [ ] Tier A/B/C 能力层级的具体技术标准（如何判定 agent 达到哪个 Tier）
- [ ] 参考实现的开发工作量估计（是否在 8 周内可完成基础版本）
- [ ] Paper 3 是否需要真实部署测试，还是模拟实验足够
