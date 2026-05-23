# TrustFlow: Topic-Aware Vector Reputation Propagation for Multi-Agent Ecosystems
**arXiv**: 2603.19452 | **Year**: 2026 | **Authors**: Volodymyr Seliuchenko (robutler.ai) | **Venue**: arXiv preprint

## Core Claim
TrustFlow replaces scalar agent reputation with multidimensional reputation vectors that propagate through interaction graphs via topic-gated transfer operators — achieving 98% multi-label precision on dense graphs while resisting Sybil attacks, reputation laundering, and vote rings with ≤4 percentage-point impact.

## Key Evidence / Numbers
- Dense labeled graph precision: **98% multi-label P@5** with scalar-gated operator
- Combined graph (682 edges): **72–78% P@5** depending on operator
- Adversarial impact: **≤4 percentage-point** across Sybil, laundering, vote-ring attacks
- Graph density: "single most important determinant" of precision
- Economic signal weighting: **3× base weight** for payment-delegation interactions
- Convergence proof via contraction mapping theorem
- Four operator variants: projection, squared gating, scalar-gated, hybrid (all Lipschitz-1)
- Continuous formulation: R_new[j] = α∑ᵢw(i→j)f(R[i],eᵢⱼ) + (1-α)T[j] + C[j]
- Support for negative trust edges (moderation flags)

## ASM Comparison (Paper 2 focus)
- **What it does**: The most sophisticated reputation system in this review — topic-aware vector reputation that flows through interaction graphs, mathematically closest to ASM's topic-aware reputation scoring. Direct overlap with ASM §5 reputation mechanism
- **Gap vs ASM**: (1) No identity anchoring — TrustFlow operates on interaction graphs without requiring agents to have DID-linked identities (the graph is the trust substrate); (2) No role encoding — reputation vectors capture topic expertise but not protocol role (Coordinator, Executor, etc.); (3) Stand-alone reputation system, not integrated into a communication protocol — ASM embeds reputation into message routing decisions in real-time
- **Paper 2 §5 use**: Primary citation for topic-aware reputation — acknowledge TrustFlow as the most advanced reputation algorithm and differentiate ASM's approach: (a) reputation is DID-linked and persistent across networks (not just local graph); (b) reputation is embedded in routing, not post-hoc scored; (c) ASM's role layer adds a prior on what reputation dimensions matter per role type

## Paper 1 Relevance
- **§4.3 (S pillar)**: TrustFlow is the strongest single paper validating the S pillar's topic-aware reputation concept — cite as the mathematical foundation. The vector formulation (domain-specific reputation) directly supports Paper 1's claim that agents need multi-dimensional reputation, not just a single score

## Verdict
⭐⭐⭐⭐⭐ | Most important S pillar reference — cite in both papers. P1 §4.3: primary reputation math reference. P2 §5: primary competitor/validation for topic-aware reputation. Key differentiator: ASM integrates reputation into protocol routing + adds DID anchoring + adds role priors. Single-author preprint is the main weakness.

---
*Jason's feedback*: [待填]
