# AI Coaching Agent Skills

**Open-source agent skills for coaches, consultants, and solo founders who use AI to amplify human potential — not replace it.**

Built by [Rehabit](https://rehabit.ai) — rehabiting coaching through AI that focuses on our *Actual Intelligence*. These skills power the **4C AI Coaching OS**, a coordinated agent system that helps conscious coaches clarify their vision, liberate their time, and scale their impact.

> The HOLOPreneur thesis: A solo founder-coach, armed with the right AI agent skills, can reach a billion lives — measured not in revenue alone, but in the reach and impact that revenue enables. From dystopia to utopia, one coached human at a time.

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## What Are Agent Skills?

Agent Skills are portable instruction sets (`.md` files) that give AI agents specialized capabilities. Drop a `SKILL.md` into your project and your AI assistant gains domain expertise — from coaching session design to client journey orchestration.

Each skill in this collection is designed for the **4C execution loop**:

| Phase | Mode | What Happens |
|-------|------|-------------|
| **Clarify** | Orientation | Establish direction, anchor vision, define identity |
| **Condition** | Rehearsal | Practice new patterns, build capability through repetition |
| **Create** | Expression | Turn insights into tangible output |
| **Compound** | Leverage | Distribute, get feedback, integrate learnings |

---

## Skills

### Core Agents (Internal OS)

These foundational agents exist for every user and client in the system.

| Skill | Description | Status |
|-------|-------------|--------|
| [Vision Agent](skills/core/vision-agent/) | Clarify direction — establish future states, anchor goals, maintain the north star | `placeholder` |
| [Persona Agent](skills/core/persona-agent/) | Evolving self-model — track identity shifts, adapt guidance to who the user is becoming | `placeholder` |
| [Journey Co-Pilot](skills/core/journey-copilot/) | Orchestration layer — coordinate all agents, decide what happens next, detect readiness | `placeholder` |
| [Lessons Agent (Lescen)](skills/core/lessons-agent/) | Learn / Practice / Play engine — deliver experience-driven learning that never ends | `placeholder` |
| [Creator Agent](skills/core/creator-agent/) | Play becomes output — turn insights into ideas, frameworks, drafts, and prototypes | `placeholder` |
| [Producer Agent](skills/core/producer-agent/) | Idea to execution — add structure, timelines, and momentum to ship imperfectly | `placeholder` |
| [Composer Agent](skills/core/composer-agent/) | Integration and narrative — synthesize across all agents, prevent fragmentation | `placeholder` |

### Scaling Agents (AgentC Layer)

B2B leverage agents used in the ForeSee / 4C Agency to scale coaching operations.

| Skill | Description | Status |
|-------|-------------|--------|
| [Scout Agent](skills/scaling/scout-agent/) | Signal detection — identify opportunities, monitor trends, detect market gaps | `placeholder` |
| [Enrichment Agent](skills/scaling/enrichment-agent/) | Context expansion — add depth, references, case studies to upgrade signal to insight | `placeholder` |
| [Sharing Agent](skills/scaling/sharing-agent/) | Distribution and feedback — prepare outputs for platforms, close feedback loops | `placeholder` |
| [Integrating Agent](skills/scaling/integrating-agent/) | System memory — feed results back, update models, improve future guidance | `placeholder` |

### How They Work Together

```
Vision sets direction
  → Persona defines current self
    → Journey decides next step
      → Lescen delivers Learn / Practice / Play
        → Creator turns Play into output
          → Producer ships it
            → Sharing tests it in the world
              → Integrating feeds results back
                → Composer keeps meaning intact
                  → Loop restarts — stronger
```

---

## Quick Start

### Option 1: Clone the whole collection

```bash
git clone https://github.com/rehabitus/ai-coaching-agent-skills.git
```

Copy any skill folder into your project's `.claude/skills/` directory (or equivalent).

### Option 2: Use individual skills

Copy the `SKILL.md` from any skill folder directly into your AI workflow.

### Option 3: Reference as submodule

```bash
git submodule add https://github.com/rehabitus/ai-coaching-agent-skills.git skills/coaching
```

---

## The 4C AI Coaching OS

These skills are the building blocks of a larger system:

- **Rehabit** (rehabit.ai) — The core B2C coaching engine
- **ForeSee / 4C** (rehabit.biz) — The B2B layer for coaches, powered by AgentC
- **Syndicus** — Community and digital twin layer
- **Lescen** — The learning experience engine (Learn / Practice / Play)

The 4C stands for the qualities we look for in coaches we serve: **Conscious, Creative, Connected, Coach** — and the execution loop they master: **Clarify, Condition, Create, Compound**.

---

## Philosophy

Most AI systems answer questions, generate content, or optimize tasks.

**These skills build capability.**

They don't just help users *do things* — they help users **become the kind of person who can do those things repeatedly**.

The agents here are designed for coaches who project positive visions and images into the world. AI focused on Actual Intelligence. Skills essential for the HOLOPreneur — the solo founder-coach building toward massive impact.

---

## Contributing

We welcome contributions from coaches, builders, and AI practitioners. See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Creating a new skill

```
skills/
  category/
    your-skill-name/
      SKILL.md          # Required — the skill definition
      references/       # Optional — supporting docs
```

Use the [skill template](skills/template/) as a starting point.

---

## License

MIT License. See [LICENSE](LICENSE) for details.

---

Built with purpose by [Rehabit](https://rehabit.ai) | [ForeSee 4C](https://rehabit.biz) | [@rehabitus](https://github.com/rehabitus)
