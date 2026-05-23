# [Singh et al. 2025] A Survey of AI Agent Registry Solutions
**arXiv**: 2508.03095 | **Year**: 2025 | **Authors**: Aditi Singh, Abul Ehtesham, Ramesh Raskar, Mahesh Lambe, Pradyumna Chari, Jared James Grogan, Abhishek Singh, Saket Kumar | **Venue**: arXiv preprint
**Cluster**: Agent Registry & Discovery / N Pillar Infrastructure
**Status**: Full read

## Core Claim
Traditional DNS and static service catalogs are inadequate for autonomous AI agent ecosystems at scale; purpose-built registries with cryptographic verification are essential, and current solutions (MCP Registry, A2A, Microsoft Entra, NANDA) differ fundamentally in their trust, scalability, and decentralization properties.

## Key Evidence / Numbers
- 4 registry systems compared: MCP Registry (centralized, GitHub OAuth + DNS-TXT), A2A/Google (decentralized JSON Agent Cards, /.well-known URIs), Microsoft Entra Agent ID (enterprise Azure AD directory), NANDA Index (cryptographically verifiable, Ed25519 + W3C VCs)
- Schema sizes: MCP 1–3 KB JSON, A2A 0.3–1 KB JSON, NANDA 1–3 KB JSON-LD + VC
- Revocation speed: MCP/A2A = minutes (HTTP re-fetch); NANDA < 1 second (VC-Status lists)
- NANDA's three-layer architecture: Lean Index Layer (≤120 bytes signed pointers), AgentFacts Layer (verifiable metadata), Dynamic Resolution Layer (routing, TTL 5–15 min)
- NANDA privacy path: optional PrivateFactsURL via IPFS/Tor hides access patterns
- Phase-wise evolution framework: Phase I (static files) → Phase II (REST APIs) → Phase III (verifiable, federated)
- Two detailed feature comparison tables across 4 registry solutions

## Paper 1 Relevance
- **§2 (Paradigm Shift / Old vs. New)**: The Phase I→II→III evolution framework maps directly onto our capability-invocation → social role agency trajectory. Phase III (verifiable, federated) is the infrastructure precondition for social role agency. Cite as independent confirmation of paradigm evolution.
- **§5 (N Pillar)**: The 4-system comparison is the definitive landscape for the N pillar. Cite to characterize the registry design space: permissioned (Entra) vs. permissionless (A2A, NANDA), centralized vs. federated. ASM's N pillar needs to position against this map.
- **§5 (N Pillar — decentralization)**: NANDA's <1-second revocation via VC-Status lists is empirical evidence that decentralized verifiable registries can match enterprise SLA requirements — use to refute "decentralized = slow" objection.

## Paper 2 Relevance
- **§3 (ASM Architecture — N Pillar / Agent Discovery)**: Singh et al. provide the exact comparison frame ASM needs. ASM's registry approach should be explicitly mapped to Phase III (verifiable, federated) and contrasted with Phase II patterns used by current MCP/A2A.
- **§3.3 (Permissionless Registration)**: NANDA's ≤120-byte signed pointer (Lean Index Layer) is a concrete, citable design pattern for lightweight permissionless agent registration. Adopt or adapt.
- **§4 (Protocol Specification)**: A2A's /.well-known URI pattern and NANDA's JSON-LD + VC format are the two leading candidates for ASM's agent advertisement format — cite this survey to justify the choice.
- **§5 (Security)**: NANDA's revocation speed (<1 sec) vs. MCP/A2A (minutes) is a citable benchmark for ASM's revocation design requirement.

## Verdict
⭐⭐⭐⭐⭐ | The definitive comparative survey for the N pillar — provides concrete schema sizes, revocation benchmarks, and a phase-evolution framework that directly maps to our three-pillar argument. Must-cite for Paper 2 §3 and Paper 1 §5.

## Jason's feedback
> （请在此处写入你的feedback）
