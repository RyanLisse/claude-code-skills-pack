# Attribution

## ELI5 skill

`skills/eli5/SKILL.md` is an **original rewrite** for Claude Code. Ideas and framing were informed by public sources (not copied verbatim):

- explainx.ai — “The /eli5 Claude Code Skill…”  
  https://explainx.ai/blog/eli5-claude-code-skill-anthropic-melo-2026  
  (discussion of Anthropic-adjacent `/eli5` usage, visual HTML explainers, and “intelligent beginner / keep the mechanism” quality tests)
- Cloudflare docs ELI5 skill listing  
  https://www.skills.sh/cloudflare/cloudflare-docs/eli5  
  and the public skill under `cloudflare/cloudflare-docs` (`.agents/skills/eli5`) — clarity-first docs simplification philosophy (context before details, accuracy over cute metaphors, layered audiences)

Community marketplace installs mentioned in third-party blogs may differ; verify against current Anthropic / skills.sh docs before treating any install command as official.

## Cursor team-kit ports

The following skills adapt **workflows and intent** from Cursor’s open-source team kit (MIT):

- Source: https://github.com/cursor/plugins/tree/main/cursor-team-kit  
- License: MIT, Copyright (c) 2026 Cursor (see upstream `LICENSE`)

Ports included in this pack (Claude Code `SKILL.md` adaptations, not a Cursor plugin):

| This repo | Upstream skill |
|-----------|----------------|
| `skills/deslop` | `deslop` |
| `skills/verify-this` | `verify-this` |
| `skills/fix-ci` | `fix-ci` |
| `skills/get-pr-comments` | `get-pr-comments` |
| `skills/make-pr-easy-to-review` | `make-pr-easy-to-review` |
| `skills/new-branch-and-pr` | `new-branch-and-pr` |
| `skills/review-and-ship` | `review-and-ship` |

Not ported (by design, keep the pack lean): `control-cli`, `control-ui`, `loop-on-ci`, `pr-review-canvas`, `run-smoke-tests`, `thermo-nuclear-code-quality-review`, `weekly-review`, `what-did-i-get-done`, `workflow-from-chats`, `check-compiler-errors`, `fix-merge-conflicts`, and Cursor-only agents/rules/plugin packaging.

## CLI for agents

`skills/cli-for-agents/SKILL.md` adapts **workflows and intent** from Cursor’s open-source **cli-for-agent** plugin (MIT):

- Source: https://github.com/cursor/plugins/tree/main/cli-for-agent  
- Upstream skill: `skills/cli-for-agents/SKILL.md` in that plugin  
- License: MIT, Copyright (c) 2026 Cursor  

This pack ships a **Claude Code rewrite** (SKILL.md + install path only). It does **not** include Cursor `.cursor-plugin` packaging or a Cursor plugin install path. Patterns (non-interactive flags, layered `--help` with examples, pipelines, actionable errors, idempotency, dry-run) were rewritten for Claude Code agent/Bash usage—not a proprietary dump.

## Archify

`skills/archify/SKILL.md` adapts **workflows and intent** from [tt-a1i/archify](https://github.com/tt-a1i/archify) (MIT):

- Source: https://github.com/tt-a1i/archify  
- Upstream skill package: `archify/` (SKILL.md, `bin/archify.mjs`, schemas, renderers, references)  
- License: MIT — Copyright (c) 2026 tt-a1i (Archify); Copyright (c) 2025 Cocoon AI (see upstream `LICENSE` / `THIRD_PARTY_NOTICES.md`)  
- Based on (upstream metadata): Cocoon-AI/architecture-diagram-generator (MIT)

This pack ships a **Claude Code workflow rewrite** plus install notes (`notes/archify-claude-code.md`). It does **not** vendor the full proprietary-adjacent binary/assets tree or paste upstream SKILL.md / reference contracts verbatim. For validated HTML delivery, install the upstream `archify/` engine (see README) and point `ARCHIFY_HOME` at it, or replace `~/.claude/skills/archify` with the full upstream skill tree.

## Grilling

`skills/grilling/SKILL.md` is copied **verbatim** from Matt Pocock's skills repo (MIT):

- Source: https://github.com/mattpocock/skills/tree/main/skills/productivity/grilling
- License: MIT, Copyright (c) 2026 Matt Pocock (see upstream `LICENSE`)

## Java LTS migration

`skills/java-lts-migration/` is an **original work** for Claude Code. It started from a Java 8 → 11 Devin playbook written for internal use and was restructured after comparing comparable skills and agent workflows (not copied):

- G10xy/java-version-upgrade-skill, claudioed/claude-skills, savitharaghunathan/migration-skills, decebals/claude-code-java — skill structure (per-hop reference files, analysis scripts)
- GitHub Copilot modernization (`plan.md` / progress checkpoints), Amazon Q Developer code transformation (minimal upgrade first, verify after each step), Google's "Migrating Code At Scale With LLMs" (Ziftci et al., FSE 2025: deterministic changes first, LLM for the remainder, automatic validation)
- OpenRewrite `rewrite-migrate-java` recipes and docs; OpenJDK JEPs and Oracle JDK migration guides and release notes for the per-hop content

## RPI and Improve CLAUDE.md (HumanLayer)

Both skills are **adapted copies** of HumanLayer material, credited to HumanLayer as contributors. Every adapted file carries a header naming its source and saying it was modified. Full details, including file mapping, are in [NOTICE](NOTICE).

| This repo | Upstream | License |
|-----------|----------|---------|
| `skills/rpi/references/research.md`, `skills/rpi/assets/research.md` | [humanlayer/humanlayer](https://github.com/humanlayer/humanlayer) `.claude/commands/research_codebase_generic.md` @ `99abe67` | Apache-2.0, Copyright (c) 2024, humanlayer Authors |
| `skills/rpi/references/plan.md`, `skills/rpi/assets/plan.md` | same repo, `.claude/commands/create_plan_generic.md` @ `99abe67` | Apache-2.0 |
| `skills/rpi/references/implement.md` | same repo, `.claude/commands/implement_plan.md` @ `99abe67` | Apache-2.0 |
| `skills/improve-claude-md/SKILL.md`, `skills/improve-claude-md/references/example.md` | [humanlayer/skills](https://github.com/humanlayer/skills) `plugins/improve-claude-md/skills/improve-claude-md/SKILL.md` @ `653b641` | MIT, Copyright (c) 2026 HumanLayer |

- License texts: [`LICENSES/Apache-2.0.txt`](LICENSES/Apache-2.0.txt), [`LICENSES/MIT-HumanLayer.txt`](LICENSES/MIT-HumanLayer.txt). Neither upstream repo has a NOTICE file at those commits.
- **Modified for this pack:** the W5 artifact chain (`docs/intent.md` → `spec.md` → `plan.md` → `PROGRESS.md` → `docs/review.md`); a recorded human plan approval and human review before merge; built-in Claude Code subagents only, no MCP or API key; thoughts/, Linear and model pins removed; for improve-claude-md, commands checked against the repo, progressive disclosure first, and a proposed diff instead of a rewrite.
- Background reading that shaped the edits: HumanLayer, ["Writing a good CLAUDE.md"](https://www.humanlayer.dev/blog/writing-a-good-claude-md) and ["Advanced Context Engineering for Coding Agents"](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents).

## Visual plan and Diagram

Both skills are **adapted** from MIT sources and rewritten for Claude Code. Each `SKILL.md` carries a header naming its sources and saying it was modified. Full details are in [NOTICE](NOTICE).

| This repo | Upstream | License |
|-----------|----------|---------|
| `skills/visual-plan/SKILL.md` | Ryan Lisse's `visualize-html-artifacts` workflow (own work, itself distilled from display-dev/visualize v0.8.0) | MIT |
| `skills/visual-plan/SKILL.md`, `skills/visual-plan/references/kinds.md` | [display-dev/visualize](https://github.com/display-dev/visualize) `visualize/SKILL.md`, `visualize/reference/create.md`, `visualize/templates/{implementation-plan,plan-review,diff-review,project-recap}/template.md` @ `077004e` | MIT, Copyright (c) 2026 display.dev |
| `skills/diagram/SKILL.md` | same repo, `visualize/reference/diagram.md`, `diagram-system.md`, `diagram-sequence.md`, `diagram-flow.md`, `diagram-state.md`, `diagram-hierarchy.md` @ `077004e` | MIT, Copyright (c) 2026 display.dev |
| `skills/diagram/SKILL.md` | [Cocoon-AI/architecture-diagram-generator](https://github.com/Cocoon-AI/architecture-diagram-generator) `architecture-diagram/SKILL.md` @ `4b9087d` | MIT, Copyright (c) 2025 Cocoon AI |
| `skills/visual-plan/SKILL.md`, `skills/diagram/SKILL.md` | [humanlayer/skills](https://github.com/humanlayer/skills) `plugins/show-me/skills/show-me/SKILL.md` @ `653b641` | MIT, Copyright (c) 2026 HumanLayer |

- License texts: [`LICENSES/MIT-display-dev.txt`](LICENSES/MIT-display-dev.txt), [`LICENSES/MIT-Cocoon-AI.txt`](LICENSES/MIT-Cocoon-AI.txt), [`LICENSES/MIT-HumanLayer.txt`](LICENSES/MIT-HumanLayer.txt). None of the three upstream repos has a root NOTICE file at those commits; display-dev/visualize keeps per-skill notices in `visualize/NOTICES.md`.
- **Not used:** display-dev/visualize `reference/color.md` and `reference/explore-system.md` (its `visualize/NOTICES.md` marks them as carrying CC BY 4.0 / Apache-2.0 adapted material), its detector scripts, design systems and vendored bundles; Cocoon AI's `template.html` and its CDN export toolbar (html2canvas, jsPDF). `assets/skeleton.html` and `assets/diagram.html` are original files written for this pack.
- **Modified for this pack:** four kinds only (plan, review, diff, recap) instead of 35 templates; a one-message shape check before building; strictly offline output (no CDN scripts, no web fonts); Mermaid in chat as the default diagram route with inline SVG as the file route; evidence rule (no invented nodes, edges or owners); text shortened and edited.

## pstack (referenced, not vendored)

pstack is **not copied** into this repo. The README documents it and `scripts/install-pstack.sh` fetches it from upstream at a pinned commit.

- Source: https://github.com/cursor/plugins/tree/main/pstack (pstack 0.15.29, commit `88d47514b82e7c44f00f2b2a72ff6dd12158038c`)
- Author: Lauren Tan ([poteto](https://github.com/poteto))
- License: MIT, Copyright (c) 2026 Lauren Tan (upstream `pstack/LICENSE`; the `cursor/plugins` repo as a whole has no top-level license)

The skill summaries in the README paraphrase the upstream `description` fields.

## Other links

- Claude Code skills: https://code.claude.com/docs/en/skills
- skills.sh: https://www.skills.sh/
- mattpocock/skills: https://github.com/mattpocock/skills
- humanlayer show-me: https://github.com/humanlayer/skills/tree/main/plugins/show-me
- display-dev/visualize: https://github.com/display-dev/visualize
- Cocoon-AI/architecture-diagram-generator: https://github.com/Cocoon-AI/architecture-diagram-generator
