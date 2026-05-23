# Why Do Multi-Agent LLM Systems Fail?
**arXiv**: 2503.13657 | **Year**: 2025 | **Authors**: Cemri, Pan, Yang, Agrawal, Chopra, Tiwari, Keutzer, Parameswaran, Klein, Ramchandran, Zaharia, Gonzalez, Stoica et al. | **Venue**: arXiv preprint

## Core Claim
Multi-agent LLM systems fail primarily due to organizational dysfunction among agents — not individual LLM limitations — as captured in the MASFT taxonomy of 14 failure modes across 3 categories; simple prompt engineering and architectural tweaks are insufficient, requiring structural redesigns informed by organizational theory.

## Key Evidence / Numbers
- 150+ tasks analyzed with 6 expert annotators, Cohen's Kappa = 0.88 (high inter-rater reliability)
- ChatDev achieves only 25% correctness on benchmarks, significantly below single-agent baselines
- Improved prompting + topology redesign yielded only 14% performance gain — indicating fundamental systemic limits
- **MASFT taxonomy — 14 failure modes across 3 categories**:
  - FC1 Specification & System Design (5 modes): task spec violations, role spec disobedience, step repetition, conversation history loss, unaware of termination
  - FC2 Inter-Agent Misalignment (6 modes): conversation reset, failure to request clarification, task derailment, information withholding, ignored peer input, reasoning-action mismatch
  - FC3 Task Verification & Termination (3 modes): premature termination, absent/incomplete verification, incorrect verification
- Failure distribution is balanced — no single category dominates; failure patterns vary by system architecture
- Identifies parallels with High-Reliability Organization (HRO) principles

## Paper 1 Relevance
- **Role**: KEY empirical evidence for why social structure is needed; the 14 failure modes are the negative case that Paper 1's Three Pillars address
- **§4/§5 use**: §4 (Problem Analysis) — cite MASFT as the empirical taxonomy showing what goes wrong when agents lack social roles (FC1: role disobedience), social capital (FC2: information withholding, ignored peer input), and accountable network structure (FC3: verification failures)
- **§3 use**: §3 (Three Pillars rationale) — "failures correlate with HRO violations" directly supports the sociological grounding of Paper 1's framework; SC pillar addresses FC2 failures; P pillar addresses FC1; N pillar (accountability) addresses FC3
- **Pillar**: P/SC/N — all three pillars respond to specific failure modes in MASFT

## Paper 2 Relevance
FC2 failures (information withholding, ignored peer input, reasoning-action mismatch) are exactly what ASM's role-bearing message envelope is designed to mitigate — role attestation + reputation context give receiving agents signal to evaluate and reject or escalate inputs. Cite in ASM §1 (motivation) and §4 (design rationale).

## Verdict
⭐⭐⭐⭐⭐ | Include as citation — HIGHEST PRIORITY for Paper 1; the 14-failure-mode taxonomy is the empirical anchor for all three pillars; also strong for Paper 2 motivation

## Jason's Feedback
[待填]
