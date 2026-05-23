# [Sumers et al. 2023] CoALA: Cognitive Architectures for Language Agents

**arXiv**: 2309.02427 | **Year**: 2023 | **Authors**: Theodore R. Sumers, Shunyu Yao, Karthik Narasimhan, Thomas L. Griffiths (Princeton University) | **Venue**: arXiv preprint (TMLR 2024)
**Cluster**: Agent Architecture / Cognitive Frameworks
**Status**: Full read

## Core Claim
Drawing from cognitive science and symbolic AI, CoALA proposes a unified conceptual framework organizing language agents across three dimensions — memory, action space, and decision-making — to enable systematic comparison and design of agent architectures.

## Key Evidence / Numbers
- Framework covers all major memory types: working memory (across LLM calls), long-term episodic, semantic, and procedural memory
- Action space taxonomy: external grounding actions + internal reasoning/retrieval/learning actions
- Decision-making cycle: proposal → evaluation → selection → execution
- Case studies demonstrate that diverse existing agents (ReAct, Voyager, Generative Agents, etc.) can all be expressed in CoALA's vocabulary
- Framework reveals that sophisticated internal processes (planning, reflection, memory management) are already present but inconsistently implemented across systems

## Paper 1 Relevance
**§2 (Paradigm Contrast — Old vs. New)** — CoALA is the canonical "capability container" paradigm paper. It treats agents as modular cognitive machines: memory slots, action repertoires, and decision loops. The entire framework is built around what an agent *can do* (capability inventory) rather than *who an agent is* (social role, identity, trust). This is precisely the old paradigm our Paper 1 argues against. CoALA's taxonomy is valuable as the clearest articulation of the capability-centric view — cite it as the benchmark of prior art that the P/SC/N framework transcends. Specifically: CoALA has no concept of social capital, reputation, or permissionless participation — agents exist in isolated task contexts with no persistent identity across collaboration networks.

## Paper 2 Relevance
Minimal direct relevance to ASM protocol design, but CoALA's action-space taxonomy (external grounding vs. internal reasoning) is useful background for understanding what capabilities ASM messages need to invoke.

## Verdict
⭐⭐⭐⭐⭐ | The definitive systematic treatment of the capability-container paradigm — essential as our primary contrast reference for Paper 1 §2.

## Jason's feedback
> （请在此处写入你的feedback）
