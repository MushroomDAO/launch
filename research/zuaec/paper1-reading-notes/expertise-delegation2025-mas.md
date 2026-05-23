# [Xu et al. 2025] Towards Multi-Agent Reasoning Systems for Collaborative Expertise Delegation

**arXiv**: 2505.07313 | **Year**: 2025 | **Authors**: Baixuan Xu, Chunyang Li, Weiqi Wang, et al. (HKUST, WeBank, Hong Kong PolyU) | **Venue**: arXiv preprint
**Cluster**: Multi-Agent Collaboration / Expertise Delegation / Role Design
**Status**: Full read

## Core Claim
Three design dimensions — expertise-domain alignment, collaboration paradigm (diversity-driven vs. structured workflow), and system scale — jointly determine collective reasoning quality in multi-agent LLM systems, with domain-aligned diverse collaboration yielding the best performance-to-cost ratio.

## Key Evidence / Numbers
- **Domain alignment**: 75% of aligned configurations achieved highest accuracy; +6.75% avg improvement in Health/Law domains (contextual reasoning)
- **Diversity-driven collaboration beats structured workflows**: +1.75% avg in Business/Health; +1.25% overall
- **Scale**: Adding agents consistently improves performance non-linearly, especially for contextual tasks; math shows marginal gains
- **Token efficiency**: Contextual reasoning tasks yield higher performance-per-token than mathematical reasoning
- Dataset: MMLU-pro (Math, Business, Health, Law) with DeepSeek-R1-Distill-Qwen-7B
- Sequential communication: agent i receives full output from i-1 but only summary answers from prior agents

## Key Mechanism — Expertise Delegation
- Agents assigned specialized roles via system prompts encoding expertise group, formal role, and responsibilities
- Two collaboration modes: (a) diversity-driven — fine-grained sub-domain specialization; (b) structured workflow — functional roles (solver/critic/coordinator)
- Knowledge Recall: role framing activates domain-specific knowledge dormant in the base model
- Perspective Synthesis: sequential cascade allows each agent to refine prior reasoning rather than start fresh
- Sequential protocol avoids context explosion while enabling iterative refinement

## Paper 1 Relevance
**§3 (Role Agency) + §4 (Social Capital)** — This paper is the closest existing work to our social role agency paradigm. Agents are given *social roles with epistemic identity* (domain expert personas) rather than capability labels, and the paper shows this outperforms functional capability roles (solver/critic). The "Knowledge Recall" finding is particularly important: role framing does not just organize work — it activates deeper knowledge, suggesting that social identity has epistemic effects beyond mere task assignment. This is empirical support for our claim that social role agency is not just an organizational metaphor but a functional upgrade. However, the paper stops short of our framework: it does not address persistent identity across sessions, reputation accumulation (SC), or open/permissionless participation (N). Cite in §3.2 (role agency evidence) and §4.1 (social capital motivation — what's missing from this paper).

**Tension**: The "structured workflow" (solver/critic/coordinator) underperformance vs. diversity-driven may seem to challenge role specialization. Clarify in Paper 1: fixed functional roles ≠ social role agency; SC-mediated role emergence is different from pre-assigned workflow positions.

## Paper 2 Relevance
**ASM §3 (Role Declaration) + §4 (Delegation Protocol)** — The sequential communication algorithm (agent i → i+1 with selective history) is a concrete prior for ASM's message-passing design. ASM could adopt a similar selective-history approach to prevent context explosion while preserving reasoning chains. The expertise group + formal role + responsibilities triple maps naturally to ASM's role-bearing agent profile structure.

## Verdict
⭐⭐⭐⭐⭐ | The strongest empirical bridge between capability-container and social role paradigms — shows role identity activates deeper capabilities; essential for §3/§4 of Paper 1 and §3 of Paper 2.

## Jason's feedback
> （请在此处写入你的feedback）
