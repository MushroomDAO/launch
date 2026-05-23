# [Qian et al. 2024/2025] Scaling Large-Language-Model-based Multi-Agent Collaboration (MacNet)
**arXiv**: 2406.07155 | **Year**: 2024 | **Authors**: Chen Qian et al. | **Venue**: arXiv cs.AI / cs.MA
**Cluster**: Network Topology / Scaling MAS
**Status**: Full read

## Core Claim
Multi-agent collaboration quality follows a sigmoid (logistic) growth curve with agent count rather than linear scaling, saturates rapidly at 16–32 agents, and is more sensitive to network topology than to raw agent count — with small-world-like random topologies outperforming regular dense meshes at equivalent scale.

## Key Evidence / Numbers
- MacNet organizes agents as directed acyclic graphs (DAGs): nodes = executive assistants, edges = supervisory instructors
- Six topology families tested: Chain, Star-tree, Layered-tree, Star, MLP-mesh, Random
- Benchmark results (vs. single-agent CoT baseline 0.3544–0.7222):
  - MMLU: MacNet-Random 0.6877 vs. CoT 0.3544 (+94%)
  - HumanEval: AgentVerse 0.7256; MacNet-Star 0.5549
  - SRDD: MacNet-Chain 0.8056 vs. CoT 0.7222
  - CommonGen: MacNet-Star 0.7382
  - Average: MacNet-Random 0.6522 vs. CoT 0.5757
- Performance saturation: sigmoid plateau at 2⁴–2⁵ agents (16–32 nodes)
- "Reverse degradation phenomenon": 2.27–6.24% performance reduction in some deep topologies due to context visibility constraints
- Random topologies outperform regular mesh at equal agent count/density
- Collaborative emergence speed: far faster than neural scaling (millions of parameters); meaningful gains within tens of agents

## Paper 1 Relevance
**§2 (Paradigm Shift) + §4 (N Pillar — Permissionless Network)**: MacNet provides the strongest empirical grounding for Paper 1's N-pillar argument. Two key moves:
1. The sigmoid saturation curve (~16–32 agents) challenges naive "more agents = better" intuitions, supporting our claim that the bottleneck is structural (topology/roles) not scale.
2. The superiority of small-world/random topologies over engineered hierarchies directly supports our argument that permissionless, organically growing networks can outperform centrally designed capability-invocation architectures.
The DAG + role distinction (instructors vs. assistants) is a precursor to our "social role agency" framing — MacNet shows role assignment matters even at this primitive level. Cite in §4.3 (N pillar topology evidence) and §2 (capability invocation vs. role-based framing).

## Paper 2 Relevance
MacNet's memory control mechanism (propagating refined solutions forward rather than full dialogue history) is directly analogous to ASM's message compression and reputation-weighted routing — the paper demonstrates that information selectivity is a first-class design concern, not an optimization afterthought. The DAG topology also validates ASM's assumption that agent communication graphs need not be fully connected.

## Verdict
⭐⭐⭐⭐⭐ | Essential empirical reference for the N-pillar; sigmoid saturation + topology superiority findings are among the most concrete quantitative results we have for network structure effects on MAS performance.

## Jason's feedback
> （请在此处写入你的feedback）
