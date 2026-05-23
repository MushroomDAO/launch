# [Kasirzadeh, Gabriel 2025] Characterizing AI Agents for Alignment and Governance

**arXiv**: 2504.21848 | **Year**: 2025 | **Authors**: Atoosa Kasirzadeh, Iason Gabriel | **Venue**: arXiv preprint (cs.CY + cs.AI + eess.SY)
**Cluster**: Governance & Regulation / Agent Typology
**Status**: Full read

## Core Claim
Effective governance of AI agents requires a four-dimensional characterization framework (autonomy, efficacy, goal complexity, generality) that produces "agentic profiles" spanning a spectrum from narrow task-specific assistants to highly autonomous general-purpose systems — bridging technical properties with non-technical governance requirements.

## Key Evidence / Numbers
- Four dimensions of characterization:
  1. **Autonomy** — degree of independent action without human instruction
  2. **Efficacy** — capability to achieve intended goals reliably
  3. **Goal complexity** — breadth and nestedness of objectives the agent pursues
  4. **Generality** — range of domains/tasks the agent can operate across
- Framework produces "agentic profiles" — multi-dimensional signatures enabling comparison across agent types
- Explicitly maps from technical dimensions to governance challenges (cross-cutting technical and non-technical governance challenges per agentic profile)
- Spectrum framing: continuous rather than categorical — avoids the brittleness of binary "safe/unsafe" classifications
- Authors: Kasirzadeh (AI safety/philosophy, previously DeepMind); Gabriel (Iason Gabriel, DeepMind AI safety lead, co-author of DeepMind's alignment work)

## Paper 1 Relevance
**§5 (Governance — all three pillars, especially N)**: This is the highest-priority governance paper for Paper 1. Kasirzadeh & Gabriel's four dimensions provide a principled basis for situating our three-pillar framework — specifically, our N (Permissionless Network) pillar addresses agents at the high-autonomy, high-generality end of their spectrum, where governance challenges are most acute and existing frameworks most strained. Our SC pillar (Social Capital) can be framed as a governance mechanism for managing the autonomy dimension — quantified reputation tracks whether an agent's actual behavior matches its claimed efficacy. Our P pillar (Protocols) addresses the goal-complexity dimension — role-bearing protocols constrain the space of goals agents can legitimately pursue in a collaboration context. Paper 1 §5 should explicitly adopt their "agentic profile" vocabulary and show how P/SC/N operate as governance mechanisms for high-profile agents in permissionless networks.

## Paper 2 Relevance
**§6 (Threat Model / Governance)**: The four dimensions map directly onto ASM threat categories:
- **Autonomy** → threat: agents act outside sanctioned role scope (role boundary violations)
- **Efficacy** → threat: agents misrepresent capability (capability fraud)
- **Goal complexity** → threat: agents pursue hidden sub-goals while appearing cooperative (goal masking)
- **Generality** → threat: highly general agents are harder to constrain to protocol-defined roles (scope creep)
ASM §6 should structure its threat taxonomy around these four dimensions, then show how ASM protocol mechanisms (role declarations, capability attestations, message validation) address each.

## Verdict
⭐⭐⭐⭐⭐ | The most conceptually foundational governance paper for Paper 1 §5; Kasirzadeh & Gabriel's four-dimensional agentic profile framework provides the principled vocabulary to situate our P/SC/N pillars and structure ASM §6's threat taxonomy — must-cite for both papers.

## Jason's feedback
> （请在此处写入你的feedback）
