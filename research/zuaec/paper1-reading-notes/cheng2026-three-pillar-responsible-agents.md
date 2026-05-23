# [Cheng, Cheng, Siu 2026] Toward Safe and Responsible AI Agents: A Three-Pillar Model for Transparency, Accountability, and Trustworthiness

**arXiv**: 2601.06223 | **Year**: 2026 | **Authors**: Edward C. Cheng, Jeshua Cheng, Alice Siu | **Venue**: arXiv preprint / conference paper (cs.CY + cs.AI; submitted Jan 9, 2026; no specific conference named)
**Cluster**: Governance & Regulation / Responsible AI
**Status**: Full read

---

## ⚠️ DIFFERENTIATION ALERT: Their "Three Pillars" vs. Our "Three Pillars"

This paper also uses "Three-Pillar" framing — but the pillars are **completely different** from ours:

| | **Cheng et al. (TAT)** | **Our Paper 1 (P/SC/N)** |
|---|---|---|
| Pillar 1 | **Transparency** — lifecycle documentation, auditability | **P** — Collaboration Protocols (message semantics, role contracts) |
| Pillar 2 | **Accountability** — decision journaling, attribution | **SC** — Social Capital (quantified trust scores, reputation) |
| Pillar 3 | **Trustworthiness** — human oversight, fallback safeguards | **N** — Permissionless Network (open participation, no central gatekeeper) |
| **Focus** | How to make existing AI agents *safe within institutional control* | How to build *open, self-organizing* agent collaboration networks |
| **Unit of analysis** | Individual AI agent + human overseer | Network of heterogeneous agents operating without central authority |
| **Governance model** | Human-in-the-loop escalation ladder | Algorithmic reputation + protocol-enforced contracts |
| **Key assumption** | Agents operate under institutional supervision | Agents operate in permissionless, open environments |

Their TAT framework is an *internal safety framework* for deploying agents within organizations. Our P/SC/N framework is a *network architecture* for enabling open multi-agent ecosystems. The overlap is at the level of shared vocabulary ("pillars," "trust") but not at the conceptual level.

---

## Core Claim
Safe agentic AI deployment requires progressive trust-building through four evolutionary stages (Assisted → Collaborative → Supervised Autonomy → Full Autonomy with Governance), operationalized via three pillars — Transparency, Accountability, Trustworthiness — analogous to the autonomous vehicle development ladder.

## Key Evidence / Numbers
- Four autonomy stages proposed: Assisted Agents, Collaborative Agents, Supervised Autonomy, Full Autonomy with Human Governance
- Transparency: continuous documentation across three agent lifecycle stages — initiation (goal-setting), active operation (activity logging), completion (outcome records)
- Accountability: "comprehensive decision journaling that records not only the outcomes but also the reasoning and contextual factors behind each choice"
- Trustworthiness: human-set autonomy levels per agent, with fallback safeguard mechanisms
- Three operational work streams: Stanford Deliberative Democracy Lab (public deliberation), Safe AI Agent Consortium (cross-industry), open-source tooling for agent operating environments
- Known risks acknowledged: hallucinations, data bias, goal misalignment

## Paper 1 Relevance
**§5 (Responsible AI / Governance — all three pillars)**: This paper must be cited in Paper 1 §5 *precisely because* it uses similar "Three Pillars" language — failure to engage with it would be a peer review liability. The citation strategy: acknowledge Cheng et al.'s TAT framework as addressing *internal organizational safety*, then sharply distinguish our P/SC/N as addressing *inter-organizational network coordination* in permissionless settings. Their framework presupposes a human overseer with authority to set autonomy levels — our N pillar specifically addresses the case where no such central authority exists. This is a competitive paper that strengthens our novelty claim by contrast.

## Paper 2 Relevance
**§6 (Threat Model / Governance)**: Their Transparency pillar (lifecycle documentation) maps onto ASM's auditability requirements — ASM messages should carry enough metadata for post-hoc audit. Their Accountability pillar (decision journaling) implies ASM should support a "rationale field" in messages, not just action fields. However, their framework assumes a centralized logging infrastructure, whereas ASM §6 must address threats that arise precisely when no central log authority exists (log tampering, selective disclosure). This tension is a useful differentiator to articulate in ASM §6.

## Verdict
⭐⭐⭐⭐ | A direct "same-vocabulary competitor" that must be explicitly engaged in Paper 1 §5 to establish our novelty; TAT pillars (internal institutional safety) vs. P/SC/N pillars (open network architecture) is a clean, defensible distinction that strengthens our contribution claim.

## Jason's feedback
> TAT（Transparency / Accountability / Trustworthiness）是**能力层面**的三支柱——它在说如何让单个 agent 本身变得更透明、可审计、可信任。
>
> 我们的 P/SC/N 是**关系层面**的三支柱——我们解决的是 agent 之间如何建立协作关系、形成社会资本、构建开放协作网络。
>
> 核心洞见：**建立关系比建立能力更重要**。能力可以快速迭代（今天 GPT-4，明天 GPT-5），但没有好的协作关系和协作网络，agent 之间就缺少创新和涌现的条件。真正的价值不在于单个 agent 有多强，而在于 agent 之间能否形成有效的协作网络——这才是我们框架的核心贡献。
>
> 论文差异化表述建议（Paper 1 §5）：
> "Cheng et al. (2026) address the *capability layer* of responsible AI: making individual agents internally transparent, accountable, and trustworthy. Our framework addresses a complementary but higher-order *relationship layer*: the protocols, social capital mechanisms, and network structures that enable agents to collaborate, build trust across interactions, and generate emergent outcomes. A perfectly transparent and accountable agent still requires relationship infrastructure to participate productively in an open multi-agent network."
