# Contributing to AI Coaching Agent Skills

Thank you for your interest in contributing. These skills power the 4C AI Coaching OS — every contribution helps coaches scale their positive impact.

## How to Contribute

### Adding a New Skill

1. Fork this repo
2. Create a new numbered directory in `skills/` (e.g. `skills/12-your-skill-name/`)
3. Add a `SKILL.md` inside it using `skills/00-template/SKILL.md` as your starting point
4. Include clear frontmatter (`name`, `description`)
5. Write the skill body with structured sections
6. Submit a pull request

### Improving an Existing Skill

1. Open an issue describing the improvement
2. Fork and make your changes
3. Submit a pull request referencing the issue

### Skill File Format

```yaml
---
name: your-skill-name
description: When the user wants to... Use when...
metadata:
  version: 0.1.0
  category: core | scaling | utility
  4c-phase: clarify | condition | create | compound | all
---

# Skill instructions here
```

### Guidelines

- Skills should be **focused** — one agent, one purpose
- Write instructions as if briefing a capable colleague
- Include the 4C phase mapping where applicable
- Reference other skills when there are dependencies
- Keep skills portable — no hardcoded paths or API keys

## Code of Conduct

Be respectful. Build for positive impact. These tools exist to help coaches project better visions into the world.
