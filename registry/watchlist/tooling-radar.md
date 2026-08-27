# Tooling Radar — internal reference, NOT the Canon

**This is not `registry/canon.yaml`.** Nothing here has passed the trust engine
(creator tiers, three-axis floors, disqualifiers). Canon admission stays strict —
"aggregating need and usefulness," per Mike, not "looked interesting in a thread."
This file exists for the wider bucket: tools Mike or a scout pass flagged as
possibly useful to Rehabit's own build/ops, tracked so they aren't re-discovered
from scratch later. Promotion to the Canon requires a real `canonize vet` pass.

---

## Batch 1 — flagged by Mike from the 2026-08-27 X capture

Source: `registry/captures/2026-08-27-ridark_eth-50-github-repos.md`. Mike's own
read: only **Clip** and **Remotion** are close to a real need, **PersonaLive**
maybe. Full 14 captured below regardless, since the point of this file is not
re-losing the ones that don't matter as much as the ones that do.

| # | Repo | Stars | License | Status | Relevance |
|---|---|---|---|---|---|
| 4 | ~~zhouxiaoka/autoclip_mvp~~ → **[zhouxiaoka/autoclip](https://github.com/zhouxiaoka/autoclip)** | 7,022 | MIT | Active, pushed 2026-06-03 | **Close to a need.** MVP linked in the source is deprecated; this is the maintained successor. Bilibili-first, Chinese-language docs/community — wrong platform for Rehabit's audience. Codex is already building from this one (per Mike, 2026-08-27) — see Batch 2 below for alternatives to sanity-check it against. |
| 6 | [remotion-dev/remotion](https://github.com/remotion-dev/remotion) | 57,462 | NOASSERTION* | Active | **Close to a need — already in use.** Underlies the existing `hyperframes` / `remotion-to-hyperframes` skills. Not a new find; confirms the stack choice was right. *License shows NOASSERTION via API despite being a well-known commercially-licensed product — check Remotion's actual license terms (company license, not pure MIT) before any redistribution decision. |
| 7 | [GVCLab/PersonaLive](https://github.com/GVCLab/PersonaLive) | 3,552 | Apache-2.0 | Active, pushed 2026-05-15 | **Maybe close.** CVPR 2026 peer-reviewed paper backing this — real academic authority, not just GitHub traction. Portrait animation for live streaming. Worth a hands-on look if 24/7 AI-avatar presence becomes a real ask; not urgent otherwise. |
| 1 | feder-cr/Jobs_Applier_AI_Agent_AIHawk | — | — | Archived | **Avoid.** ToS-violating spam pattern, archived by owner. |
| 5 | FujiwaraChoki/MoneyPrinterV2 | — | — | Active | **Avoid.** Source's own "get-rich-quick" flag; not a fit for Rehabit's positioning. |
| 16 | [rtk-ai/rtk](https://github.com/rtk-ai/rtk) | 77,563 | Apache-2.0 | Active | Internal-tooling candidate, not coach-facing. Verified real (2,065 open issues rules out star-farming) but only 7 months old. LLM token-cost CLI proxy — relevant to Rehabit's own AI-OS operating cost, not the Canon. |
| 17 | [BlockRunAI/ClawRouter](https://github.com/BlockRunAI/ClawRouter) | 6,571 | MIT | Active | Same bucket as rtk — LLM cost router, internal tooling only. |
| 18 | xtekky/gpt4free, cheahjs/free-llm-api-resources | — | — | — | **Avoid.** ToS bypass tools. |
| 23 | [SYSTRAN/faster-whisper](https://github.com/SYSTRAN/faster-whisper) | 25,108 | MIT | Active (last push 2025-11-19) | Real, well-known, widely depended-on (it's what powers `openshorts` in Batch 2 below). Local transcription — relevant if self-hosted captioning ever beats API-based. |
| 31 | [firecrawl/firecrawl](https://github.com/firecrawl/firecrawl) | 172,973 | AGPL-3.0 | Active | **Already in use** — Mike's existing `firecrawl:*` skills. Validates, not new. |
| 33 | [jina-ai/reader](https://github.com/jina-ai/reader) | 11,915 | Apache-2.0 | Active | Lighter-weight than firecrawl for single-page URL→text. Apache-2.0 vs firecrawl's AGPL-3.0 — worth remembering if firecrawl's copyleft ever blocks a vendoring call. |
| 36 | [czlonkowski/n8n-mcp](https://github.com/czlonkowski/n8n-mcp) | 22,791 | MIT | Active | **The standout find.** Connects n8n to Claude/Cursor/Windsurf via MCP — matches Mike's stated n8n-over-Zapier preference directly. Worth a hands-on trial. |
| 37 | [KhazP/vibe-coding-prompt-template](https://github.com/KhazP/vibe-coding-prompt-template) | 2,874 | MIT | Active, pushed 2026-08-21 | Prompt templates for PRDs/tech-design/MVP generation. Process tooling, not a skill — low urgency, easy to try cheaply. |
| 40 | [ixartz/SaaS-Boilerplate](https://github.com/ixartz/SaaS-Boilerplate) | 7,381 | MIT | Active, pushed 2026-08-21 | **Stack match.** Next.js + Tailwind + Shadcn + TypeScript, exactly Mike's default stack (per CLAUDE.md), with auth/multi-tenancy/roles/i18n/billing built in. Worth a look next time a new Rehabit project scaffolds from scratch. |

---

## Batch 2 — BIC research: long-form video → shorts/highlight extraction

Requested 2026-08-27 to give Mike a comparison set while Codex builds from
`autoclip`, rather than adopting the one repo a thread happened to name. Most of
the WebSearch hits for this category (vizard.ai, opus.pro, choppity, alignify,
airpost) are **competitor marketing content, not independent coverage** — excluded
per the same rule that filters auto-generated directories out of Canon Coverage.
Verified against the actual repos instead.

| Repo | Stars | Forks | License | Status | Note |
|---|---|---|---|---|---|
| [zhouxiaoka/autoclip](https://github.com/zhouxiaoka/autoclip) | 7,022 | — | MIT | Active | What Codex is building from. Bilibili/Chinese-first. |
| **[mutonby/openshorts](https://github.com/mutonby/openshorts)** | 3,595 | 940 | **NOASSERTION** ⚠️ | Active, pushed yesterday | Strongest technical pipeline of the set: faster-whisper for transcription, PySceneDetect for scene boundaries, Gemini for moment-scoring, FFmpeg + MediaPipe face-tracking for the 9:16 reframe. Fork:star ratio (940:3,595 ≈ 1:3.8) is unusually high — people are running and modifying it, not just bookmarking it. **But:** marketing copy claims MIT; the actual repo license reads NOASSERTION despite a LICENSE file being present. Don't vendor on the marketing claim — recheck the license text directly before any decision. |
| [NaufalRizqullah/opensource-clipping](https://github.com/NaufalRizqullah/opensource-clipping) | 78 | 39 | MIT | Active | Real but small — below any reasonable floor. Feature list (face-tracking, kinetic subtitles, B-roll, voice-over, auto-upload) is broader than openshorts on paper; traction doesn't back it up yet. |
| kirat11X/video-clipper-vizard-AI-replica, siddeshh/ClipX, EthanMiller11/Awesome-AI-Video-Clipping | 16 / 1 / 0 | — | — | — | Noise. Named "replica" and "alternative-to" projects with negligible traction; not worth tracking individually. |

**Read:** `openshorts` is the technically strongest English-first alternative to
`autoclip` — worth a look once Codex's build is far enough along to compare
against, specifically because its pipeline composes tools already in this radar
(`faster-whisper` is item 23 above). The license ambiguity is the one thing to
resolve before treating it as more than a reference.

---

## Notes for `canon-ingest`

Two corrections this run surfaced, folded back into the skill:

1. **Don't trust a repo's own marketing copy for license or fork/star math** —
   check the API's actual license field and the real numbers. `openshorts`
   claims MIT in its README/site copy; GitHub reports NOASSERTION.
2. **A linked repo can be a dead MVP with a live successor** — `autoclip_mvp` →
   `autoclip`. Check for a deprecation banner before scoring the repo you were
   handed.
