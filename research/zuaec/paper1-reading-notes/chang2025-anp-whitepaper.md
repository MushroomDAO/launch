# Agent Network Protocol Technical White Paper
**arXiv**: 2508.00007 | **Year**: 2025 | **Authors**: Gaowei Chang, Eidan Lin, Chengxuan Yuan, Rizhao Cai, Binbin Chen, Xuan Xie, Yin Zhang (ANP Open Source Technology Community) | **Venue**: arXiv / ANP Community

## Core Claim
ANP proposes a three-layer protocol architecture (identity/encryption, meta-protocol negotiation, application) using W3C DID (did:wba method) for cross-platform agent authentication without central authority — replacing human-centered web infrastructure with AI-native machine-readable connections and enabling agents to discover, authenticate, and collaborate across platforms.

## Key Evidence / Numbers
- Three-layer architecture: (1) identity+encryption layer (did:wba, ECDHE), (2) meta-protocol layer (dynamic negotiation via natural language), (3) application layer
- DID method: **did:wba** — web-based DID enabling cross-platform agent identity
- Agent Description Protocol (ADP): JSON-LD metadata for agent capabilities, interfaces, security requirements
- Agent Discovery: active discovery (domain directories) + passive discovery (search services)
- Multi-DID strategy for privacy/anonymity
- Human vs. agent authorization: sensitive operations require explicit human approval
- Minimal information disclosure principle
- Design goal: rapid real-world deployment on existing internet infrastructure

## ASM Comparison (Paper 2 focus)

### 技术层差异（Technical Gap）
- **What it does**: The most direct protocol competitor to ASM — ANP is a full protocol specification with DID identity, capability description, and dynamic meta-protocol negotiation. The survey (2504.16736) identifies ANP as the primary cross-domain inter-agent protocol
- **Gap vs ASM**: (1) **No role-bearing** — ANP's DID identity and ADP capability description do not encode agent role type (Coordinator, Executor, Verifier) that ASM uses for routing decisions; (2) **No reputation mechanism** — ANP enables agents to find and authenticate each other but provides no mechanism for trust scoring based on interaction history; (3) Meta-protocol negotiation via natural language is flexible but non-deterministic — ASM's structured message format is more verifiable; (4) did:wba relies on domain-based web infrastructure, which is still somewhat centralized

### 治理层差异（Governance Gap）— Jason's framing [2026-05-22]

**ANP = 企业主导型协议（Corporate-backed Protocol）**
- 由蚂蚁集团（Ant Group/Alibaba 生态）主导推动，虽代码开源，但协议演进路线由企业控制
- 设计目标：服务商业 agent 市场，企业级部署优先
- 类比：**Windows** — 公司控制标准，即使发布"开放"API

**ASM/Mycelium = 社区治理型开放协议（Community-governed Open Protocol）**
- 以开源方式发布，协议共创由社区驱动（无任何单一企业控股）
- **"在合规形式下的无许可协议社区"**：只要通过国家正常合规渠道，任何人/机构都可以：
  - 建立中继节点（relay）
  - 实现协议
  - 参与治理
- 类比：**Linux / Nostr** — 无许可参与，任何人可运行中继，协议由社区演进
- 国内类比：联盟链中的开放生态，而非单一机构链

**Paper 2 §2 差异化表述（建议引用语）**：
> "ANP [Chang et al. 2025] provides a technically capable protocol for cross-platform agent identity, but operates under corporate-backed governance where protocol evolution is controlled by a single commercial entity. ASM, by contrast, is designed as a community-governed open protocol: any participant — organization or individual — who meets basic compliance requirements can operate a relay, implement the protocol, or contribute to its evolution, analogous to the Linux kernel or Nostr relay network. This governance-layer distinction, not merely technical differences, is the primary differentiator."

- **Paper 2 §2 use**: Primary direct competitor — include in comparison table. Differentiate on BOTH technical layer (role-bearing, reputation) AND governance layer (community vs corporate).

## Paper 1 Relevance
- **§4.1 (N pillar)**: ANP's three-layer architecture is the reference design for the N pillar — cite as the best existing N pillar implementation; Paper 1 argues ASM extends it with P+S pillars integrated
- **§4.2/4.3**: The absence of P+S pillar features in ANP validates Paper 1's argument that a three-pillar framework is needed

## Verdict
⭐⭐⭐⭐⭐ | Most important direct competitor — cite in P2 §2 comparison table as primary foil. ANP has the closest protocol architecture but lacks role + reputation. Also essential for Paper 1 §4. Note: ANP community authors wrote both this and the survey (2504.16736), creating slight conflict of interest in that survey's ANP coverage.

---
*Jason's feedback*: [待填]
