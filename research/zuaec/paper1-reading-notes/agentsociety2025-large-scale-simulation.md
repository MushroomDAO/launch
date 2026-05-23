# AgentSociety: Large-Scale Simulation of LLM-Driven Generative Agents Advances Understanding of Human Behaviors and Society
**arXiv**: 2502.08691 | **Year**: 2025 | **Authors**: Jinghua Piao, Yuwei Yan, Jun Zhang, Nian Li, Junbo Yan, Xiaochong Lan, Zhihong Lu, Zhiheng Zheng, Jing Yi Wang, Di Zhou, Chen Gao, Fengli Xu, Fang Zhang, Ke Rong, Jun Su, Yong Li | **Venue**: arXiv preprint (Tsinghua FIB Lab)

## Core Claim
AgentSociety achieves the first large-scale LLM-driven social simulator (10,000+ agents, 5M+ daily interactions) that reproduces four real-world social phenomena — polarization, information cascade, UBI policy effects, hurricane responses — by grounding agents in psychology-based behavioral models and realistic multi-dimensional urban/social/economic environments.

## Key Evidence / Numbers
- **10,000+ agents** across a single simulation
- **5 million daily interactions** (avg. 500 per agent per day)
- Four validated social phenomena reproduced: opinion polarization, inflammatory message propagation, universal basic income effects, hurricane impact adaptation
- Technical stack: Ray for distributed computing, MQTT publish-subscribe for agent messaging, PostgreSQL with COPY for batch storage
- Agents grounded in: Maslow hierarchy of needs, Theory of Planned Behavior, emotional appraisal frameworks
- Environment: OpenStreetMap road networks, SafeGraph POI data for physical grounding
- Supports real-time intervention: GUI for live agent communication and state manipulation

## Paper 1 Relevance
- **Role**: KEY empirical evidence for SC (Social Capital) pillar and for N (Permissionless Network) scalability; shows that agents with social/psychological grounding produce emergent macro-social behaviors that capability-only agents cannot
- **§3 use**: §3.3 (SC pillar) — cite as large-scale empirical evidence that social dynamics (trust, relationship strength, reputation context) are necessary drivers of realistic agent behavior; "relationship strength modulates communication tone" is direct SC evidence
- **§3 use**: §3.4 (N pillar) — 10,000-agent scale with distributed MQTT messaging is empirical proof that permissionless-scale networks are feasible; architecture choices directly inform N's infrastructure requirements
- **§5 use**: §5 Evaluation / Future Directions — the four validated social experiments are a model for how Paper 1's framework could be empirically tested
- **Pillar**: SC (primary) + N (secondary)

## Paper 2 Relevance
The MQTT publish-subscribe messaging at 5M interactions/day is a practical precedent for ASM's message envelope design under scale. The paper shows that message-level metadata (sender relationship context, social role) matters for agent decision-making. Cite in ASM §5 (scalability discussion).

## Verdict
⭐⭐⭐⭐⭐ | Include as citation — HIGHEST PRIORITY for SC pillar; the 10k-agent/5M-interaction scale is the key empirical number to cite when arguing for SC and N pillar necessity

## Jason's Feedback
[待填]
