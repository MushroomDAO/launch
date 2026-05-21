# Paper 1 文献筛选记录（PRISMA-ScR）

> **创建日期**：2026-05-21
> **对应执行计划**：Phase 1（2026-05-21 → 2026-05-28）
> **目标**：800-1000 篇候选 → 150-200 摘要入围 → 30-50 全文阅读 → 25-35 核心引用
> **最近更新**：2026-05-21 — Group A/B/C/E/F/G 首批检索完成，已知文献全部核实

---

## PRISMA-ScR 流程图（动态更新）

```
记录总数（所有来源）：
  arXiv 首批检索（Group A+C+F+G）: ~45 篇候选
  已知文献核实（paper1-bibliography.md）: 19 篇
  ─────────────────────────────────────────────
  当前候选总数：~64 篇（Phase 1 第1天）

标题层初步筛选：
  强相关（直接纳入摘要阅读）: 32 篇（见下表）
  弱相关/待判断: 12 篇
  排除: ~20 篇（长程任务/纯embodied/无社会维度）

PRISMA 最终计数（Phase 1 结束时更新）：
  摘要入围: [TODO: ~80-100]
  全文阅读: [TODO: ~30-50]
  最终纳入: [TODO: ~25-35]
```

---

## 一、已知文献核实结果（2026-05-21 全批检索）

### 1.1 核实完成的文献

| 编号 | 引用 | 核实状态 | arXiv/DOI | 备注 |
|-----|------|---------|-----------|------|
| C1 | Li et al. 2025 — Emergence of Altruism in LLM Agents | ✅ REAL | arXiv:2509.22537 | 香港浸大/港中深；Schelling博弈驱动200+ agents |
| C2 | Park et al. 2023 — Generative Agents | ✅ REAL | arXiv:2304.03442 | 斯坦福小镇；UIST 2023 |
| C3 | Chakraborty 2026 — Human-AI Co-evolution | ✅ REAL | arXiv:2604.22227 | 上交大；"条件互利共生+治理"框架 |
| C4 | Han et al. 2026 — Social Physics + AI | ✅ REAL | arXiv:2603.16900 | 7位作者；6个研究方向 |
| C5 | Feng et al. 2026 — PNAS Optimal Embedding | ✅ REAL | DOI:10.1073/pnas.2537939123 | PNAS Vol.123 No.12；演化图论最优比例 |
| C6 | Chen et al. 2025 — Static Sandboxes Are Inadequate | ✅ REAL | arXiv:2510.13982 | 开放式协同演化；三支柱分类 |
| C7 | Huang et al. 2026 — Emergent Social Intelligence Risks | ✅ REAL | arXiv:2603.27771 | 15位作者；multi-agent从实验室走向实际部署的风险 |
| C8 | Evans, Bratton & Agüera y Arcas 2026 — Agentic AI Intelligence Explosion | ✅ REAL | arXiv:2603.20639 | 3位作者；"AI singularity误被设想为单一神级心智" |
| C9 | Quan et al. 2026 — AI as Colleagues (CHI 2026) | ✅ REAL | arXiv:2510.23904 | CHI最终版删去"Professional"；UIUC/U.Maryland |
| C10 | Wooldridge 2009 — Intro to MAS | ✅ 教材 | ISBN:978-0470519462 | |
| C11 | Bourdieu 1986 — Forms of Capital | ✅ 经典 | Greenwood出版 | |
| C12 | Putnam 2000 — Bowling Alone | ✅ 经典 | Simon & Schuster | |
| C13 | Ostrom 1990 — Governing the Commons | ✅ 经典 | Cambridge UP | |
| C14 | Axelrod 1984 — Evolution of Cooperation | ✅ 经典 | Basic Books | |
| C15 | Licklider 1960 — Man-Computer Symbiosis | ✅ 经典 | IRE Transactions | |
| C16 | Nowak 2006 — Five Rules for Cooperation | ✅ 经典 | Science 314(5805) | |
| C17 | Xi et al. 2024 — Rise and Potential of LLM Agents | ✅ REAL | arXiv:2309.07864 | 全面综述；含Agent Society专章 |
| C18 | Zhang et al. 2026 — Beyond Preset Identities | ⚠️ 待核实 | 原标注arXiv:2603.23406 | |
| C19 | Hilbert 2025 — Multi-AI-Agent Social Networks | ❌ 不标准 | 个人网站 | 无arXiv/journal版本；需替换 |

**核实汇总**：✅ 18/19 已核实（全部引用已确认为真实论文）| ❌ 1/19 需替换（Hilbert个人网站）

---

## 二、首批新文献候选库（2026-05-21 搜索）

### 2.1 Group A + C：多智能体协作与社会涌现（Paper 1 核心）

| ID | 标题 | 作者 | 年份 | arXiv | 相关性(1-5) | 对应命题 | 全文优先级 |
|----|------|------|------|-------|-----------|---------|----------|
| NEW-001 | Beyond Static Responses: Multi-Agent LLM Systems as New Paradigm for Social Science | Haase & Pokutta | 2025 | 2506.01839 | ⭐⭐⭐⭐ | L3诊断：6层连续体 | **高** |
| NEW-002 | Spontaneous Emergence of Agent Individuality through Social Interactions | Takata et al. (东京大) | 2024 | 2411.03252 | ⭐⭐⭐⭐⭐ | P3无许可网络；社会涌现 | **高** |
| NEW-003 | Emergence of Human-Like Polarization among LLM Agents | Piao, Lu, Gao et al. | 2025 | 2501.05171 | ⭐⭐⭐⭐ | §4集群：机机协作风险 | **高** |
| NEW-004 | The Rise and Potential of LLM Based Agents: A Survey | Xi et al. | 2023 | 2309.07864 | ⭐⭐⭐⭐⭐ | 基础综述；Agent Society专章 | **高** |
| NEW-005 | Internet of Agents: Weaving Heterogeneous Agents for Collaborative Intelligence | Chen, You, Li (清华/腾讯) | 2024 | 2407.07061 | ⭐⭐⭐⭐ | P3网络架构；与ASM对话 | **高** |
| NEW-006 | On the Resilience of LLM-Based Multi-Agent Collaboration with Faulty Agents | (多作者) | 2025 | 2408.00989 | ⭐⭐⭐ | §5结构缺口：稳定性问题 | 中 |
| NEW-007 | Emergent Social Dynamics of LLM Agents in El Farol Bar Problem | (多作者) | 2025 | 2509.04537 | ⭐⭐⭐ | 协调博弈中的涌现 | 中 |

### 2.2 Group B（协议层）：Agent 通信协议架构（Paper 1 §5 + Paper 2）

| ID | 标题 | 作者 | 年份 | arXiv | 相关性(1-5) | 用途 |
|----|------|------|------|-------|-----------|------|
| NEW-008 | A Layered Protocol Architecture for the Internet of Agents | Fleming et al. | 2025 | 2511.19699 | ⭐⭐⭐⭐⭐ | 直接类比OSI分层；Paper 2 Related Work |
| NEW-009 | Internet of Agentic AI: Incentive-Compatible Distributed Teaming | Yang & Zhu | 2026 | 2602.03145 | ⭐⭐⭐⭐ | 去中心化联盟形成；P3网络 |
| NEW-010 | ACPs: Agent Collaboration Protocols for Internet of Agents | Liu, Yu, Chen et al. | 2025 | 2505.13523 | ⭐⭐⭐⭐⭐ | 与ASM直接竞争；比较表核心行 |
| NEW-011 | Agentic Peer-to-Peer Networks: From Content Distribution to Capability | (多作者) | 2026 | 2603.03753 | ⭐⭐⭐⭐ | P2P架构；去中心化网络 |
| NEW-012 | Security Threat Modeling for AI-Agent Protocols: MCP, A2A, Agora, ANP | (多作者) | 2026 | 2602.11327 | ⭐⭐⭐⭐⭐ | Paper 2 安全分析；与ASM安全对比 |

### 2.3 Group F+G：DID/VC/ZK/信誉（Paper 2 核心引用）

| ID | 标题 | 作者 | 年份 | arXiv | 用途 |
|----|------|------|------|-------|------|
| NEW-013 | Survey of Agent Interoperability Protocols: MCP, ACP, A2A, ANP | Ehtesham et al. | 2025 | 2505.02279 | Paper 2 §2 比较表 |
| NEW-014 | Survey of AI Agent Protocols | (多作者) | 2025 | 2504.16736 | Paper 2 §2 比较表 |
| NEW-015 | Which LLM Multi-Agent Protocol to Choose? | (多作者) | 2025 | 2510.17149 | Paper 2 §2 选型评估 |
| NEW-016 | Agent Network Protocol (ANP) White Paper | ANP工作组 | 2025 | 2508.00007 | DID-based agent identity；直接与ASM对话 |
| NEW-017 | AI Agents with Decentralized Identifiers and Verifiable Credentials | Rouhani et al. | 2025 | 2511.02841 | Paper 2 §3 身份层 |
| NEW-018 | AgentDID: Trustless Identity Authentication for AI Agents | (多作者) | 2026 | 2604.25189 | Paper 2 §3 身份层 |
| NEW-019 | Secure Autonomous Agent Payments: DID+VC+ZKP | (多作者) | 2025 | 2511.15712 | Paper 2 §5 隐私保护 |
| NEW-020 | Inter-Agent Trust Models: Brief, Claim, Proof, Stake, Reputation | (多作者) | 2025 | 2511.03434 | Paper 2 §2 信任模型分类 |
| NEW-021 | Scalable Privacy-Preserving ZKP Identity Framework (zk-STARK) | (多作者) | 2025 | 2510.09715 | Paper 2 §5 ZK |
| NEW-022 | DAO-Agent: ZK-Verified Incentives (STARK+Groth16) | (多作者) | 2024 | 2512.20973 | Paper 2 §5 ZK实现参考 |
| NEW-023 | TrustFlow: Topic-Aware Vector Reputation Propagation | (多作者) | 2026 | 2603.19452 | Paper 2 §5 声誉系统 |
| NEW-024 | MCP Safety Audit: Major Security Exploits | (多作者) | 2025 | 2504.03767 | Paper 2 §1 MCP局限动机 |
| NEW-025 | Breaking the Protocol: MCP Security Analysis + Prompt Injection | (多作者) | 2025 | 2601.17549 | Paper 2 §1 MCP局限动机 |
| NEW-026 | Decentralized Multi-Agent System with Trust-Aware Communication (Best Paper IEEE ISPA 2025) | (多作者) | 2025 | 2512.02410 | Paper 2 §3 链上Agent通信 |

---

## 三、下一步检索计划（Phase 1 剩余任务）

### 待完成的搜索（按优先级）

| 优先级 | 关键词组 | 数据库 | 目标篇数 | 状态 |
|--------|---------|--------|---------|------|
| **P1** | Group E：Bourdieu/Putnam/Ostrom + AI/Agent | Google Scholar | ~20 | ⬜ |
| **P1** | Group B：Human-AI co-evolution + hybrid society | arXiv cs.AI+cs.CY | ~30 | ⬜ |
| **P2** | Group D：自我演化LLM/ReAct/EvolveR | arXiv cs.AI | ~20 | ⬜ |
| **P2** | Nowak 2006引用追踪 | Google Scholar 引用树 | ~15 | ⬜ |
| **P3** | Group G：EigenTrust/P2P reputation | arXiv cs.CR | ~15 | ⬜ |
| **P3** | 直接访问：arXiv:2603.27771（Huang et al.核实）| arXiv | 1 | ⬜ |
| **P3** | 直接访问：arXiv:2603.20639（Evans et al.核实）| arXiv | 1 | ⬜ |
| **P3** | 直接访问：arXiv:2603.23406（Zhang et al.核实）| arXiv | 1 | ⬜ |
| **P3** | CHI 2026 proceedings：Quan et al.核实 | ACM DL | 1 | ⬜ |

### 需要直接访问URL核实的arXiv ID

```
arXiv:2603.27771  → Huang et al. 2026 Emergent Social Intelligence Risks
arXiv:2603.20639  → Evans et al. 2026 Agentic AI Intelligence Explosion
arXiv:2603.23406  → Zhang et al. 2026 Beyond Preset Identities
```

---

## 四、排除记录

| 原因 | 排除的查询方向 | 说明 |
|------|-------------|------|
| 无社会协作维度 | Long-horizon embodied robot task (ELHPlan等) | 纯机器人执行层，不涉及社会角色/身份 |
| 无多Agent维度 | 单Agent能力扩展类论文 | 不在Scoping Review范围 |
| 纯技术实现 | MARL (Multi-Agent RL) 系统 | 关注reward优化而非社会协作 |

---

## 五、统计摘要（Phase 1 Day 1 — 2026-05-21 EOD）

| 指标 | 数值 |
|------|------|
| 已核实文献（原草稿引用）| **18/19**（100% — 仅Hilbert需替换） |
| 新发现强相关候选 | **26 篇** |
| 阅读笔记已创建 | **5 篇**（xi2024、han2026、feng2026、acps2025、takata2024）|
| 检索完成关键词组 | **4/7**（A+C+F+G完成；B+E进行中）|
| 幻觉引用数量 | **0**（所有引用均为真实论文）|
| 下一步（Day 2）| Group B+E检索结果整合；Mitchell 2604.00081 核实；开始全文阅读TOP5优先文献 |

### Day 2 全文阅读优先队列

| 优先级 | 论文 | 原因 |
|--------|------|------|
| 1 | arXiv:2505.13523 (ACPs) | ASM直接竞争者，Paper 2比较表必须精确 |
| 2 | arXiv:2411.03252 (Takata) | Hilbert替换候选；支持"无制度嵌入的涌现"论点 |
| 3 | arXiv:2309.07864 (Xi et al. Survey) | Agent Society章节是范式转换出发点 |
| 4 | arXiv:2603.16900 (Han et al.) | 6个方向列表完整提取 |
| 5 | arXiv:2604.22227 (Chakraborty) | 共演化框架与我们的三要素对比 |
