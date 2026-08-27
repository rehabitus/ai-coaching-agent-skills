# Contributing

Contribute only against a demonstrated Rehabit need. Interesting tools belong on the watchlist until a real job requires them.

## Choose the Correct Layer

- Add a `skill` when the package teaches a repeatable, independently useful task.
- Add an `agent` when it selects or sequences several skills and owns hand-offs or state.
- Add a `pack` when an audience needs a curated installation bundle.
- Add a `need` when the problem is real but the implementation is not yet selected.
- Add an external candidate to the watchlist or canonization workflow; do not quietly copy it into CORE.

## Adding a Skill

1. Register the Need in Notion and mirror its stable ID in `registry/needs.yaml`.
2. Search the existing skills and external canon for reusable components.
3. Create `skills/<domain>/<skill-name>/SKILL.md` and `PACKAGE.yaml` using `templates/skill/`.
4. Add the implementation to `registry/skills.yaml` with an owner, lifecycle status, review date, and honest usage counts.
5. Add it to audience packs only when the audience mapping is demonstrated.
6. Add sanitized run evidence to `registry/usage.yaml` after real testing.
7. Run `ruby scripts/validate_repository.rb`.

## Skill Rules

- Use lowercase hyphenated names; the frontmatter name must match the skill folder.
- Give the skill one clear repeatable outcome. Agents own orchestration.
- Keep instructions portable: no local absolute paths, credentials, private client names, or undisclosed proprietary assets.
- Preserve exact provenance and license information for external material.
- Do not describe a concept, stub, or untested prompt as production-ready.
- Record unknown performance as `null`; never turn an operator preference into a business-result claim.

## Pull Request Evidence

Every material skill change should identify the Need, owner, lifecycle status, observed failure or desired metric, test evidence, public/private review, and next review date. CORE promotion must satisfy the gate in [MAINTENANCE.md](MAINTENANCE.md).

## Code of Conduct

Be respectful. Build for positive human impact, give upstream creators credit, and make evidence stronger than claims.
