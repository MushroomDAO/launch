# [Prakash 2026] LDP: An Identity-Aware Protocol for Multi-Agent LLM Systems
**arXiv**: 2603.08852 | **Year**: 2026 | **Authors**: Sunil Prakash (Indian School of Business, Hyderabad) | **Venue**: arXiv preprint
**Cluster**: Agent Identity & Authentication Protocols / Multi-Agent Coordination
**Status**: Full read

## Core Claim
Current agent-to-agent protocols (Google A2A, Anthropic MCP) omit model-level metadata critical for effective delegation decisions; LDP (Layered Delegation Protocol) proposes identity cards with 20+ fields covering model family, reasoning profiles, and cost characteristics, enabling specialization-aware routing that is ~12× faster on easy tasks with 37% lower token cost.

## Key Evidence / Numbers
- Routing latency: ~12× faster response times on easy tasks via specialization-aware delegate selection vs. baselines
- Token efficiency: Semantic frame payloads reduce communication cost by 37% (p=0.031) without quality loss
- Session overhead: Governed sessions eliminate 39% token overhead at 10 conversation rounds vs. stateless re-invocation
- Security simulation: Trust domains detect 96% of unauthorized delegation attempts vs. only 6% for bearer-token authentication
- Provenance paradox: Unverified confidence metadata *degrades* synthesis quality below the no-provenance baseline (honest negative finding)
- Delegate pool: 3 heterogeneous local models (Qwen 8B, Qwen Coder 7B, Llama 3.2 3B)
- Evaluation: 30 tasks (RQ1), 20 tasks (RQ2), 15 synthesis tasks (RQ3), 60 multi-round exchanges (RQ4)
- Identity cards contain 20+ fields; delegation uses ldp:// URL scheme
- A2A skill-matching was competitive with LDP's identity-aware routing in aggregate quality — the paper honestly reports this null result

## Paper 1 Relevance
- **§2 (Paradigm Shift)**: LDP explicitly identifies that A2A and MCP treat agents as "capability endpoints" lacking identity — strong empirical support for our old-paradigm critique. Quote the finding that model-level metadata is absent from current protocols.
- **§3 (Three Pillars Framework)**: LDP operationalizes the P pillar (delegation protocol) and a rudimentary SC pillar (identity cards as trust signals). Cite as partial implementation that lacks persistent reputation and permissionless network — motivates all three pillars being needed together.
- **§4 (SC Pillar)**: The provenance paradox finding (unverified confidence metadata degrades quality) is a crucial empirical data point: SC must be *verifiable*, not self-asserted. Use this to justify SC's cryptographic verification requirement.

## Paper 2 Relevance
- **§3 (ASM Architecture)**: LDP's identity card structure (20+ fields) is the most detailed prior art for ASM's role-bearing message header. Compare explicitly: ASM uses DID/VC for verifiable identity vs. LDP's richer but self-asserted card; ASM adds reputation-weighted routing vs. LDP's capability-matching.
- **§3.2 (Principal Identity)**: LDP's trust domain mechanism (96% detection rate) validates the security value of identity-aware routing. ASM should cite this as empirical motivation for per-message principal verification.
- **§4 (Protocol Design)**: LDP's progressive payload modes (text → latent capsules) with automatic negotiation and fallback is a useful pattern for ASM's payload negotiation layer.
- **§5 (Evaluation)**: LDP's evaluation methodology (6 RQs, local models + LLM judge) can be adapted for ASM's empirical evaluation design.

## Verdict
⭐⭐⭐⭐⭐ | Directly comparable prior work with empirical numbers — the 96% vs. 6% security finding and the provenance paradox are both citable, load-bearing evidence for ASM's design choices.

## Jason's feedback
> （请在此处写入你的feedback）
