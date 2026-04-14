# Community Use Authorization Policy

> MushroomDAO's software is free for individuals and small communities.
> Larger organizations (50+ members) require a lightweight authorization.

---

## Why this policy exists

Our license (Apache 2.0 + Commons Clause) prohibits selling the software
as a commercial service. But between "individual use" and "obvious commercial
resale" there is a gray area. This policy defines a clear, fair boundary.

Our philosophy: **help those who need help, while preventing commercial
free-riding.** We aim for maximum permissionless access with minimum
necessary safeguards.

---

## Who needs authorization?

| User type | Authorization needed? |
|-----------|-----------------------|
| Individual (personal use, learning, research) | **No** — use freely |
| Small community (≤50 members, self-declared) | **No** — use freely, registration encouraged but optional |
| Larger organization (>50 members) | **Yes** — apply (free, 14-day review) |
| Educational institution | **Yes** — apply (free, fast-track) |
| Commercial company | **Not applicable** — contact HyperCapital |

### Why 50 members as the threshold?

- ~90% of communities are ≤50 people — they should face zero friction
- Organizations large enough to commercially exploit the software typically
  have 100+ members/users and need enterprise-grade service
- Self-declaration works because the real commercial free-riders need SLA,
  compliance, and support that the code alone doesn't provide — they will
  find HyperCapital on their own
- Self-declaration creates a record: if a "small community" is later found
  to be operating commercially, the declaration serves as evidence

### Future upgrade path

When AirAccount reaches mainnet stability, we may switch to an on-chain
verifiable metric (e.g., registered AirAccount count) to replace
self-declaration. This would eliminate the gray area entirely.

---

## Small communities (≤50 members): optional registration

You do NOT need authorization, but we encourage you to register so we
know who's using the software and can offer support:

1. Open an issue in [MushroomDAO/.github](https://github.com/MushroomDAO/.github/issues)
   with the tag `community-registration`
2. Tell us: your name, what you do, how you use the software
3. No review needed — this is informational only

---

## Larger organizations (>50 members): authorization process

### How to apply

1. **Open an issue** in [MushroomDAO/.github](https://github.com/MushroomDAO/.github/issues)
   using the "Community Use Authorization" template
2. **Fill in the evaluation form** (see below)
3. **Committee reviews** within 14 days
4. **Decision is published** in the authorization registry (public)

### Evaluation criteria (public and transparent)

The committee evaluates based on these questions:

#### 1. What does your organization do?
Describe your mission and activities.

#### 2. How will you use the software?
Which repositories? What's the application scope? Who are the end users?

#### 3. Who benefits?
Describe the beneficiaries. Are they paying for the service?

#### 4. Do you receive direct revenue from this use?
- If YES: this likely qualifies as commercial use → contact HyperCapital
- If NO: proceed with community authorization

#### 5. Is any commercial entity directly or indirectly profiting?
For example: a "non-profit" foundation that funnels value to a for-profit
subsidiary would not qualify.

---

## Decision framework

| Scenario | Decision |
|----------|----------|
| Small community ≤50 members, any purpose | **No auth needed** |
| Community DAO running free tools for members | **Approved** |
| NGO deploying for beneficiaries, no revenue | **Approved** |
| University research / teaching | **Approved** (fast-track) |
| Non-profit that charges membership fees but doesn't sell the software itself | **Approved** (the software is a tool, not the product) |
| Organization that repackages the software as a paid SaaS | **Denied** → commercial license |
| "Non-profit" whose primary beneficiary is a commercial entity | **Denied** → commercial license |
| Ambiguous cases | Committee discussion, may request more info |

---

## Authorization registry

All approved authorizations are published publicly:

| Organization | Date | Members | Repos | Use case | Status |
|-------------|------|---------|-------|----------|--------|
| (none yet) | | | | | |

Revocation: The committee may revoke authorization if the organization's
use changes to commercial in nature. 30 days notice is given.

---

## Appeals

If denied, organizations may:
1. Provide additional information and re-apply
2. Request a community-wide vote (requires 3 committee member sponsors)
3. Contact HyperCapital for commercial licensing as an alternative

---

## Contact

- GitHub Issues: https://github.com/MushroomDAO/.github/issues
- Telegram: https://t.me/Account_Abstraction_Community
- Commercial licensing: HyperCapital (jason@aastar.io)
