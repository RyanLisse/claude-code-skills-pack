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

## Other links

- Claude Code skills: https://code.claude.com/docs/en/skills
- skills.sh: https://www.skills.sh/
- mattpocock/skills: https://github.com/mattpocock/skills
- humanlayer show-me: https://github.com/humanlayer/skills/tree/main/plugins/show-me
