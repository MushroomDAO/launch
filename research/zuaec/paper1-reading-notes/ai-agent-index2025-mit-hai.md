# [AI Agent Index 2025 — MIT/HAI] The 2025 AI Agent Index: Documenting Technical and Safety Features of Deployed Agentic AI Systems
**arXiv**: 2602.17753 | **Year**: 2025 | **Authors**: MIT/HAI team (multi-author) | **Venue**: MIT/Stanford HAI (preprint)
**Cluster**: Industry Ecosystem Baseline & Governance
**Status**: Full read (ar5iv succeeded)

## Core Claim
A structured index of 30 deployed state-of-the-art agentic AI systems across 1,350 annotation fields reveals a severe transparency gap: developers freely publish capability benchmarks while withholding safety evaluations, creating fragmented accountability and concentration of control in three foundation model providers.

## Key Evidence / Numbers
**Scope:**
- **30** state-of-the-art deployed agents indexed
- **1,350** annotation fields per agent
- **198 of 1,350 fields (14.7%)** had no publicly available information
- **24 of 30 agents (80%)** released or received major agentic updates in 2024–2025 — confirms rapid ecosystem growth

**Safety & Transparency Gaps:**
- Only **4 agents** provide agent-specific system cards: ChatGPT Agent, OpenAI Codex, Claude Code, Gemini 2.5
- **25 of 30 agents (83%)** disclose no internal safety results
- **23 of 30 agents (77%)** have no third-party testing documentation
- Only **9 of 30 agents (30%)** report capability benchmarks at all
- **18 of 30 agents (60%)** operate bug bounties/vulnerability disclosure programs

**Technical Infrastructure (Protocol Relevance):**
- **20 of 30 agents (67%)** support Model Context Protocol (MCP) — MCP adoption as baseline
- **23 of 30 agents (77%)** are fully closed-source
- **21 of 30 agents (70%)** rely exclusively on GPT, Claude, or Gemini models

**Geographic Distribution:**
- **21 agents (70%)** from US-incorporated companies
- **5 agents (17%)** from China-incorporated companies
- Only **1 of 5 Chinese agents (20%)** document safety frameworks

**Autonomy Levels:**
- **5 of 30 agents (17%)** operate at L4–L5 autonomy (limited mid-execution intervention)
- **3 of 30 agents (10%)** maintain turn-based L1–L3 autonomy

**Web Conduct:**
- **21 of 30 agents (70%)** have no documented default disclosure behavior
- Only **7 of 30 agents (23%)** publish stable User-Agent strings and IP ranges
- **6 of 30 agents (20%)** explicitly ignore robots.txt standards
- **5 of 30 agents (17%)** have documented security incidents or reported security concerns
- Prompt injection vulnerabilities documented in **2 of 5** browser agents

**Agent Categories:**
- 12 Chat Applications with Agentic Tools (e.g., Claude Code)
- 5 Browser-Based Agents (Perplexity Comet, ChatGPT Atlas, ByteDance TARS)
- 13 Enterprise Workflow Agents

## Paper 1 Relevance
**§1 (Motivation)**: The ecosystem-baseline statistics are essential for motivating the Three Pillars. The 83% safety non-disclosure + 77% closed-source + 70% MCP dependency collectively illustrate why current single-provider hub-and-spoke architectures are inadequate — no shared trust, no interoperability standard, no permissionless participation. This is the empirical foundation for the "paradigm shift" claim.

**§5 (Deployment evidence)**: The 67% MCP adoption figure is a reference point showing that protocol-level adoption is possible at scale, but MCP alone is insufficient (no identity, no reputation, no trust layer).

Key tension for Paper 2: The 70% no-disclosure behavior + 6 robots.txt violators shows that without a protocol that encodes trust/identity (ASM), even rapid adoption can entrench bad practices.

## Paper 2 Relevance
**Direct**: The 67% MCP adoption baseline and 77% closed-source concentration are the foil against which ASM is positioned as an open-source, permissionless alternative. "30 deployed agents, 77% closed" → ASM provides the missing open layer.

## Verdict
⭐⭐⭐⭐⭐ | Definitive ecosystem baseline — the 30-agent index with 1,350 fields provides the most comprehensive empirical snapshot of the deployed agent landscape; essential citation for Paper 1 §1 and the contrast argument for Paper 2.

## Jason's feedback
> （请在此处写入你的feedback）
