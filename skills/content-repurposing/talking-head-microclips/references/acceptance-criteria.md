# Acceptance Criteria

Use this reference when ranking candidates, reviewing previews, or deciding whether a run counts as successful dogfood evidence.

## Candidate Contract

Each candidate must include:

```yaml
id: stable-short-id
class: short | standard
source_start_seconds: 0.0
source_end_seconds: 0.0
duration_seconds: 0.0
hook_window_seconds: 5
hook_quote: Exact source words
payoff: Why the rest earns attention
audience_fit: Who should care and why
visual_plan: speaker-only | graphic-reinforcement | b-roll
risk_notes: []
```

Reject a candidate when the hook requires unseen context, the payoff merely repeats the hook, the edit changes the claim, or the sentence sounds visibly or audibly mutilated.

## Designed Clip Contract

- Canvas defaults to 1080×1920, 9:16.
- The speaker remains recognizable and naturally framed throughout reframes and punch-ins.
- Captions match the audible words, remain inside platform-safe areas, and do not obscure the face or essential graphics.
- The first frame is intentional; no dead air, black frame, or slow logo intro precedes the hook.
- Graphic reinforcement communicates one idea and remains legible on a phone.
- An end frame, when used, is normally 0.5–1.5 seconds and does not truncate the final spoken thought.
- Audio begins cleanly, speech remains intelligible, and the export contains no clipping or accidental silence.
- The final duration remains inside its declared class.

## Run Result Contract

```yaml
skill: content-repurposing/talking-head-microclips
date: YYYY-MM-DD
mode: find | test | produce
source_videos: 1
candidates: 0
rendered_previews: 0
operator_selected: 0
published: 0
time_to_first_usable_clip_minutes: null
review:
  outcome: passed | revise | failed
  reasons: []
business_metrics: {}
```

Do not infer publishing, acceptance, retention, leads, or revenue. Record `null` until the measurement exists.
