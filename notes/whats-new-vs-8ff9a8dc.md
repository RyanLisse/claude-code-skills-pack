# What’s new vs tip `8ff9a8dc`

Compared to `8ff9a8dc9264d8ff79dfdc7a1480da617a45a91a` (initial ELI5 + team-kit ports):

1. **`skills/cli-for-agents`** — Claude Code rewrite of Cursor’s `cli-for-agent` patterns (agent-friendly CLI design/review). Not a Cursor plugin install.
2. **`skills/archify`** — Claude Code workflow adapter for [tt-a1i/archify](https://github.com/tt-a1i/archify) (typed JSON → validate → deliver HTML). Rewritten guidance; full engine still installed from upstream into `~/.claude/skills/archify` (see `notes/archify-claude-code.md`).
3. **README** — per-skill Claude Code install paths; documents the two new skills.
4. **ATTRIBUTION** — credits for cli-for-agent + archify sources.
5. **notes** — Archify Claude Code install note; this changelog snippet.

Existing team-kit ports and ELI5 unchanged in behavior (already Claude Code `SKILL.md` shape).
