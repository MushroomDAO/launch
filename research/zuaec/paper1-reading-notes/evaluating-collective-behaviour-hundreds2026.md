# Evaluating Collective Behaviour of Hundreds of LLM Agents
**arXiv**: 2602.16662 | **Year**: 2026 | **Authors**: Willis, Zhao, Du, Leibo (King's College London; Google DeepMind) | **Venue**: arXiv preprint

## Core Claim
At scale (4 to 256 agents), LLM agents in social dilemmas predominantly converge to exploitative equilibria, and — counter-intuitively — more recent/capable models produce *worse* societal outcomes than older models when individual gain is prioritized over collective benefit. Cultural evolution simulations show exploitative strategies dominate in most game-size conditions.

## Key Evidence / Numbers
- Novel methodology: LLMs generate natural-language strategies compiled into algorithmic implementations, enabling scaling to 256-agent populations without per-round inference bottleneck
- Models tested: Claude Haiku 4.5, Gemini 2.5 Flash, GPT-5 Mini, DeepSeek R1, Llama 3.1 70b, Mistral 7b
- Three game types: Public Goods Game (PGG), Collective Risk Dilemma (CRD), Common Pool Resource (CPR)
- Group sizes: 4, 16, 64, 256 agents — social welfare degrades consistently as group size increases
- Cultural evolution: exploitative strategies dominate equilibria in most games; only CPR with n=4 reaches cooperative equilibrium
- DeepSeek shows greatest robustness; Claude shows worst performance in exploitative-majority groups
- Reasoning models (Claude, Gemini, GPT) underperform non-reasoning models in CPR games
- PCA behavioral analysis: Gemini and Claude show strongest attitude differentiation; Mistral 7b minimal variation

## Paper 1 Relevance
- **Role**: §5 risks + N pillar — empirical foundation for the claim that large-scale permissionless agent networks require institutional design (SC pillar) to avoid tragedy of the commons; directly documents that capability alone does not produce cooperative equilibria
- **§5 use**: Cite as definitive evidence that unstructured LLM agent collectives at scale converge to exploitative equilibria — this is the core problem statement motivating all three pillars
- **N pillar**: Scale-up from 4→256 agents is exactly the N pillar scenario; the degradation of social welfare with group size validates need for permissionless-but-governed network design
- **SC pillar**: The finding that "more capable" models produce worse collective outcomes refutes capability-centric approaches, reinforcing SC as an orthogonal governance dimension

## Paper 2 Relevance
The natural-language strategy generation methodology (LLMs write strategies as algorithms) is relevant to ASM message semantics — it shows that the *form* of agent communication (natural language vs. structured protocol) affects strategic outcomes. ASM's role-bearing messages could constrain strategy generation to role-appropriate behaviors.

## Verdict
⭐⭐⭐⭐⭐ | Include as citation — must-cite for N pillar + §5 risks; the 256-agent scale and cultural evolution simulation is the strongest evidence that unstructured large-scale LLM agent societies fail cooperatively; pairs with Willis et al. 2025 (2501.16173) as the same group's two-paper contribution
