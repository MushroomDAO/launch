# MushroomDAO License Guide

> Last updated: 2026-04-15
> Status: **DRAFT — pending final review before deployment to repos**

---

## 1. License Model: Apache 2.0 + Commons Clause

All MushroomDAO / AAStarCommunity / AuraAIHQ self-created repositories use this model,
with exceptions for SDK/tools (pure Apache 2.0) and documentation (CC BY-SA 4.0).

### Three-Tier Access

| User Type | Access | Mechanism |
|-----------|--------|-----------|
| **Individual** | Free — clone, use, learn, modify, deploy | Automatic via LICENSE |
| **Organization** | Free for non-commercial use, requires **Community Use Authorization** | Apply → Committee review → public record |
| **Commercial** | Must license through HyperCapital | Commercial contract |

> Organizations include: non-profit communities, DAOs, NGOs, educational institutions,
> foundations, and any group that is not a single individual.

### Why require authorization for organizations?

License alone cannot distinguish genuine non-profits from commercial entities disguised
as non-profits. The Community Use Authorization adds a lightweight verification layer:

- Organizations declare their purpose, scope, beneficiaries, and revenue status
- Committee evaluates (publicly) within 14 days
- Approved authorizations are recorded in a public registry
- Revocable with 30 days notice if use changes to commercial

See [COMMUNITY-USE-POLICY.md](./COMMUNITY-USE-POLICY.md) for full details.

---

## 2. Repository Classification

### Tier 1: Core Protocols & Contracts — Apache 2.0 + Commons Clause

Files needed: `LICENSE` (from LICENSE-commons-clause.txt), `NOTICE` (from NOTICE-template.txt)

**AAStarCommunity:** airaccount-contract, AirAccount, SuperPaymaster, aNode,
account-contracts, points-record-contract, coinJar, Tasks, registry, dvt, WhiteList

**MushroomDAO:** MyTask, MyShop, CometENS, OpenPNTs, MyVote, launch

**AuraAIHQ:** (none currently)

### Tier 2: Platform / Network — Apache 2.0 + Commons Clause + Network Covenant

Files needed: `LICENSE`, `NOTICE`, `NETWORK-COVENANT.md`

**AAStarCommunity:** CoS72, COS72-Tauri, create-cos72-dapp, SDSS,
AnotherAirAccountCommunityNode, XSchedule

**MushroomDAO:** Cos72, CityOS, Sin90, Park-PublicGoodsGarden

**AuraAIHQ:** AkiraV2, textverse-interface, TextverseClient

### Tier 3: SDK & Tools — Pure Apache 2.0

Files needed: `LICENSE` (from LICENSE-apache2-pure.txt)

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

## 3. CLA (Contributor License Agreement)

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

## 4. Key Decisions & Rationale

### Why NOT BSL 1.1?
BSL restricts usage during initial period — code is "not open source" at first.
This contradicts MushroomDAO's public goods mission. Code must be readable
and usable from day one.

### Why NOT pure Apache 2.0?
Too permissive. Any company could take the code, build a SaaS, and compete
without giving anything back to the community.

### Why NOT GPL?
GPL's copyleft ("viral") nature scares away commercial integrators and
doesn't actually prevent SaaS exploitation (the "SaaS loophole").

### Why NOT SSPL?
MongoDB's SSPL is too aggressive — requires open-sourcing entire infrastructure.
Not recognized by OSI. Would alienate the developer community.

### Why Commons Clause specifically?
It surgically addresses the one thing we want to prevent: commercial resale.
Everything else remains open. It's the minimum viable restriction.

### Why no time-lock (like BSL's auto-conversion)?
The commercial model is long-term. A time-lock would remove the commercial
company's incentive to invest $1.2M in the early stage when the ecosystem
is still fragile. The token would be worthless without sustained commitment.

### Why require Community Use Authorization for organizations?
License enforcement is post-hoc (lawsuit after violation). Authorization is
pre-hoc (verification before use). For a 10-person team, lawsuits are
impractical. A lightweight review process is both cheaper and more effective.

### SDK repos are pure Apache 2.0 — isn't that risky?
SDKs are "hooks" into the ecosystem. The more developers use them, the
more valuable the network becomes. Commercial value is in the protocol
and network layers, not the SDK layer. Restricting SDKs would only slow
adoption without meaningful protection.

---

## 5. Deployment Checklist (when license is finalized)

For each self-created repo:

- [ ] Add `LICENSE` file (appropriate tier template)
- [ ] Add `NOTICE` file (Tier 1 & 2)
- [ ] Add `NETWORK-COVENANT.md` (Tier 2 only)
- [ ] Add license section to README.md
- [ ] Verify CLA bot is active on the org
- [ ] Create `COMMUNITY-USE-POLICY.md` link in org-level .github repo

Script to batch-deploy will be created after final review.
