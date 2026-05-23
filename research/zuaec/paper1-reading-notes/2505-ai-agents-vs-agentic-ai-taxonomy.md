# [Sapkota et al. 2025] AI Agents vs. Agentic AI: A Conceptual Taxonomy, Applications and Challenges
**arXiv**: 2505.10468 | **Year**: 2025 | **Authors**: Ranjan Sapkota, Konstantinos I. Roumeliotis, Manoj Karkee | **Venue**: arXiv preprint
**Cluster**: Taxonomy & Definitions
**Status**: Full read

## Core Claim
"AI Agents" (modular, LLM-driven, task-specific automation) and "Agentic AI" (multi-agent collaboration with dynamic task decomposition, persistent memory, and coordinated autonomy) are scientifically distinct paradigms; conflating them causes misapplication of design principles and inappropriate benchmarking.

## Key Evidence / Numbers
- Google Trends data confirms "significant rise in global search for both terms following emergence of large-scale generative models in late 2022"
- "AI Agent" as term first introduced in 1998; evolved significantly post-ChatGPT (November 2022)
- 9 comparative tables (Tables I–IX) across Generative AI, AI Agents, and Agentic AI
- 5 comparative dimensions: Architecture, Mechanisms, Scope/Complexity, Interaction, Autonomy
- 12 literature platforms queried (Google Scholar, IEEE Xplore, ACM, Scopus, arXiv, ChatGPT, Perplexity, DeepSeek, etc.)
- 8 application use cases: 4 for AI Agents (customer support, email filtering, content recommendation, scheduling), 4 for Agentic AI (multi-agent research, robotics, medical decision support, adaptive workflow)
- AI Agents: single-entity, tool-augmented, bounded environments, optional/limited memory
- Agentic AI: multi-entity orchestrated, persistent shared episodic/semantic memory, broad multi-step workflows

## Paper 1 Relevance
- **§2 (Definitional Scaffolding / §2.1 "What is an Agent Network?")**: Sapkota et al. provide the canonical two-way taxonomy that Paper 1's §2 needs to ground its argument. Cite Table I (Architecture) and Table V (Autonomy) as the definitional baseline before introducing the Three Pillars framework as the normative upgrade path.
- **§2 (Paradigm Shift argument)**: The AI Agents → Agentic AI progression maps precisely to our capability-invocation → social role agency shift. Agentic AI's defining features (multi-agent coordination, persistent memory, orchestration) are exactly what the P/SC/N framework enables. Use this to frame our contribution as "providing the infrastructure for Agentic AI."
- **§3 (Three Pillars Introduction)**: The paper's "Agentic AI" definition requires P (coordination protocols), SC (persistent trust memory), and N (permissionless peer discovery) — each pillar directly addresses one gap identified by Sapkota et al. Cite explicitly in the three-pillar motivation.
- **§6 (Challenges section)**: Their identified challenges (reliability, coordination complexity, scalability) map 1:1 to what SC, P, and N address respectively — use as a challenges-to-solutions frame.

## Paper 2 Relevance
- **§1 (Introduction / Motivation)**: Cite to establish that ASM targets "Agentic AI" systems (multi-agent, coordinated) rather than isolated AI Agents — sets the scope boundary for the protocol.
- **§2 (Background / Related Work)**: The architectural evolution model (Perception→Reasoning→Action → Specialized Agents + Advanced Planning + Persistent Memory + Orchestration) provides the layered view within which ASM's communication protocol sits — cite as the context layer.
- Moderate direct relevance for protocol design; primary value is as definitional citation for Paper 2's scoping section.

## Verdict
⭐⭐⭐⭐ | The best available taxonomy paper for Paper 1's §2 definitional scaffolding — replaces the withdrawn 2506.01438 and provides more rigorous treatment with 9 comparison tables. Must-cite for Paper 1; useful background for Paper 2's introduction.

## Jason's feedback
> （请在此处写入你的feedback）
