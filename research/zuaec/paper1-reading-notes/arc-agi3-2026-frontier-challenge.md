# [ARC-AGI-3 2026] ARC-AGI-3: A New Challenge for Frontier Agentic Intelligence
**arXiv**: 2603.24621 | **Year**: 2026 (as of March 2026) | **Authors**: ARC Prize team | **Venue**: Preprint / Benchmark Release
**Cluster**: Capability Benchmarks & Frontier Limits
**Status**: Full read (ar5iv succeeded — detailed tables retrieved)

## Core Claim
ARC-AGI-3 introduces an interactive benchmark measuring agentic intelligence through action efficiency in novel environments; as of March 2026, humans solve 100% of environments while all frontier AI systems score below 1%, marking the next unsolved capability frontier.

## Key Evidence / Numbers
**Human Baseline:**
- Humans: **100%** success rate on all environments
- Median human attempt duration: **7.4 minutes** per environment
- Successful human attempts median: **8.1 minutes**
- **486 unique participants** in benchmark validation
- **414 candidate environments** designed
- **2,893 total environment attempts** recorded
- **427.9 hours** total human play time

**Frontier Model Scores (Semi-Private Leaderboard, March 2026):**
| Provider | Model | Score |
|----------|-------|-------|
| Google | Gemini 3.1 Pro Preview | **0.37%** |
| OpenAI | GPT 5.4 (High) | **0.26%** |
| Anthropic | Opus 4.6 (Max) | **0.25%** |
| xAI | Grok-4.20 (Beta 0309 Reasoning) | **0.00%** |

- All frontier models: **"below 1%"** — the human-AI gap is essentially complete
- Best competition approach (StochasticGoose, informed search): **12.58%** on public environments only
- Academic approaches (Duke University, Symbolica AI): solved public environments via domain-specific optimization — not generalizable

**Benchmark Structure:**
- Public demonstration set: **25 environments**
- Semi-private set: **55 environments**
- Fully private set: **55 environments**
- Each environment contains minimum **6 levels**
- Tutorial levels: solvable by **100%** of humans (calibration)

**Key Failure Modes Identified:** Exploration strategies, hypothesis revision under uncertainty, efficient planning — these are collaborative/social capabilities, not pure knowledge retrieval.

## Paper 1 Relevance
**§1 (Motivation — bounded but rapid progress)**: ARC-AGI-3 provides the essential counterpoint to the 87% SWE-Bench forecast (2502.15850). The story is: *within narrow task domains* (structured software dev), agents approach human-level; *in general agentic intelligence* (novel environment navigation), the gap remains almost complete. This dual-track framing motivates the Three Pillars as a design response to capability *heterogeneity* — agents excel in specialized domains, making *collaboration* (P pillar) and *reputation by domain* (SC pillar) essential.

**§1 quote anchor**: "humans solve 100% of environments, frontier AI systems score below 1%" — use to show capability frontier is still actively expanding, validating timeliness of Paper 1.

**§1 (rapid progress evidence)**: The fact that ARC-AGI-3 was designed *because* ARC-AGI-2 was solved shows the benchmark frontier is advancing — not static.

## Paper 2 Relevance
The failure modes (exploration, hypothesis revision, planning under uncertainty) are precisely where multi-agent collaboration via ASM protocol would have impact — agents with complementary specializations could collectively navigate novel environments better than any single agent. This is a potential future work direction.

## Verdict
⭐⭐⭐⭐ | Essential counterweight to capability optimism — the "humans 100%, frontier AI <1%" statistic is the most dramatic capability gap figure available as of 2026; use in §1 alongside the SWE-Bench 87% forecast to argue for domain-specialized, collaborating agents rather than universal superintelligence.

## Jason's feedback
> （请在此处写入你的feedback）
