# Canonize — Design Spec

**Date:** 2026-08-24
**Status:** Approved for implementation
**Owner:** Mike Olaski

---

## Problem

The Rehabit / ForeSee OS needs a defined universe of skills, and every skill in it needs
to trace back to a source we trust. Today neither exists in a usable form.

`RHB - Agent & Skill Packages` in Notion holds 18 rows, nearly all `Not Started`. Its only
provenance field is a bare `Source` URL, populated on exactly one row. This repo holds 11
skills, all `placeholder`. There is no record of *why* any entry belongs, no way to tell a
canonical implementation from a stale fork, and no defensible answer to "who says this is
good."

Canonize supplies the missing half: a trust engine that decides what earns a place, and an
audit trail that survives the decision.

## Decisions

| Decision | Choice | Why |
|---|---|---|
| Source of truth | **GitHub** (this repo); Notion is a one-way mirror | Trust decisions need diffs, PR review, and provenance history. Notion loses all three. |
| Admission model | **Two-stage gate** — creator vetted first, skills inherit provenance | "Canonized" must mean "from a vetted source," which requires the source be vetted independently and first. |
| Canon artifact | **Vendored upstream + provenance** | Ships the actual working skill, credits the author, and makes upstream drift detectable. |
| Modes | **Three** — `scout`, `vet`, `review` — on one shared trust engine | A link Mike drops and a candidate scout finds must be judged by identical rules and leave the same trail. |

## The Trust Engine

### Tiers

The brief named two populations, and collapsing them is the central trap: "the absolute
top minds" versus "trusted creators and influencers" whose coverage is a signal. One is
who we canonize; the other is who corroborates. If both can be canonized, coverage becomes
circular — influencers promoting each other into the canon.

- **Tier A — Authority.** Canonization-eligible. Their skills may enter the canon.
- **Tier B — Amplifier.** Their coverage of a candidate counts as evidence. They are never
  themselves canonized and never gate admission.
- **Tier C — Watchlist.** Promising, evidence insufficient. Re-checked on cadence.
- **Reject.** Disqualified, or clears no floor.

### Three axes, three floors

Each axis has a floor. **A miss on any axis is not averaged away** — averaging is how a
large following buys past having shipped nothing.

**Reach** — raw scale. Clearing *any one* threshold satisfies the axis:
- ≥50k followers on a single primary platform (X, YouTube, LinkedIn), or
- ≥5k GitHub stars on a primary artifact in the domain, or
- ≥100k package downloads or tool installs, or
- ≥250k aggregate cross-platform following

**Authority** — peer standing. Requires *at least two*:
- Authors or maintains the canonical tool, spec, or library in the domain
- Cited by primary sources (official docs, standards bodies, frontier-lab publications)
- Principal/staff-level or founder at a category-defining company in the domain
- Keynote at a tier-1 conference in the domain
- Original research, or a named methodology other practitioners use

**Authority, young-domain variant.** For domains under ~24 months old, the criteria above
select for a maturity the domain has not reached — there are no tier-1 keynotes in a field
that is a year old, so the standard list admits only institutional players. Domains flagged
`age_months < 24` in `domains.yaml` score against this list instead, still requiring two:

- First-party vendor of the platform (Anthropic, Vercel, et al.)
- Primary artifact verified substantive — *inspected*, not merely described
- Independent editorial coverage (see the Coverage exclusions below)
- Sustained maintenance — ≥6 months of real commits
- Adopted by a named downstream project

*Discovered in the 2026-08-24 UI/UX run: every standard criterion failed for every
third-party candidate, which is why first-party swept the top of that shortlist.*

**Coverage** — independent corroboration:
- ≥3 mentions by *distinct* Tier-A or Tier-B sources within 18 months
- No more than 1 mention counted per source
- No mentions from conflicted parties — anyone the candidate pays, employs, co-founded
  with, or is employed by
- **Auto-generated directories never count.** Skill aggregators index every repo that
  exists, so they discriminate nothing and would clear the floor for any candidate
  whatsoever. Excluded types: auto-generated skill directory, SEO aggregator,
  vendor-owned marketing property. The live blocklist is `config.yaml → coverage.excluded_domains`.

*Discovered in the 2026-08-24 UI/UX run: the first coverage sweep returned Skillselion,
ClaudePluginHub, SkillsMP, MDSkill, and x-cmd — five "independent sources" that are five
scrapers. Real coverage (Snyk, UX Planet, Composio, Firecrawl) only surfaced once those
were excluded from the search.*

### Non-signals

Recorded so they are not re-litigated. **Star-to-watcher ratio does not discriminate
quality for skill repos.** Measured 2026-08-24: `vercel-labs/agent-skills` 251:1,
`anthropics/skills` 155:1, `ui-ux-pro-max-skill` 241:1, against `facebook/react` at 37:1.
Users star skill repos to bookmark and decline to watch to avoid notification load, so the
ratio tracks repo category, not manipulation.

### Tier assignment

| Result | Tier |
|---|---|
| Clears all three floors | **A — Authority** |
| Clears Reach + Coverage, fails Authority | **B — Amplifier** |
| Clears one or two floors, no disqualifier | **C — Watchlist** |
| Any disqualifier, or clears zero floors | **Reject** |

Tier B falls out of the scoring naturally: broad reach and wide corroboration without
originating the work is the precise definition of an influencer.

### Disqualifiers

These override any score:

1. **No verifiable primary artifact.** Talks about the domain, has not shipped in it.
2. **Undisclosed paid promotion.** A documented pattern of promoting without disclosure.

### Evidence rules

Every dossier claim carries a **URL and a retrieval date**. Follower counts are
point-in-time snapshots, never "approximately." Coverage claims name the covering source,
never just a count. Recency window is 18 months for Reach and Coverage; Authority evidence
may be older.

## Data Model

```
registry/
  config.yaml           # thresholds, so "MASSIVE" is a number we can tune
  domains.yaml          # the universe map — every domain the OS needs covered
  creators.yaml         # the Trust Registry
  canon.yaml            # the Skill Canon
  evidence/<slug>.md    # dossier per creator: every signal, URL + retrieval date
skills/<domain>/<slug>/
  SKILL.md              # vendored upstream body, unmodified
  PROVENANCE.yaml       # upstream repo, commit, license, creator ref, vendored date
```

### `domains.yaml`

```yaml
domains:
  - id: ui-ux
    name: UI/UX Design
    group: Content
    definition: Interface design, interaction patterns, design systems, usability
    covered_when: ">=2 Tier-A creators AND >=1 canonized skill"
  - id: frontend-web
    name: Front-End Web Dev & Website Design
    group: Content
  - id: gtm-strategy
    name: GTM Strategy
    group: Offers
  - id: lead-scouting
    name: Lead Scouting & Enrichment
    group: Outreach
  - id: social-scheduling
    name: Social Scheduling & Distribution
    group: Content
  - id: content-repurposing
    name: Content Repurposing
    group: Content
```

`group` reuses the existing Notion taxonomy (Research / Content / Outreach / Offers /
Feedback / Operations / Analytics) so the mirror maps cleanly.

### `creators.yaml`

```yaml
creators:
  - slug: example-creator
    name: Example Creator
    tier: A
    domains: [ui-ux]
    handles:
      x: "@example"
      github: example
    scores:
      reach:     {passed: true,  basis: "62k X followers", retrieved: 2026-08-24}
      authority: {passed: true,  basis: ["maintains canonical lib", "tier-1 keynote"]}
      coverage:  {passed: true,  count: 4, sources: [slug-a, slug-b, slug-c, slug-d]}
    disqualifiers: []
    evidence: evidence/example-creator.md
    canonized: 2026-08-24
    recheck_due: 2027-02-24
```

### `canon.yaml`

```yaml
skills:
  - id: ui-ux/example-skill
    creator: example-creator      # MUST resolve to a tier-A creator
    upstream:
      repo: https://github.com/example/skill
      commit: abc1234
      license: MIT
    vendored: 2026-08-24
    status: canonized             # canonized | superseded | drifted | archived
```

The `creator` field is the two-stage gate made structural: a canon entry that does not
resolve to a Tier-A creator fails validation.

## Modes

All three share the trust engine, the tier logic, and the dossier format.

### `scout <domain>`

Outbound discovery. Batch mode, run once per domain.

1. Read the domain's definition and `covered_when` from `domains.yaml`
2. Fan out: WebSearch, firecrawl, GitHub API, and the existing `last30days` skill for
   cross-platform social signal
3. Build a candidate list; score each on the three axes
4. Write a dossier per candidate to `registry/evidence/`
5. Present a ranked shortlist — including what was rejected and which floor it missed
6. **Await approval**, then write `creators.yaml`, vendor skills, sync Notion, open a PR

### `vet <url>`

Inbound triage of a dropped link. The mode that fires whenever something crosses Mike's
feed, so it optimizes for speed over exhaustiveness.

1. Resolve the URL — repo, X post, YouTube video, article, or raw `SKILL.md` — to a
   *(creator, artifact)* pair
2. Run the creator through the gate; run the artifact against the canon for duplicates
3. Return a verdict: **Canonize / Watchlist / Reject**, always with the reason and the
   tripped disqualifier if there is one
4. On Canonize, and only after approval: same write path as `scout`

An unvetted creator does not block the flow — the creator is vetted inline, and a Tier-B
or Tier-C result sends the artifact to Watchlist rather than rejecting it outright.

### `review`

Canon maintenance. Walks every entry in `canon.yaml` and checks it against upstream.

1. New commits or releases since the vendored pin → flag drift
2. **Forks that have overtaken the parent** in stars or recent commit activity → flag; a
   fork with more traction than its parent usually means the canonical implementation
   moved, and a static registry misses this silently
3. Newer work in the domain that supersedes a canonized skill → flag
4. Creator re-vetting past `recheck_due`; follower collapse or a new disqualifier demotes
   to Watchlist
5. Open a PR with the diff

## Notion Sync

One-way, GitHub → Notion, into the existing `RHB - Agent & Skill Packages` data source
(`collection://20afccbf-926d-80dc-8088-000b23258da6`). Existing properties are preserved.

Properties to add: `Tier`, `Reach`, `Authority`, `Coverage`, `Evidence URL`,
`Canonized Date`, `Upstream Repo`, `License`.

Notion is a read surface. Edits there are overwritten on next sync, and the spec says so
loudly enough that nobody curates in the mirror.

## Out of Scope

- **B2C / Pro / B2B tiering and packaging for Rehabit creators and coaches.** The repo is
  inherently the registry; packaging it for distribution is a separate job, and it is not
  worth designing before the canon holds real content.
- Two-way Notion sync.
- Automated canonization without human approval. Every write path stops for review.

## Assumptions

- "Octopus Social Posting" is general multi-platform scheduling, not Octopus CRM.
  Filed under Content alongside repurposing. *(Confirmed 2026-08-24.)*
- Vendoring is license-gated, and the gate applies **only to third-party skills**: only
  OSI-approved licenses are vendored, with the license recorded in `PROVENANCE.yaml`.
  Anything else is pointer-only. First-party skills (Anthropic, Vercel) install through
  the plugin marketplace and are never vendored, so the gate does not apply to them —
  necessary, because both `anthropics/skills` and `vercel-labs/agent-skills` report no
  SPDX license via the API and an unqualified rule would block the two strongest sources
  in the canon.
- Thresholds in `config.yaml` are a starting position, expected to move after the first
  domain run shows whether they produce names worth respecting.

## Success Criteria

1. `vet <url>` returns a tiered verdict with cited evidence for a dropped link.
2. `scout ui-ux` produces a ranked shortlist whose Tier-A names Mike recognizes as
   genuinely top-of-field — the real test of whether the thresholds are calibrated.
3. `review` detects a fork that has overtaken its parent.
4. Every canonized skill resolves to a Tier-A creator, enforced by validation rather than
   by discipline.
5. The Notion mirror matches the repo after sync.

## Sequencing

Build the trust engine and schemas → wire `vet` first (highest daily use, smallest surface)
→ then `scout`, run end-to-end on UI/UX + front-end web design → then `review` → then the
remaining four domains.
