---
name: talking-head-microclips
description: Turn a long-form talking-head, interview, or podcast video into reviewable 7–15 second and 15–45 second vertical clips using transcript-grounded hooks, exact source cuts, captions, restrained graphic reinforcement, and measurable QA. Use for social highlight extraction; not for inventing new dialogue or generating synthetic footage.
metadata:
  version: 0.1.0
  domain: content-repurposing
  4c-phase: compound
  status: dogfood
---

# Talking-Head Microclips

Produce short clips that preserve the creator's exact meaning while making the first few seconds immediately understandable.

## Operating Modes

- **Find:** Return a ranked clip map without rendering.
- **Test:** Render raw and designed previews for the best two to four candidates.
- **Produce:** Render approved candidates and package the delivery artifacts.

Infer the mode from the request. A request to make, test, or produce clips authorizes preview rendering; a request to find moments does not.

## Workflow

1. Obtain a time-aligned transcript and inspect the corresponding video spans. Never select from transcript text alone when footage is available.
2. Find a self-contained one-line hook that lands within the first 3–5 seconds, then keep the shortest source span that delivers the promised payoff.
3. Classify each candidate as `short` (7–15 seconds) or `standard` (15–45 seconds). Do not pad a clip to meet a class.
4. Rank candidates by hook clarity, emotional or intellectual tension, standalone meaning, payoff strength, visual viability, and fit with the stated audience.
5. Preserve exact words and chronology. Never fabricate a pull quote, splice separate statements into a false sentence, or cut away context that changes the claim.
6. For `test` or `produce`, default to 9:16 at 1080×1920. Keep the speaker naturally framed and use 1:1 only when the brief or destination requires it.
7. Add accurate embedded captions. Derive typography, colors, pacing, and end-frame treatment from the creator's own supplied references or brand system.
8. Use at most one primary graphic interruption per microclip unless the content genuinely needs more. It should reinforce the claim, not compete with the speaker.
9. Use emotional B-roll only when it increases comprehension or felt meaning. Do not add generic filler, stock clichés, or unrelated spectacle.
10. Deliver the raw source cut alongside the designed version so editorial lift can be evaluated.

## Required Outputs

- `clip-map.json` with timestamps, exact hook, rationale, class, and risk notes
- raw source clips for the rendered candidates
- designed previews or finals, according to mode
- `run-result.yaml` recording counts, review outcome, time-to-first-usable-clip when known, and any failures

Before delivery, apply [the acceptance criteria](references/acceptance-criteria.md). Keep client identities, private media paths, credentials, and brand-only assets out of the public package.

## Learning Loop

Record operator selections separately from published performance. A chosen concept is not yet a proven business result. Feed completed run data to the Metric Loop so future changes are supported by repeated evidence rather than one-off preference.
