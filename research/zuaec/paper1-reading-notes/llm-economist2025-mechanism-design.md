# [Karten et al. 2025] LLM Economist: Large Population Models and Mechanism Design in Multi-Agent Generative Simulacra

**arXiv**: 2507.15815 | **Year**: 2025 | **Authors**: Seth Karten, Wenzhe Li, Zihan Ding, Samuel Kleiner, Yu Bai, Chi Jin (Princeton University; Salesforce Research) | **Venue**: arXiv preprint (submitted Aug 5, 2025)
**Cluster**: Mechanism Design / Agent Economics / Multi-Agent Simulation
**Status**: Full read

## Core Claim

LLM-based agents can jointly simulate, optimize, and govern complex economic systems entirely in natural language, converging near Stackelberg equilibria that achieve ~90% of theoretically optimal social welfare — demonstrating that language-driven mechanism design is tractable without gradient computation.

## Key Evidence / Numbers

- LLM planner achieves **90% of optimal social welfare** in a seven-bracket tax scenario
- **93% improvement** over U.S. statutory rates in bounded-utility setting
- Within **10–35%** of Saez-optimal schedules across evaluated scenarios
- Scales to **1,000 agents** locally; actions-per-second reaches 53.62 at 1k agents
- Removing exploitation guidance reduces welfare by **21.9 percentage points**
- Tax year length of **128 steps** optimal for worker adaptation; utility derivative falls to noise within 120 steps
- Three-agent democratic system shows minority utility **25% lower** (tyranny of the masses)
- Redistributive policies shift **~15%** of workers into lower tax brackets while maintaining stable aggregate labor supply
- Backbone: Llama-3.1-8B-Instruct (also tested GPT-3.5/GPT-4o)
- 11 persona types calibrated to 2023 American Community Survey data (skills from Generalized-Beta distribution)

## Methodology

Two-level Stackelberg game: worker population (lower) vs. tax-policy planner (upper). Workers optimise labor supply under isoelastic utility with dissatisfaction penalty; planner adjusts piecewise-linear tax schedules anchored to U.S. federal brackets (ΔτK ∈ [−20, 20]%). In-context reinforcement learning (ICRL) with replay buffer (best K trajectories). Democratic variant: periodic candidate voting among persona agents.

## Paper 1 Relevance

Directly supports **§4 (SC pillar — Quantified Social Capital)**. Provides the strongest existing existence proof that mechanism design can be expressed and optimised in natural language for heterogeneous LLM agent populations. Connects to our argument that economic incentive layers are a necessary pillar for open collaboration networks: the planner→worker Stackelberg structure mirrors a network-level reputation/reward router sitting above competing agents.

Key citation angle: "governing the next generation of autonomous economic agents" — aligns precisely with our claim that ACN requires an explicit economic governance layer (SC pillar) rather than ad hoc fee structures.

## Paper 2 Relevance

Supports **§5 (N pillar — Permissionless Network, economic incentives)**. The two-phase ICRL (exploration/exploitation) with a replay buffer is directly analogous to ASM's reputation-weighted routing: historical high-quality interactions are retained and reused to bias future routing decisions. Democratic voting mechanism parallels our community-governance design for ASM protocol upgrades.

SC pillar angle: the paper shows that heterogeneous preferences across agents require population-level economic primitives (not just pairwise contracts), strengthening our argument for network-wide social capital accounting.

## Verdict

⭐⭐⭐⭐⭐ | The most rigorous existing proof-of-concept for natural-language mechanism design in large heterogeneous LLM agent populations — essential citation for SC pillar and economic governance sections of both papers.

## Jason's feedback

> （请在此处写入你的feedback）
