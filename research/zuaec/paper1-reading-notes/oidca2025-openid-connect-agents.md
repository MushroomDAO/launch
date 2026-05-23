# [Nagabhushanaradhya 2025] OpenID Connect for Agents (OIDC-A) 1.0
**arXiv**: 2509.25974 | **Year**: 2025 | **Authors**: Subramanya Nagabhushanaradhya | **Venue**: arXiv preprint (technical specification)
**Cluster**: Agent Identity & Authentication Protocols
**Status**: Full read

## Core Claim
OIDC-A extends OpenID Connect with five categories of standardized claims (agent identity, delegation, capability, trust, attestation) to fill the gap left by OAuth 2.0/OIDC which were designed for human users and cannot represent LLM-based agent identity, delegation chains, or hardware attestation.

## Key Evidence / Numbers
- Defines 5 claim categories: Core Agent Identity (agent_type, agent_model, agent_version, agent_provider, agent_instance_id), Delegation & Authority (delegator_sub, delegation_chain, delegation_purpose, delegation_constraints), Capability & Trust (agent_capabilities, agent_trust_level, agent_attestation, agent_context_id)
- 6 primary extension mechanisms over base OIDC
- Delegation chain implemented as ordered arrays with mandatory scope reduction at each step
- Attestation framework supports JWT-based, TPM 2.0, and Intel SGX formats, compatible with IETF RATS standards
- Adds discovery endpoints for attestation verification and capability enumeration
- Emphasizes strong asymmetric authentication (not shared secrets) for agents
- Requires full delegation chain validation at every interaction point (Zero Trust Architecture)
- Reference implementation: https://github.com/subramanya1997/oidc-a/

## Paper 1 Relevance
- **§2 (Paradigm Shift)**: Concrete evidence that existing identity infrastructure (OAuth 2.0, OIDC) was built for capability-invocation patterns (human→app), not social role agency. OIDC-A's emergence signals industry recognition of the gap — supports our "old paradigm fails" framing.
- **§4 (SC Pillar)**: `agent_trust_level` and `agent_attestation` claims are a primitive form of quantified social capital — cite as "industry starting point" that lacks the persistent, cross-network reputation that SC pillar requires.
- **§5 (P Pillar)**: Delegation chain and delegation_constraints directly relate to protocol-level role assignment and authority scope — cite as foundational identity substrate that ASM's P layer builds upon.

## Paper 2 Relevance
- **§3 (ASM Architecture — Principal Identity)**: OIDC-A is the closest prior work to ASM's verifiable principal identity component. ASM should explicitly compare: OIDC-A provides authentication but no reputation-weighted routing, no role-bearing message headers, and no permissionless registration. Cite as "complementary identity layer" — ASM could ride atop OIDC-A for authentication while adding SC routing.
- **§4 (Protocol Specification)**: The delegation_chain array structure and scope-reduction enforcement directly inform ASM's principal chain field design. Adopt or cite the ordered-array pattern.
- **§5 (Security Analysis)**: Zero Trust principle (verify at every interaction) aligns with ASM's per-hop verification requirement — cite OIDC-A as grounding for this design choice.

## Verdict
⭐⭐⭐⭐⭐ | The single most directly relevant identity standard for Paper 2 — OIDC-A defines the authentication substrate that ASM's principal identity layer must either adopt, extend, or explicitly differentiate from.

## Jason's feedback
> （请在此处写入你的feedback）
