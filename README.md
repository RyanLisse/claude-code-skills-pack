# Claude Code Skills Pack

A small, public pack of **Claude Code** skills for Worldline / everyday shipping:

1. **`/eli5`** — explain complex code, diffs, and errors simply (intelligent beginner, real mechanism)
2. **Team-kit ports** — lean Claude Code adaptations of useful [cursor-team-kit](https://github.com/cursor/plugins/tree/main/cursor-team-kit) workflows (not a Cursor plugin)

Aimed at non-experts: copy skills in, type `/skill-name`, get structured help.

## What's inside

| Skill | Command | Purpose |
|-------|---------|---------|
| eli5 | `/eli5` | Plain-language explainers for code, diffs, errors, tradeoffs |
| deslop | `/deslop` | Remove AI code slop from the branch diff |
| verify-this | `/verify-this` | Prove/disprove a claim with baseline vs treatment evidence |
| fix-ci | `/fix-ci` | Find failing checks, fix, iterate to green |
| get-pr-comments | `/get-pr-comments` | Summarize PR review feedback into an action list |
| make-pr-easy-to-review | `/make-pr-easy-to-review` | Clean reviewability (description, guidance; history only if agreed) |
| new-branch-and-pr | `/new-branch-and-pr` | Branch → implement → commit → open PR |
| review-and-ship | `/review-and-ship` | Review, test, commit, open/update PR |

Optional notes: [`notes/CLAUDE.md.snippets.md`](notes/CLAUDE.md.snippets.md), [`notes/hooks-notes.md`](notes/hooks-notes.md).

## Install (Claude Code)

Skills live as folders with a `SKILL.md`. Claude Code loads them from personal or project paths ([docs](https://code.claude.com/docs/en/skills)).

### Option A — personal (all projects)

```bash
git clone https://github.com/RyanLisse/claude-code-skills-pack.git
mkdir -p ~/.claude/skills
cp -R claude-code-skills-pack/skills/* ~/.claude/skills/
```

### Option B — this project only

```bash
# from your project root
mkdir -p .claude/skills
cp -R /path/to/claude-code-skills-pack/skills/* .claude/skills/
# commit .claude/skills so teammates get them
```

### Option C — symlink (easy updates)

```bash
git clone https://github.com/RyanLisse/claude-code-skills-pack.git ~/src/claude-code-skills-pack
mkdir -p ~/.claude/skills
for d in ~/src/claude-code-skills-pack/skills/*; do
  ln -sfn "$d" ~/.claude/skills/$(basename "$d")
done
```

Then in Claude Code:

- Type `/eli5 how does this module work`
- Or ask in plain language; Claude may auto-load skills whose `description` matches
- List skills with `/skills` (when available in your Claude Code version)

**Requirements:** Claude Code CLI; for PR/CI skills, [GitHub CLI](https://cli.github.com/) (`gh`) authenticated in the same environment.

## Learn more

- [Extend Claude with skills](https://code.claude.com/docs/en/skills) — official Claude Code skills docs
- [skills.sh](https://www.skills.sh/) — skill discovery / install index
- [mattpocock/skills](https://github.com/mattpocock/skills) — community skills examples
- [humanlayer show-me](https://github.com/humanlayer/skills/tree/main/plugins/show-me) — visual / show-me style plugin skills

## Attribution

See [ATTRIBUTION.md](ATTRIBUTION.md). Team-kit ports are **rewritten for Claude Code**; they are not a Cursor plugin install. ELI5 is an original rewrite inspired by public ELI5 writeups — not a verbatim copy of proprietary skill text.

## License

MIT — see [LICENSE](LICENSE). Cursor team-kit source is MIT (Copyright 2026 Cursor); retained in attribution.
