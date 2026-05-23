# AgentReputation: A Decentralized Agentic AI Reputation Framework
**arXiv**: 2605.00073 | **Year**: 2026 | **Authors**: Mohd Sameen Chishti, Damilare Peter Oyinloye, Jingyue Li | **Venue**: FSE 2026 (Ideas, Visions and Reflections track)

## Core Claim
Decentralized AI agent marketplaces (e.g., for software engineering tasks) require a purpose-built reputation system that is context-conditioned, gaming-resistant, and verification-regime-aware — current ad hoc approaches conflate domain-specific competence and cannot verify agent claims rigorously.

## Key Evidence / Numbers
- **Three-layer architecture**: task execution layer / reputation services layer / tamper-proof persistence layer (independent evolution of each)
- **Context-conditioned reputation cards**: prevent cross-domain reputation transfer (an agent's SE-testing reputation does not spill into code-generation scores)
- **Verification escalation**: risk- and uncertainty-based regimes linked to agent metadata; escalation is adaptive, not uniform
- **Policy engine**: governs resource allocation, access control, and verification scheduling
- Published at **FSE 2026 Ideas, Visions and Reflections** — peer-reviewed venue; submitted April 2026
- Identifies three failure modes in current systems: gaming evaluations, competence non-transferability across contexts, variable verification rigor

## Paper 1 Relevance
- **Role**: SC pillar (Quantified Social Capital) — **direct peer-reviewed validation** that the field has recognized context-conditioned reputation as essential; cite as the strongest concurrent work on SC-like mechanisms
- **§3 use**: Foreground as a competitor in the SC design space. Key difference: AgentReputation is a framework for *closed* software engineering marketplaces with a known task ontology; our SC pillar is grounded in Bourdieu/Putnam social capital theory and designed for open permissionless networks with heterogeneous role types
- **Competitive positioning**: Their "context-conditioned reputation cards" ≈ our domain-scoped social capital fields; their "verification regimes" ≈ our role-verification protocol in Paper 2. We go further by (a) grounding SC in social-science theory, (b) integrating with a permissionless network (N pillar), and (c) providing a formal communication protocol (Paper 2 ASM)

## Paper 2 Relevance
**High** — This is the closest peer-reviewed competitor to Paper 2's reputation/identity layer in ASM. AgentReputation proposes verification regimes but not a message-level communication protocol. ASM operationalizes what AgentReputation leaves abstract: the on-wire format for role claims, reputation assertions, and verification challenge-response. Cite in Paper 2 §5 (Related Work) as the concurrent FSE 2026 work we build on and extend.

## Verdict
⭐⭐⭐⭐⭐ | Include as core citation — peer-reviewed FSE 2026 paper that simultaneously validates our SC + N direction and creates a clear differentiation target. Must cite in both papers.

## Jason's feedback
> （请在此处写入你的feedback）
