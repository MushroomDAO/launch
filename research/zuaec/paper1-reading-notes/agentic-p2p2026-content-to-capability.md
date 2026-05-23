# Agentic Peer-to-Peer Networks: From Content Distribution to Capability and Action Sharing
**arXiv**: 2603.03753 | **Year**: 2026 | **Authors**: Taotao Wang, Lizhao You, Jingwen Tong, Chonghe Zhao, Shengli Zhang | **Venue**: arXiv preprint (Shenzhen University, Xiamen University, Guangzhou University)

## Core Claim
Client-Side Autonomous Agents (CSAAs) on edge devices need a fundamentally different P2P architecture than traditional file-sharing networks: capabilities are dynamic, state-dependent, and potentially unsafe (unlike static files), requiring signed soft-state capability descriptors, semantic discovery, and a tiered verification spectrum (reputation → challenge-response → evidence-based attestation).

## Key Evidence / Numbers
- **Four-plane architecture**: Connectivity & Identity / Semantic Discovery / Execution / Trust & Verification
- **Signed Capability Descriptors (CDs)**: soft-state with TTL-based freshness; multi-dimensional QoS + trust vectors
- **Three verification tiers**: Tier 1 = reputation-based; Tier 2 = challenge-response probing (canary tasks); Tier 3 = cryptographic evidence packages (signed receipts, tool traces, attestations)
- **Sybil attack simulation**: Risk-Aware selection with Tier 2 canary probing sustains significantly higher workflow success vs. optimistic baselines
- **Scalability**: discovery latency near-constant from 20 to 200 nodes; overhead grows modestly (soft-state refresh traffic)
- **TTL knee point**: ~15 seconds balances freshness and control-plane overhead under high capability drift
- Two-step workflow (image generation + publishing) showed significant reliability gains with tiered verification
- Three fundamental shifts from classic P2P: static files → dynamic capabilities; deterministic integrity → probabilistic trust; bandwidth waste → privacy/safety risk

## Paper 1 Relevance
- **Role**: N pillar (Permissionless Network) — the closest published architectural blueprint for the N pillar; a peer-reviewed reference for decentralized capability discovery and tiered trust in open agent networks
- **§4/§5 use**: "The N pillar's permissionless architecture aligns with Wang et al.'s (2026) agentic P2P framework, which demonstrates that capability-based P2P networks are technically feasible at scale [cite]; we extend their tiered verification into a role-bearing social capital layer."
- **Differentiation**: Wang et al. focus on *capability sharing* between CSAAs (edge-device agents); our N pillar addresses open role-bearing agent participation in collaboration networks with social accountability (SC). Their verification tiers map onto ASM's challenge-response but lack role-identity binding.
- The 15-second TTL finding for capability freshness has direct implications for ASM protocol design (role assertion validity windows)

## Paper 2 Relevance
**High** — The tiered verification framework and signed Capability Descriptors are the closest existing system to ASM's role-claim + verification mechanism. Cite in Paper 2 §5 (Related Work): ASM provides the *social-role-aware* message protocol that sits above Wang et al.'s connectivity and discovery planes. Key extension: our role claims carry social capital assertions (not just QoS vectors) and are grounded in verifiable social history.

## Verdict
⭐⭐⭐⭐⭐ | Include as core N pillar reference — strongest published architectural work on decentralized agentic networks with tiered verification; directly relevant to both papers. Cite in Paper 1 §4/§5 and Paper 2 §5.

## Jason's feedback
> （请在此处写入你的feedback）
