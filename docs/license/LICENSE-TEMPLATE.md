# MushroomDAO License Guide

> Last updated: 2026-04-15
> Status: **DRAFT — pending final review before deployment to repos**

---

## 1. License Model: Apache 2.0

All MushroomDAO / AAStarCommunity / AuraAIHQ self-created repositories are licensed
under the Apache License 2.0 — an OSI-approved open source license.

Protection of the project's commercial interests is handled through three
complementary mechanisms that sit **outside** the code license:

1. **Trademark** — Brand names (MushroomDAO, Mycelium, GToken, etc.) are protected.
   Forks must rebrand. See [TRADEMARK.md](./TRADEMARK.md).
2. **Network Access Control (Ticket Model)** — Using the live Mycelium Protocol
   network requires burning a GToken ticket. The code is open; the network is gated.
3. **CLA** — Contributors sign a CLA granting MushroomDAO sublicense and
   commercial authorization rights, ensuring the project can sustain itself.

### Three-Tier Access

| User Type | Code License | Protocol Network Access |
|-----------|-------------|------------------------|
| **Individual** | Apache 2.0 — free to clone, use, learn, modify, distribute | Free (personal use) |
| **Small community (≤50 members)** | Apache 2.0 — same as individual | Free (self-declared) |
| **Larger organization (>50 members)** | Apache 2.0 — same as individual | Requires **Network Access Authorization** (free review, 7-day response) |
| **Commercial company** | Apache 2.0 — free to use the code, but **cannot use MushroomDAO trademarks** | Must obtain a GToken ticket to access the protocol network. Contact jason@aastar.io |

> "Members" means active participants, self-declared by the organization.
> Future upgrade: may switch to on-chain verifiable metric (AirAccount count)
> when product reaches mainnet stability.

### Why require authorization for large organizations?

The code license (Apache 2.0) is fully permissive — anyone can use, modify, and
distribute the code. However, **accessing the live Mycelium Protocol network** is a
separate matter. Large organizations require a lightweight Network Access
Authorization to ensure fair use of shared infrastructure:

- Organizations declare their purpose, scope, beneficiaries, and revenue status
- Committee evaluates (publicly) within 14 days
- Approved authorizations are recorded in a public registry
- Revocable with 30 days notice if use changes

See [COMMUNITY-USE-POLICY.md](./COMMUNITY-USE-POLICY.md) for full details.

---

## 2. Trademark Protection

MushroomDAO maintains trademark protection over its brand names, logos, and
product identities. This is separate from and complementary to the Apache 2.0
code license.

### Protected Marks

MushroomDAO, Mycelium Protocol, Mycelium, GToken, PNTs, xPNTs, aPNTs,
AAStar, AuraAI, HyperCapital, OpenNest, Spores, Park Protocol,
SuperPaymaster, AirAccount, Cos72, CityOS, Sin90

### Key Rules

- **Forks must rebrand.** You may fork and modify the code freely under Apache 2.0,
  but you must remove all MushroomDAO trademarks and branding from your fork.
- **Compatibility references are OK.** You may state "compatible with Mycelium Protocol"
  but you may NOT use "Mycelium" or "MushroomDAO" in your product name.
- **Logo use requires written permission.** Contact jason@aastar.io.

See [TRADEMARK.md](./TRADEMARK.md) for the full trademark policy.

---

## 3. Repository Classification

### Tier 1: Core Protocols & Contracts — Apache 2.0

Files needed: `LICENSE` (Apache 2.0), `NOTICE` (from NOTICE-template.txt)

**AAStarCommunity:** airaccount-contract, AirAccount, SuperPaymaster, aNode,
account-contracts, points-record-contract, coinJar, Tasks, registry, dvt, WhiteList

**MushroomDAO:** MyTask, MyShop, CometENS, OpenPNTs, MyVote, launch

**AuraAIHQ:** (none currently)

### Tier 2: Platform / Network — Apache 2.0 + Network Covenant

Files needed: `LICENSE` (Apache 2.0), `NOTICE`, `NETWORK-COVENANT.md`

The Network Covenant describes the terms for accessing the live protocol network
(GToken ticket requirement, fair-use policies). It does NOT restrict the code
license — it governs network participation.

**AAStarCommunity:** CoS72, COS72-Tauri, create-cos72-dapp, SDSS,
AnotherAirAccountCommunityNode, XSchedule

**MushroomDAO:** Cos72, CityOS, Sin90, Park-PublicGoodsGarden

**AuraAIHQ:** AkiraV2, textverse-interface, TextverseClient

### Tier 3: SDK & Tools — Apache 2.0

Files needed: `LICENSE` (Apache 2.0)

**AAStarCommunity:** YetAnotherAA, aastar-sdk, YetAnotherAA-Validator,
AirAccountGateway, AirAccountEmailAdapter, AirAccountSmsAdapter, Adapters,
Gateway, Startup, demo, aio

**MushroomDAO:** Doris

**AuraAIHQ:** agent-speaker, infoCrab, Agent24, OpenCrab

### Tier 4: Documentation & Community — CC BY-SA 4.0

Files needed: `LICENSE` (CC BY-SA 4.0 text)

**AAStarCommunity:** aastar-docs, .github, aastar.io, research, EvaluationAll-AA, zu.coffee

**MushroomDAO:** blog, mushroomdao.github.io, docs, .github, whitelist

**AuraAIHQ:** courses, AI_Beginner_Courses, TVdocs

### Excluded: Private repos (add license when made public)

AAStarCommunity: Brood, my-exploration
MushroomDAO: demo-repository, Asset3, Spores
AuraAIHQ: iDoris, AuraAI

### Excluded: Forked repos (DO NOT modify — these are other people's repos)

AAStarCommunity: me, UltraRelay-AAStar, SuperRelay, captcha-bot
MushroomDAO: YetAnotherAA (fork)
AuraAIHQ: agent-speaker-relay, nanochat, AiToEarn, reader3, Akira, peth,
mudcore, twint, fluffos, smartcontract-apps, decent-app, token-demo

---

## 4. CLA (Contributor License Agreement)

### Setup: cla-assistant.io (hosted version, recommended)

**Why hosted version:**
- Org-wide: 3 operations cover all 65+ repos
- Zero maintenance
- GitHub Action version was archived 2026-03-23, no longer maintained

**Setup steps (for each of the 3 orgs):**

1. Go to https://cla-assistant.io
2. Sign in with the org admin GitHub account (jhfnetboy)
3. Click "Configure CLA" → select the organization
4. Upload or link the CLA document (a Gist URL works)
5. Enable for all repositories in the organization

**For existing contributors (Jason + David):**
- In the cla-assistant.io dashboard, go to each org's settings
- Use the "allowlist" or manually import existing contributors
- Or: they can sign the CLA on their next PR (simplest approach)

### CLA Content

The CLA should grant MushroomDAO:

1. **Sublicense right**: Community can sublicense contributions under the project license
2. **Commercial authorization right**: Community can authorize HyperCapital to commercialize
3. **Contributor retains copyright**: The contributor still owns their code

Without CLA, contributors retain exclusive copyright, making commercial authorization
legally impossible.

### CLA Template (Gist)

```markdown
# MushroomDAO Contributor License Agreement (CLA)

By signing this CLA, you agree that your contributions to any MushroomDAO,
AAStarCommunity, or AuraAIHQ repository are subject to the following terms:

1. **Grant of License**: You grant MushroomDAO a perpetual, worldwide,
   non-exclusive, royalty-free license to use, reproduce, modify, distribute,
   and sublicense your contributions under the project's license terms.

2. **Commercial Authorization**: You acknowledge that MushroomDAO may
   authorize designated commercial partners (currently HyperCapital) to
   provide commercial services based on the software, and your contributions
   may be included in such commercial offerings.

3. **Ownership**: You retain copyright ownership of your contributions.
   This CLA does not transfer ownership.

4. **Originality**: You represent that your contributions are your original
   work and you have the right to grant the above license.

5. **No Obligation**: MushroomDAO is not obligated to use your contributions.
```

---

## 5. Key Decisions & Rationale

### Why Apache 2.0?
Apache 2.0 is a permissive, OSI-approved open source license that allows
anyone to use, modify, and distribute the code — including for commercial
purposes. This aligns with MushroomDAO's public goods mission: code is
truly open from day one, with no restrictions on usage.

### How do we protect against commercial free-riding without Commons Clause?
Three layers replace the Commons Clause:

1. **Trademark**: Competitors cannot use MushroomDAO branding. They must
   rebrand their forks, which eliminates brand confusion and reduces
   the threat of parasitic SaaS offerings trading on our reputation.
2. **Network Access Control**: The protocol network requires GToken tickets
   to access. The code is open, but the running network is gated. This
   is analogous to how Ethereum clients are open source but you still
   need ETH to transact.
3. **CLA**: Contributors grant sublicense rights, enabling MushroomDAO
   to offer commercial support and services through HyperCapital while
   maintaining the open source license.

### Why NOT BSL 1.1?
BSL restricts usage during initial period — code is "not open source" at first.
This contradicts MushroomDAO's public goods mission. Code must be readable
and usable from day one.

### Why NOT GPL?
GPL's copyleft ("viral") nature scares away commercial integrators and
doesn't actually prevent SaaS exploitation (the "SaaS loophole").

### Why NOT SSPL?
MongoDB's SSPL is too aggressive — requires open-sourcing entire infrastructure.
Not recognized by OSI. Would alienate the developer community.

### Why require Network Access Authorization for organizations?
License enforcement is post-hoc (lawsuit after violation). Authorization is
pre-hoc (verification before use). For a 10-person team, lawsuits are
impractical. A lightweight review process is both cheaper and more effective
for governing shared network resources.

### SDK repos are pure Apache 2.0 — isn't that risky?
SDKs are "hooks" into the ecosystem. The more developers use them, the
more valuable the network becomes. Commercial value is in the protocol
and network layers, not the SDK layer. Restricting SDKs would only slow
adoption without meaningful protection.

---

## 5b. OSI Compliance

All MushroomDAO repositories use OSI-approved licenses. We are a genuine open
source organization committed to building digital public goods.

- **Apache License 2.0:** <https://opensource.org/licenses/Apache-2.0>
- **Open Source Definition:** <https://opensource.org/osd>

When we say "open source," we mean the legally precise definition maintained by
the [Open Source Initiative (OSI)](https://opensource.org) — not a loose or
marketing usage of the term. Our choice of Apache 2.0, an OSI-approved license,
ensures that all code in MushroomDAO, AAStarCommunity, and AuraAIHQ repositories
is genuinely free to use, study, modify, and redistribute.

---

## 6. Deployment Checklist (when license is finalized)

For each self-created repo:

- [ ] Add `LICENSE` file (Apache 2.0 for all tiers)
- [ ] Add `NOTICE` file (Tier 1 & 2)
- [ ] Add `NETWORK-COVENANT.md` (Tier 2 only)
- [ ] Add `TRADEMARK.md` reference in README.md
- [ ] Add license section to README.md
- [ ] Verify CLA bot is active on the org
- [ ] Create `COMMUNITY-USE-POLICY.md` link in org-level .github repo

Script to batch-deploy will be created after final review.
