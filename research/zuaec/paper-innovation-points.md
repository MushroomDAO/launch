# 两篇论文的核心创新点（One-Sentence Pitch）

> **创建日期**：2026-05-20
> **目的**：用一句话锁定每篇论文的学术原创性。任何论文的接受度首先取决于这一句话能否说服审稿人"这是新东西、且值得发表"。
> **状态**：v0 草案，待 Jason 确认

---

## Paper 1：核心创新点

### 一句话陈述（推荐版本，Codex review 后修订）

> **We bridge AI agent research with classical institutional theory (Ostrom, Bourdieu, Putnam) to argue that capability, data, and alignment accounts of multi-agent AI failures are incomplete without institutional embedding, and offer a falsifiable three-pillar framework (collaboration protocol, quantified social capital, permissionless network) for AI agent socialization, grounded in a PRISMA-ScR scoping review of 2022-2026 literature.**

中文版：
> **本文将 AI Agent 研究与经典制度理论（Ostrom、Bourdieu、Putnam）相桥接，诊断出当前多智能体 AI 系统的根本缺口是缺乏"制度性嵌入"——不是能力、数据、或对齐问题——并基于 2022-2026 年文献的 PRISMA-ScR scoping review，提出第一个可证伪的"三要素框架"（协作协议、量化社会资本、无许可网络）来填补这一缺口。**

### 关键词分解（构成原创性的 5 个元素）

1. **"Bridge"** — 跨学科桥接：把多智能体系统研究与经典社会学制度理论连接起来（**这是大多数现有工作不做的**）
2. **"Diagnose"** — 提出明确的诊断：不是能力问题，不是数据问题，不是对齐问题，**是制度问题**（**这是反直觉的、有挑战性的论断**）
3. **"First falsifiable"** — 首次明确给出可证伪的命题（**这是从"愿景陈述"升级为"科学假说"的关键**）
4. **"Three-pillar framework"** — 具体框架名称（**给后续研究者一个可引用、可批评的目标**）
5. **"PRISMA-ScR"** — 方法论严谨（**与单纯 narrative review 区分**）

### 与同类工作的差异

| 同类工作 | 它的贡献 | 我们的不同 |
|---------|---------|----------|
| Chakraborty (2026) 共演化理论 | 提出人-AI 共演化的治理框架 | 我们提供**三要素的结构性分析**（不仅是治理动力学）|
| Han et al. (2026) 社会物理学议程 | 提出 6 个研究方向 | 我们提供**统一的诊断框架**（不是议程清单）|
| Feng et al. (2026) PNAS 最优嵌入 | 数学证明 Agent 比例 | 我们**将其推广为命题 P3**，并嵌入更大框架 |
| Wooldridge MAS 教材 | 多智能体系统经典 | 我们**接入社会学维度**（这是传统 MAS 不做的） |

---

## Paper 2：核心创新点

### 一句话陈述（推荐版本，Codex review 后修订）

> **We present ASM, an agent communication protocol that integrates verifiable human-authorization, privacy-preserving reputation accumulation, and permissionless multi-agent coordination as joint design goals—operationalizing the institutional embedding framework with a reference implementation path on public blockchain (currently on Sepolia testnet with planned OP mainnet deployment).**

中文版：
> **本文提出 ASM，首个同时实现可验证人类授权、隐私保护声誉积累、与无许可多智能体协作三者的 Agent 通信协议——在公链上部署了 reference implementation，将"制度性嵌入"框架工程化落地。**

### 关键词分解（构成原创性的 4 个元素）

1. **"Simultaneously"** — 三个属性同时满足（**目前没有任何已有协议做到，详见 §2.6 对比表**）
2. **"Verifiable human-authorization"** — 把人类授权变成可验证关系（**填补 FIPA ACL / MCP 的核心空白**）
3. **"Privacy-preserving reputation"** — 用 ZK 实现隐私保护（**对应 eBay/EigenTrust 评分制的革命**）
4. **"Deployed reference implementation"** — 不只是规范，是真实部署（**与纯协议规范论文的关键差异**）

### 与同类工作的差异（六维度对比表，已在 paper2-draft-v0 §2.6）

| 协议 | 结构化消息 | 加密身份 | 人类授权 | 隐私声誉 | 无许可 | 多方协调 |
|------|----------|---------|---------|---------|--------|---------|
| FIPA ACL | ✅ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Anthropic MCP | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| DIDComm | ✅ | ✅ | ⚠️ | ❌ | ⚠️ | ❌ |
| Nostr | ⚠️ | ✅ | ❌ | ❌ | ✅ | ⚠️ |
| EigenTrust | ❌ | ❌ | ❌ | ❌ | ⚠️ | ❌ |
| **ASM** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

ASM 是唯一全 ✅ 的协议。

---

## 三、两篇论文的联合贡献（Combined Pitch）

把两篇论文当成一个 portfolio 卖给学术界，one-liner：

> **We provide a framework / protocol / implementation stack for socially-embedded AI agents—from the conceptual framework grounded in classical sociology (Paper 1), through the protocol specification with privacy-preserving cryptographic primitives (Paper 2), to the reference implementation on public blockchain (Mycelium Protocol, currently on Sepolia testnet with planned OP mainnet deployment).**

中文：
> **我们为社会化嵌入的 AI Agent 提供框架 / 协议 / 实现三层栈：从基于经典社会学的概念框架（Paper 1），到含隐私保护密码学原语的协议规范（Paper 2），再到公链上的 reference implementation（Mycelium Protocol，当前在 Sepolia 测试网，OP mainnet 部署计划中）。**

---

## 四、给 Jason 的 review 问题

请确认或修改：

1. **Paper 1 的一句话**：你认为"诊断为制度问题（不是能力/数据/对齐）"是足够强、足够有挑战性的论断吗？还是太抽象？
2. **Paper 2 的一句话**：强调"首个同时实现三者"是足够清晰的差异点吗？审稿人会不会反问"为什么之前没人做？"
3. **联合 pitch**：把两篇当 portfolio 卖、提"Agent 社会工程学"作为新学科——这个野心合适吗？还是降到"框架 + 协议"两件套？
4. **要不要在 abstract 中直接用这些 one-liner？** 当前 paper1-draft-v0 abstract 偏长，可以剪短到围绕 one-liner 展开。

定稿后这两句一句话会作为：
- 每篇 abstract 的第一句
- arXiv 提交时的 "Comments" 字段
- ZUAEC BP 中描述论文贡献的标准说辞
- 与潜在合作者沟通时的电梯演讲
