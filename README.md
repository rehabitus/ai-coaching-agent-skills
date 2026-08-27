# Rehabit Agent Skills

The public, evidence-led registry for agent skills Rehabit actually uses and maintains.

This repository is intentionally not an “awesome list.” A skill earns CORE status only after Rehabit uses it repeatedly, assigns an owner, records evidence, and demonstrates that it improves a workflow or business metric.

## Repository Model

| Layer | Question it answers | Source of truth |
|---|---|---|
| Need | What real Rehabit job needs solving, for whom, and how important is it? | Notion; mirrored in `registry/needs.yaml` |
| Skill | How is one repeatable capability executed? | `skills/` and Git history |
| Agent | Which capabilities should run, and in what order? | `agents/` |
| Pack | Which maintained capabilities should one audience install? | `packs/` |
| Canon | Which external sources and alternatives passed vetting? | `registry/canon.yaml` and evidence dossiers |
| Usage | What have we actually used, and what happened? | `registry/skills.yaml` and sanitized `registry/usage.yaml` |

```text
skills/       portable, task-focused capability packages
agents/       4C and agency orchestration blueprints
packs/        Coaches / Coach's Clients / Coach Agencies bundles
registry/     needs, maintained skills, usage, external canon, provenance
adapters/     Claude, Codex, Hermes, and Antigravity packaging metadata
templates/    starting points for new packages
scripts/      deterministic repository validation
```

The old numbered `01–11` folders represented an agent sequence, not eleven mature skills. They now live under `agents/` with explicit lifecycle status. Sequence belongs in orchestration metadata and diagrams, not in unstable folder numbers.

## Maintained Skills

| Skill | Status | Audiences | Evidence |
|---|---|---|---|
| [Talking-Head Microclips](skills/content-repurposing/talking-head-microclips/) | `dogfood` | Coaches, Coach Agencies | 1 controlled test; 13 candidates; 2 operator-selected previews |

`dogfood` means actively tested inside Rehabit. It does not mean performance-proven or ready for automatic public recommendation.

## Audience Packs

- [Coaches](packs/coaches/PACK.yaml) — capabilities coaches use to operate and grow their own business
- [Coach's Clients](packs/coaches-clients/PACK.yaml) — capabilities delivered directly to the people coaches serve
- [Coach Agencies](packs/coach-agencies/PACK.yaml) — capabilities used repeatedly across multiple coaches

Packs reference shared skills; they never copy them.

## Public and Private Boundary

The public CORE contains sanitized instructions, schemas, provenance, tests, and aggregate usage evidence. Client media, private prompts, brand assets, credentials, commercial details, and client-identifying metrics remain in the private Rehabit implementation repository.

## Contributing and Maintenance

Read [MAINTENANCE.md](MAINTENANCE.md) before adding or promoting a package and [CONTRIBUTING.md](CONTRIBUTING.md) before opening a change.

Validate locally with:

```bash
ruby scripts/validate_repository.rb
```

Scheduled validation checks lifecycle review dates weekly. Every CORE skill still requires a human owner and real dogfood evidence.

## About This Repository

This repository publishes sanitized, reusable skill packages for coaches, the people they coach, and agencies serving coaches. A package belongs here only when it maps to a real Rehabit need and has an owner, lifecycle status, and evidence from actual use. Private client data, credentials, brand assets, and implementation details stay outside the public repository.

### Rehabit Ecosystem

- [Rehabit](https://rehabit.us) — transformation training and future-self coaching for individuals
- [Rehabit for coaches and partners](https://rehabit.biz) — AI-enabled coaching systems and delivery
- [Rehabit on GitHub](https://github.com/rehabitus) — public code and maintained packages
- [Mike Olaski / Ola.Ski](https://ola.ski) — founder and repository maintainer
- [IntoGreat.Systems](https://intogreat.systems) — related integrated-AI systems work for organizations
