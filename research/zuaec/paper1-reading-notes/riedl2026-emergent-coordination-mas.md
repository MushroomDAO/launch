# [Riedl 2025] Emergent Coordination in Multi-Agent Language Models

**arXiv**: 2510.05174 | **Year**: 2025 | **Authors**: C. Riedl | **Venue**: arXiv preprint (2025)
**Cluster**: Emergent Coordination / Collective Intelligence / Multi-Agent LLM Systems
**Status**: Full read

## Core Claim

Multi-agent LLM systems can exhibit measurable, causally steerable emergent coordination — detectable via partial information decomposition (PID) of time-delayed mutual information — and specific prompt interventions (particularly theory-of-mind reasoning) shift systems from mere aggregates toward integrated, goal-directed collectives that mirror principles of human collective intelligence.

## Key Evidence / Numbers

- **600 trials** (200 per condition) with GPT-4.1 and Llama-3.1-8B agents on binary sum-guessing task
- **Interaction effect** (synergy × redundancy): β = 0.24, p = 0.014 — performance requires both, not either alone
- **Theory of Mind (ToM) mediation**: ACME = 0.034 (p = 0.053) — ToM instruction causally increases identity-linked differentiation and goal alignment
- Control condition: strong temporal synergy but little coordinated alignment
- ToM condition: identity-linked differentiation + goal-directed complementarity
- Llama-3.1-8B shows oscillatory patterns **without** productive cross-agent synergy — model capacity constrains whether ToM reasoning translates to effective coordination
- Three emergence tests: practical criterion, emergence capacity, coalition test (all significant across conditions)
- Robustness checks: Jeffreys & Miller-Madow entropy estimators, discretisation tests, row/column shuffle null distributions

## Methodology

Information-theoretic framework: Partial Information Decomposition (PID) of Time-Delayed Mutual Information (TDMI) decomposes agent interactions into **synergy** (complementary contributions) vs. **redundancy** (shared goal alignment). Task: binary sum-guessing game without direct communication. Three conditions tested.

## Paper 1 Relevance

Directly supports **§4 (SC pillar — collective intelligence and emergent social behaviour)**. This paper provides the measurement framework for what "social" means in a multi-agent system: not just communication but the emergence of synergy (differentiation) balanced against redundancy (alignment). Our SC pillar's claim that quantified social capital enables collective intelligence is grounded by this empirical result — without structural incentives to maintain both synergy and redundancy, agents default to mere aggregates.

Key citation angle: ToM prompting as a proxy for "social role awareness" — our P pillar (protocols encoding role identity) is precisely the structural mechanism that instills ToM-like behaviour in agents, replacing ad hoc prompting with architectural guarantees.

## Paper 2 Relevance

Supports **§3 (ASM design rationale — role-bearing agents)**. The finding that identity-linked differentiation is necessary for effective coordination directly justifies ASM's role-bearing message headers: agents that carry persistent role identity in protocol messages generate the synergy necessary for collective performance. Without role encoding, agents converge to homogeneous redundancy (coordination without specialisation).

Also relevant to **§4 (reputation-weighted routing)**: synergy requires agents with distinct capabilities to be routed together, not just highest-score agents — our routing algorithm must balance diversity (synergy) with reliability (redundancy).

## Verdict

⭐⭐⭐⭐⭐ | The first empirical, information-theoretically grounded measurement of emergence in LLM multi-agent systems — provides both the conceptual vocabulary and the empirical baseline for our SC pillar's collective intelligence claims; model-capacity dependency finding is an important caveat for our deployment assumptions.

## Jason's feedback

> （请在此处写入你的feedback）
