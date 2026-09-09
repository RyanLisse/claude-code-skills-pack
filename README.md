# Claude Code Skills Pack

A small, public pack of **Claude Code** skills for Worldline / everyday shipping:

1. **`/eli5`** — explain complex code, diffs, and errors simply (intelligent beginner, real mechanism)
2. **Team-kit ports** — lean Claude Code adaptations of useful [cursor-team-kit](https://github.com/cursor/plugins/tree/main/cursor-team-kit) workflows (not a Cursor plugin)
3. **`/cli-for-agents`** — design/review CLIs so agents can run them headlessly (from [cli-for-agent](https://github.com/cursor/plugins/tree/main/cli-for-agent), rewritten for Claude Code)
4. **`/archify`** — architecture / workflow / sequence maps via [Archify](https://github.com/tt-a1i/archify) (Claude Code workflow adapter + engine install path)
5. **`/handoff`** — write clipboard-ready prompts for another agent to investigate or continue a task

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
| cli-for-agents | `/cli-for-agents` | Agent-friendly CLI design & review patterns |
| archify | `/archify` | Validated interactive HTML system maps (needs Archify engine) |
| handoff | `/handoff` | Clipboard-ready prompts for another agent |

Optional notes: [`notes/CLAUDE.md.snippets.md`](notes/CLAUDE.md.snippets.md), [`notes/hooks-notes.md`](notes/hooks-notes.md), [`notes/archify-claude-code.md`](notes/archify-claude-code.md), [`notes/whats-new-vs-8ff9a8dc.md`](notes/whats-new-vs-8ff9a8dc.md).

## Install (Claude Code)

Skills live as folders with a `SKILL.md`. Claude Code loads them from personal or project paths ([docs](https://code.claude.com/docs/en/skills)).

### Bulk install (all skills in this pack)

#### Option A — personal (all projects)

```bash
git clone https://github.com/RyanLisse/claude-code-skills-pack.git
mkdir -p ~/.claude/skills
cp -R claude-code-skills-pack/skills/* ~/.claude/skills/
```

#### Option B — this project only

```bash
# from your project root
mkdir -p .claude/skills
cp -R /path/to/claude-code-skills-pack/skills/* .claude/skills/
# commit .claude/skills so teammates get them
```

#### Option C — symlink (easy updates)

```bash
git clone https://github.com/RyanLisse/claude-code-skills-pack.git ~/src/claude-code-skills-pack
mkdir -p ~/.claude/skills
for d in ~/src/claude-code-skills-pack/skills/*; do
  ln -sfn "$d" ~/.claude/skills/$(basename "$d")
done
```

### Install each skill (Claude Code)

Replace `~/.claude/skills` with `.claude/skills` for project-only installs.

| Skill | Install |
|-------|---------|
| **eli5** | `cp -R skills/eli5 ~/.claude/skills/` → `/eli5 …` |
| **deslop** | `cp -R skills/deslop ~/.claude/skills/` → `/deslop` |
| **verify-this** | `cp -R skills/verify-this ~/.claude/skills/` → `/verify-this …` |
| **fix-ci** | `cp -R skills/fix-ci ~/.claude/skills/` → `/fix-ci` (needs `gh`) |
| **get-pr-comments** | `cp -R skills/get-pr-comments ~/.claude/skills/` → `/get-pr-comments` (needs `gh`) |
| **make-pr-easy-to-review** | `cp -R skills/make-pr-easy-to-review ~/.claude/skills/` → `/make-pr-easy-to-review` (needs `gh`) |
| **new-branch-and-pr** | `cp -R skills/new-branch-and-pr ~/.claude/skills/` → `/new-branch-and-pr …` (needs `gh`) |
| **review-and-ship** | `cp -R skills/review-and-ship ~/.claude/skills/` → `/review-and-ship` (needs `gh`) |
| **cli-for-agents** | `cp -R skills/cli-for-agents ~/.claude/skills/` → `/cli-for-agents …` |
| **handoff** | `cp -R skills/handoff ~/.claude/skills/` → `/handoff …` |
| **archify** | See **Archify** below (skill + engine) |

Then in Claude Code:

- Type `/eli5 how does this module work` (or `/cli-for-agents`, `/archify`, `/handoff`, …)
- Or ask in plain language; Claude may auto-load skills whose `description` matches
- List skills with `/skills` (when available in your Claude Code version)

**Requirements:** Claude Code CLI; for PR/CI skills, [GitHub CLI](https://cli.github.com/) (`gh`) authenticated in the same environment. **Archify** also needs Node.js and the upstream engine (below).

### Archify (skill + engine)

This pack’s `skills/archify` is a **Claude Code workflow adapter**. HTML delivery needs the upstream Archify package (`bin/archify.mjs`, schemas, renderers).

**Recommended (thin skill from this pack + engine via `ARCHIFY_HOME`):**

```bash
# 1) Skill from this pack
mkdir -p ~/.claude/skills
cp -R /path/to/claude-code-skills-pack/skills/archify ~/.claude/skills/

# 2) Engine from upstream (not vendored here)
git clone --depth 1 https://github.com/tt-a1i/archify.git ~/src/archify
export ARCHIFY_HOME=~/src/archify/archify   # add to shell profile
node "$ARCHIFY_HOME/bin/archify.mjs" doctor
```

**Alternative (full upstream skill only):** copy upstream `archify/` tree over `~/.claude/skills/archify` (includes their `SKILL.md` + engine). Skip or overwrite this pack’s thin adapter—do not keep two different trees under the same skill name. Details: [`notes/archify-claude-code.md`](notes/archify-claude-code.md).

```bash
git clone --depth 1 https://github.com/tt-a1i/archify.git /tmp/archify-src
rm -rf ~/.claude/skills/archify
cp -R /tmp/archify-src/archify ~/.claude/skills/archify
```

## What's new vs `8ff9a8dc`

See [`notes/whats-new-vs-8ff9a8dc.md`](notes/whats-new-vs-8ff9a8dc.md): added **cli-for-agents** and **archify** Claude Code skills, README per-skill install, and attribution for both sources.

## Examples / workshop templates

| File | Purpose |
|------|---------|
| [`examples/intent.md`](examples/intent.md) | Wave 2 workshop **intent** template — problem, outcome, constraints, one blocker, roster (humans + agent), artifact chain, checks, carry-forward / gradual release. Humans fill it; agents work toward it. |
| [`examples/training-prompts.md`](examples/training-prompts.md) | Copy-ready prompts for the 13 sections of a shared daily training block, including six agentic SDLC phase prompts. |

## Learn more

- [Extend Claude with skills](https://code.claude.com/docs/en/skills) — official Claude Code skills docs
- [skills.sh](https://www.skills.sh/) — skill discovery / install index
- [mattpocock/skills](https://github.com/mattpocock/skills) — community skills examples
- [humanlayer show-me](https://github.com/humanlayer/skills/tree/main/plugins/show-me) — visual / show-me style plugin skills
- [tt-a1i/archify](https://github.com/tt-a1i/archify) — Archify engine + upstream skill
- [cursor/plugins cli-for-agent](https://github.com/cursor/plugins/tree/main/cli-for-agent) — upstream CLI-for-agents patterns

## Attribution

See [ATTRIBUTION.md](ATTRIBUTION.md). Ports are **rewritten for Claude Code**; they are not a Cursor plugin install. ELI5 is an original rewrite inspired by public ELI5 writeups — not a verbatim copy of proprietary skill text.

## License

MIT — see [LICENSE](LICENSE). Upstream Cursor plugin sources and Archify are MIT; retained in attribution.
