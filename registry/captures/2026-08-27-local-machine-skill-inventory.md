# Capture — Local machine skill inventory (Mac Mini)

**Captured:** 2026-08-27
**Trigger:** Mike asked to scan Mac Mini + MacBook for skills built across Claude,
AntiGravity, Codex, Hermes.

## Correction first

This session **is already running on the Mac Mini** (`hostname` → `MikesMacMini.local`,
`scutil --get ComputerName` → "Mike's Mac mini"). No remote scan needed for that
half. The MacBook is a separate machine not reachable from this session — no
network mount to it was found in `/Volumes`. That half needs a session run
directly on the MacBook, or some other sync path.

## Inventory

| Platform | Location | Count | Notes |
|---|---|---|---|
| Claude (personal) | `~/.claude/skills/` | 56 | Mike-authored/installed |
| Claude (plugin-provided) | `~/.claude/plugins/marketplaces/**/skills/` | 85 | Bundled with installed plugins |
| Codex | `~/.codex/skills/` | 48 | See highlights below |
| Hermes | scattered per-project (`hermes-skills/`, `.hermes/`) | 3+ locations found | Not a single central store; project-scoped |
| AntiGravity | — | 0 (Rehabit-authored) | App is installed (`/Applications/Antigravity IDE.app`); the 20 `SKILL.md` files found all belong to bundled VS Code extensions (`vscjava`, `ms-python`), not custom Rehabit content. AntiGravity has no personal skill-authoring store on this machine the way Claude/Codex do. |

## Two findings that change what we're building

**1. Codex already solved "capture an X post."** `~/.codex/skills/ingest-x-post/`
(562-line script, real oEmbed + FxTwitter-endpoint fetching, downloads media,
outputs `post.md` + `manifest.json`) does programmatically what `canon-ingest`
was asking Mike to do by hand. This is exactly the "X Scape" Mike flagged as
needed at the start of this thread. **Action taken:** patched `canon-ingest` to
call this script for X URLs instead of requesting a manual paste, paste remains
the fallback only if the script fails (deleted/protected/unparseable post).

**2. `lead-scout-universal` (Codex) is a live system, not a gap.** Description:
"Universal Lead Scout operating skill for Codex, Claude Code, n8n, and manual
operators... keeping Notion as the source of truth without duplicating work
across platforms." This means `registry/domains.yaml`'s `lead-scouting` domain
is marked `not-scouted`, which is **wrong** — there is already a working,
cross-platform internal system for it. The right move for that domain isn't an
external `canonize scout` pass; it's documenting what already exists and
deciding whether it belongs in the Canon as a Rehabit-authored (not vendored)
entry. Not done in this capture — flagged for a real pass.

**3. `TOOL - OutClipping - HERMES`, the project Mike referenced re: Codex's clip
work, is empty (0 files).** Whatever Codex is building from the Clip skill, it
isn't living there yet. Worth confirming with Mike where that work actually is
before assuming a location.

## Codex skills of note beyond ingest-x-post and lead-scout-universal

`rehabit-speed-to-lead`, `prospect-outbound-orchestrator` (also exists as a
Claude skill — same name, worth checking whether they're the same content or
diverged forks), `agentic-video-production`, `video-production-orchestrator`,
`whatsapp-client-context`, `worldschool-candidate-research`, `vercel-deploy`,
`aws-management`, `gws-gmail-management`. A large fraction of Codex's video
skills (`embedded-captions`, `faceless-explainer`, `hyperframes*`, `slideshow`,
`talking-head-recut`, etc.) share exact names with Claude's — either genuinely
synced, or independently duplicated. Not resolved in this pass.

## Not done in this capture

- Diffing same-named skills across Codex vs. Claude for drift (e.g.
  `prospect-outbound-orchestrator`, the `hyperframes*` family)
- A real evaluation of whether `lead-scout-universal` should enter the Canon
- Scanning the MacBook
- Resolving the Notion SOT page's bookmark-block URLs (tool limitation — see
  the conversation; Mike would need to paste them directly)
