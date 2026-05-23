# [Kim, Gu, Park et al. 2025] Towards a Science of Scaling Agent Systems
**arXiv**: 2512.08296 | **Year**: 2025 | **Authors**: Yubin Kim, Ken Gu, Chanwoo Park, Chunjong Park, Samuel Schmidgall, A. Ali Heydari, Yao Yan, Zhihan Zhang, Yuchen Zhuang, Yun Liu, Mark Malhotra, Paul Pu Liang, Hae Won Park, Yuzhe Yang, Xuhai Xu, Yilun Du, Shwetak Patel, Tim Althoff, Daniel McDuff, Xin Liu | **Venue**: arXiv cs.AI (submitted Dec 9, 2025)
**Cluster**: Scaling Laws / Quantitative MAS Science
**Status**: Full read

## Core Claim
Multi-agent coordination is not universally beneficial: depending on task structure and architecture choice, adding agents can improve performance by up to +80.8% or degrade it by up to -70.1%; a quantitative mixed-effects model (R²=0.524, 87% architecture-selection accuracy) identifies capability saturation (single-agent baseline >45% accuracy) and tool complexity as the primary determinants of when coordination helps vs. hurts.

## Key Evidence / Numbers
- Study scale: 180 (later described as 260) controlled configurations, 4–6 benchmarks, 5 architectures, 3 LLM families (OpenAI, Google, Anthropic)
- Performance range: +80.8% (Finance Agent, centralized coordination) to -70.1% (PlanCraft, independent agents)
- Error amplification: independent agents amplify errors 17.2× vs. 4.4× for centralized coordination
- Capability saturation threshold: single-agent accuracy >~45% → coordination yields diminishing returns (β=-0.404, p<0.001)
- Token efficiency: MAS achieves 21.5–67.7 successes per 1,000 tokens vs. 67.7 for single-agent
- Communication overhead: 0% (single-agent) to 515% (hybrid architecture)
- Turn-count scaling: super-linear with agent count (exponent 1.724)
- Tool-coordination trade-off: tool-heavy tasks incur compounding coordination costs (β=-0.267, p<0.001)
- Overhead-complexity scaling: β=-0.162 (coordination overhead compounds with task complexity)
- Validation: 5-fold cross-validation + out-of-sample GPT-5.2 test; R²=0.524, 87% architecture accuracy
- Architectures tested: Single-Agent, Independent (parallel ensemble), Centralized (hierarchical), Decentralized (peer debate), Hybrid

## Paper 1 Relevance
**§4 (Three Pillars) + §5 (Empirical Claims)**: This is the most important quantitative paper for Paper 1's empirical scaffolding. Three direct contributions:
1. **Validates the paradigm shift argument**: The -70.1% degradation finding proves that naive capability-invocation (independent parallel agents) is actively harmful in structured tasks, not merely suboptimal — a strong empirical base for our §2 critique.
2. **Quantifies the SC pillar's necessity**: The 17.2× error amplification in independent vs. 4.4× in centralized coordination is the strongest empirical case for why social capital (reputation-weighted routing) must precede raw collaboration.
3. **Defines the coordination design space**: The capability saturation threshold (45%) and tool-complexity penalty give Paper 1 concrete conditions under which our ACN framework should be applied.
The 87% architecture-selection accuracy suggests a quantitative decision model for when to deploy ACN vs. single-agent systems — a framing opportunity for §5.
Cite extensively in §4 (three pillars motivation) and §5 (empirical validation + comparison baseline).

## Paper 2 Relevance
The super-linear turn-count growth (exponent 1.724) and 515% communication overhead in hybrid architectures directly motivate ASM's design constraint: message overhead must be bounded by protocol, not left to emergent agent negotiation. ASM's reputation-weighted routing is a response to the tool-coordination trade-off identified here — by routing to high-reputation agents for tool-heavy tasks, ASM reduces the coordination overhead penalty.

## Verdict
⭐⭐⭐⭐⭐ | The most empirically rigorous quantitative treatment of MAS scaling in the literature; the +80.8%/−70.1% range and 17.2× error amplification are must-cite numbers for Paper 1's empirical motivation. Treat as a cornerstone reference.

## Jason's feedback
> （请在此处写入你的feedback）
