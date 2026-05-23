# Communication Enables Cooperation in LLM Agents: A Comparison with Curriculum-Based Approaches
**arXiv**: 2510.05748 | **Year**: 2025 | **Authors**: Madmoun & Lahlou (MBZUAI) | **Venue**: arXiv preprint

## Core Claim
Minimal communication protocols (cheap talk) are more reliable for inducing cooperation in multi-agent LLM systems than curriculum-based training approaches. A single-word communication channel lifted cooperation from 0% to 48.3% in heterogeneous agent groups, while increasingly complex curriculum designs actually degraded performance — with the full curriculum reducing payoffs by 27.4% compared to the no-curriculum control.

## Key Evidence / Numbers
- Game: 4-player Stag Hunt; one-word "cheap talk" communication channel (non-binding)
- Communication results: heterogeneous setting (4 different models) cooperation: 0% → 48.3%; coalition setting: variance eliminated (30.0±0.0 vs 17.9±11.8 payoff SD)
- Curriculum results: Control group (no curriculum) achieved highest payoff: 211.7 tokens; Full Curriculum reduced payoffs by 27.4% vs. baseline; performance declined monotonically with curriculum complexity
- Curriculum failure mechanism: "learned pessimism" — agents overgeneralize defection lessons from short-horizon games to cooperative contexts; "heuristic over-fitting"
- Models: Mixtral-8x22B, Qwen2.5-72B, Llama-3.3-70B, DeepSeek-V3
- Experimental design: 4 conditions × 30 trials each

## Paper 1 Relevance
- **Role**: P pillar direct evidence — the strongest available experimental evidence that communication protocols cause cooperation, not merely correlate with it; the causal chain (add communication → cooperation jumps from 0% to 48.3%) is the empirical foundation for the P (Collaboration Protocols) pillar
- **§4 use**: Primary citation for "communication enables cooperation" in §4; the 0%→48.3% lift with a single-word channel is striking; also cite as evidence that protocol *design* matters (curriculum failure shows that ill-designed communication structures harm cooperation)
- **P pillar**: The cheap-talk result shows even minimal structured communication produces large cooperative gains; ASM's richer role-bearing messages should achieve even more
- **Anti-curriculum lesson**: The 27.4% curriculum degradation from "learned pessimism" is a design warning: protocol design must avoid training agents on adversarial sub-games that corrupt their cooperative priors

## Paper 2 Relevance
This is the most directly relevant paper to ASM: it establishes that communication protocol design is the primary lever for cooperation in multi-agent systems. ASM is a structured (non-cheap-talk) communication protocol — the hypothesis is that role-bearing message semantics do even more than cheap talk. The 0%→48.3% result with cheap talk sets a lower bound that ASM should exceed.

## Verdict
⭐⭐⭐⭐⭐ | Include as citation — must-cite for both papers; for Paper 1, it is the empirical proof-of-concept for the P pillar; for Paper 2, it is the direct predecessor whose cheap-talk result ASM is designed to improve upon; the curriculum-failure finding is also actionable as a design warning against over-engineering agent training
