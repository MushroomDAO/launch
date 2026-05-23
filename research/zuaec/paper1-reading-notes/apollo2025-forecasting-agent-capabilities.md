# [Pimpale et al. 2025] Forecasting Frontier Language Model Agent Capabilities
**arXiv**: 2502.15850 | **Year**: 2025 | **Authors**: Govind Pimpale, Axel Højmark, Jérémy Scheurer, Marius Hobbhahn | **Venue**: Apollo Research (preprint)
**Cluster**: Capability Benchmarks & Forecasting
**Status**: Abstract + key results read (ar5iv fatal error; arxiv.org abstract retrieved)

## Core Claim
Using a validated two-step forecasting method (Release Date → Elo → Benchmark), the paper predicts that by early 2026 non-specialized LM agents will reach 54% on SWE-Bench Verified, while state-of-the-art LM agents will reach 87%.

## Key Evidence / Numbers
- **87%** predicted SWE-Bench Verified success rate for SOTA LM agents by **beginning of 2026**
- **54%** predicted SWE-Bench Verified success rate for non-specialized (low capability elicitation) LM agents by same date
- **6 forecasting methods** evaluated: one-step (compute or release date → benchmark) and two-step (release date → Elo → benchmark)
- **38 LMs** from OpenLLM 2 leaderboard used for backtesting validation
- Three benchmark domains covered: SWE-Bench Verified (software dev), Cybench (cybersecurity), RE-Bench (ML research engineering)
- Authors note the two-step method "might be too conservative" given recent inference-compute scaling advances — actual trajectory may exceed forecasts
- Intermediate metric: PC-1 (principal component of cross-benchmark performance) and human-evaluated competitive Elo ratings

## Paper 1 Relevance
**§1 (Motivation — development speed)**: The 87% SOTA / 54% non-specialized split is the single strongest quantitative anchor for the claim that agent capabilities are advancing at unprecedented speed, justifying the need for a collaboration network paradigm now. The gap between SOTA and average also motivates the SC (Social Capital) pillar — not all agents are equal; reputation/trust differentiation matters.

**§5 (Deployment evidence)**: Can be cited alongside SWE-Bench current scores to show the trajectory from ~2022 baselines toward near-human coding performance within 3 years.

## Paper 2 Relevance
Indirectly: rapid capability growth means ASM protocol must be designed for a high-performance, heterogeneous agent landscape rather than today's limited baselines.

## Verdict
⭐⭐⭐⭐⭐ | The single most important quantitative forecast for Paper 1 §1 — "87% by early 2026" is the headline number that motivates urgency for the Three Pillars framework.

## Jason's feedback
> （请在此处写入你的feedback）
