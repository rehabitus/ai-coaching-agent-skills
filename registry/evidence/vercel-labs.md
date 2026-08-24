# Dossier — Vercel Labs

**Slug:** `vercel-labs` · **Tier:** A · **Domains:** ui-ux, frontend-web
**Scouted:** 2026-08-24 · **Recheck due:** 2027-02-24

## Reach — PASS
- `vercel-labs/agent-skills` — 30,409 stars, 2,718 forks, 121 watchers.
  Created 2025-12-08, last push 2026-08-21. Retrieved 2026-08-24 via GitHub API.

Clears on `github_stars` (30,409 ≥ 5,000).

## Authority — PASS (young_domain variant)
- `first_party_vendor_of_the_platform` — Vercel authors Next.js and the Web
  Interface Guidelines the skill audits against.
- `sustained_maintenance` — ~8 months of continuous commits.
- `adopted_by_a_named_downstream_project` — shipped as an agent command across
  Claude Code, Cursor, OpenCode, Windsurf, and Gemini CLI.
  Source: https://vercel.com/changelog/web-interface-guidelines-now-available-as-an-agent-command

## Coverage — PASS
1. Snyk — https://snyk.io/articles/top-claude-skills-ui-ux-engineers/
2. Firecrawl — https://www.firecrawl.dev/blog/best-claude-code-skills
3. Composio — https://composio.dev/content/top-design-skills

All retrieved 2026-08-24.

## Disqualifiers
None.

## Skills in domain
`web-design-guidelines`, `react-best-practices`, `composition-patterns`,
`react-view-transitions`, `vercel-optimize`, `writing-guidelines`.
Full list retrieved from repo contents 2026-08-24.

## Notes
`web-design-guidelines` re-fetches the canonical guidelines on every run rather
than bundling static rules, so it cannot drift from upstream. Worth noting because
it solves — upstream and permanently — the exact staleness problem `canonize review`
exists to detect.
