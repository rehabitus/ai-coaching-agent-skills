# Repository Guidance for AI Agents

This repository distinguishes Needs, skills, agents, packs, external canon, and usage evidence. Do not collapse those layers.

## Placement

- Put one repeatable task capability in `skills/<domain>/<name>/`.
- Put orchestration, routing, state, and hand-offs in `agents/`.
- Put audience-specific install selections in `packs/`; reference skills rather than copying them.
- Put business Needs in Notion and mirror their IDs in `registry/needs.yaml`.
- Put external alternatives and source vetting in `registry/canon.yaml`, `registry/evidence/`, or `registry/watchlist/`.

## Change Rules

- Never mark an untested package CORE.
- Never infer business performance from a generated output or operator preference.
- Preserve upstream attribution and check license terms before vendoring.
- Keep public files free of secrets, client identities, private media, and local absolute paths.
- Update `PACKAGE.yaml`, `registry/skills.yaml`, usage evidence, and pack membership together when lifecycle or ownership changes.
- Run `ruby scripts/validate_repository.rb` before reporting completion.

Read `MAINTENANCE.md` for lifecycle gates and review cadence. Concept-stage agent blueprints may remain incomplete when explicitly marked `status: concept`; executable skills may not contain unfinished placeholder instructions.
