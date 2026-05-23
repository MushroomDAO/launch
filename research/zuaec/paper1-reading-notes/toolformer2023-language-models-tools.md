# Toolformer: Language Models Can Teach Themselves to Use Tools
**arXiv**: 2302.04761 | **Year**: 2023 | **Authors**: Schick, Dwivedi-Yu, Dessì, Raileanu, Lomeli, Zettlemoyer, Cancedda, Scialom | **Venue**: Meta AI Research / arXiv preprint (NeurIPS 2023)

## Core Claim
Language models can learn to use external tool APIs (search, calculator, calendar, QA, translation) in a self-supervised manner — by sampling, filtering, and fine-tuning on annotated API calls — without extensive human annotation, independently deciding when and how to invoke tools to improve their own task performance.

## Key Evidence / Numbers
- LAMA (T-REx factual retrieval): **53.5%** vs. GPT-3 175B at 39.8% — a 6.7B model outperforms a 26× larger model with tool use
- Math (ASDiv, SVAMP, MAWPS): **doubled performance** over same-size baselines
- Wikipedia search invoked **99.3% of the time** for QA tasks (near-perfect tool selection)
- Language modeling perplexity: **no degradation** when APIs are disabled at inference
- Model: GPT-J 6.7B fine-tuned; tools: calculator, Wikipedia search, QA model, calendar, machine translation
- Key limitation: cannot chain tool calls or interact iteratively — all API calls sampled independently during training

## Paper 1 Relevance
- **Role**: Old paradigm foundational work — the seminal paper establishing self-supervised tool learning; anchors the "capability invocation" paradigm that Paper 1 argues is insufficient for network-scale agent collaboration
- **§2 use**: Cite in §2.1 (capability invocation sub-cluster) as the foundational reference: "The capability-invocation paradigm was crystallized by Toolformer [citation], which showed that agents can learn to invoke external APIs self-supervisedly — establishing tool use as the dominant lens for extending single-agent capability"
- **Pillar**: Framework contrast (embodies the pure capability-invocation paradigm — no P, no SC, no N)

## Paper 2 Relevance
N/A — Paper 1 only. Toolformer treats tool APIs as capability extensions; no notion of role-bearing agents, social trust, or protocol-mediated coordination.

## Verdict
⭐⭐⭐⭐⭐ | Include as direct citation — this is *the* foundational paper for the "capability invocation" paradigm that Paper 1's title explicitly names in its paradigm-shift framing ("from Capability Invocation to Social Role Agency"). Must cite; one sentence in §1 intro and one in §2.1.

*Note: Full text retrieved from ar5iv HTML. Published at NeurIPS 2023.*

## Jason's feedback
> （请在此处写入你的feedback）
