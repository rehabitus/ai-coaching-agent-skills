# Skill Maintenance System

## Source-of-Truth Split

- **Notion owns Needs:** problem, audience, priority, owner, and business context.
- **GitHub owns implementations:** skill contents, versions, tests, provenance, lifecycle, and review history.
- `registry/needs.yaml` is the versioned Notion mirror used for validation and linking. It is not a second place to reprioritize the business.

## Lifecycle

| Status | Meaning | Minimum evidence |
|---|---|---|
| `candidate` | A real Need or upstream option is identified | Stable Need ID or source URL |
| `trial` | The package can be invoked and has a defined evaluation | Owner and test plan |
| `dogfood` | Rehabit used it on a controlled or real internal job | At least one recorded run and operator review |
| `core` | A maintained default Rehabit is willing to recommend | 3 production runs across 2 projects, named owner, passing validation, public sanitization, and evidence for a declared metric |
| `paused` | Useful in principle but not actively maintained | Reason and recheck condition |
| `deprecated` | Replaced or no longer recommended | Replacement or migration note |
| `archived` | Retained only for provenance/history | Final rationale |

External popularity never promotes an internal skill. It can prioritize a trial, but only Rehabit usage promotes to CORE.

## Review Cadence

- `trial` and `dogfood`: every 30 days while active
- `core`: every 90 days
- external canon creators and sources: according to their `recheck_due` dates
- immediate review after a material failure, upstream license change, or security concern

The scheduled repository validator fails when a maintained package passes its review date. The owner then reviews, revises, pauses, deprecates, or renews it with evidence.

## Development Loop

1. **Need:** register the job and audience before collecting solutions.
2. **Reuse:** inspect maintained skills, local implementations, canon, and upstream alternatives.
3. **Trial:** define the smallest observable test and the metric it can actually measure.
4. **Dogfood:** run it inside Rehabit; retain private artifacts privately and publish only sanitized evidence.
5. **Learn:** record operator selection, output quality, operational cost, and business outcome as separate facts.
6. **Improve:** change the smallest instruction, script, or dependency supported by repeated evidence.
7. **Promote or prune:** move to CORE only through the gate; pause or retire packages that do not earn continued maintenance.

## Required Maintenance Metadata

Every maintained skill has:

- a `PACKAGE.yaml` with stable ID, owner, status, Need IDs, audiences, metrics, and review date;
- a matching entry in `registry/skills.yaml` with usage counts;
- at least one pack or an explicit reason it is not yet distributed;
- sanitized run evidence for `dogfood` or `core` status;
- provenance for every external dependency or borrowed implementation.

## Public Sanitization Gate

Before anything reaches the public CORE, verify that it contains no client-identifying media or data, credentials, private filesystem paths, confidential brand assets, private performance details, or license-incompatible upstream content. The private repository should extend the public skill with client recipes and evidence rather than fork its shared instructions without a tracking reason.
