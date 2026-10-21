# Claude Code Skills Pack

A small, public pack of **Claude Code** skills for Worldline / everyday shipping:

1. **`/eli5`** — explain complex code, diffs, and errors simply (intelligent beginner, real mechanism)
2. **Team-kit ports** — lean Claude Code adaptations of useful [cursor-team-kit](https://github.com/cursor/plugins/tree/main/cursor-team-kit) workflows (not a Cursor plugin)
3. **`/cli-for-agents`** — design/review CLIs so agents can run them headlessly (from [cli-for-agent](https://github.com/cursor/plugins/tree/main/cli-for-agent), rewritten for Claude Code)
4. **`/archify`** — architecture / workflow / sequence maps via [Archify](https://github.com/tt-a1i/archify) (Claude Code workflow adapter + engine install path)
5. **`/handoff`** — write clipboard-ready prompts for another agent to investigate or continue a task
6. **`/grilling`** — get grilled round by round on a plan, decision, or idea until nothing is silently assumed
7. **`/java-lts-migration`** — upgrade a Java codebase one LTS hop at a time (8 → 11 → 17 → 21 → 25) with OpenRewrite first, a checkpoint plan, and test-parity evidence
8. **`/rpi`** — research → plan → implement in verified phases, with a human approving the plan and reviewing before merge
9. **`/improve-claude-md`** — audit a repo's `CLAUDE.md` and propose a shorter, accurate version as a diff
10. **`/visual-plan`** — turn a plan, plan review, diff review or recap into one self-contained HTML page
11. **`/diagram`** — architecture, sequence and flow diagrams as Mermaid, or an offline HTML file with inline SVG
12. **[pstack](#pstack-by-reference)** — poteto's skill set (`/poteto-mode`, verification skills, `/unslop`, …), installed by reference from upstream, not vendored

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
| grilling | `/grilling` | Stress-test a plan via rounds of numbered questions with recommended answers |
| java-lts-migration | `/java-lts-migration` | Java 8/11/17/21 → next LTS: plan file, OpenRewrite pass, build-fix loop, verification scripts |
| rpi | `/rpi` | Research → plan → implement along `docs/intent.md` → `spec.md` → `plan.md` → `PROGRESS.md` → `docs/review.md`; human approves plan and reviews |
| improve-claude-md | `/improve-claude-md` | Check `CLAUDE.md` commands against the repo, cut stale lines, move detail to linked docs; proposes a diff, never rewrites silently |
| visual-plan | `/visual-plan` | Plan, plan review, diff/PR review or recap → one offline HTML file (shape check first, no CDN, light/dark, phone width) |
| diagram | `/diagram` | Architecture / sequence / flow / state diagrams from real code: Mermaid in chat, or HTML + inline SVG; no install (use `/archify` for validated system maps) |

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
| **grilling** | `cp -R skills/grilling ~/.claude/skills/` → `/grilling …` |
| **java-lts-migration** | `cp -R skills/java-lts-migration ~/.claude/skills/` → `/java-lts-migration 21` (needs a JDK and Maven or Gradle; OpenRewrite optional) |
| **rpi** | `cp -R skills/rpi ~/.claude/skills/` → `/rpi docs/intent.md` |
| **improve-claude-md** | `cp -R skills/improve-claude-md ~/.claude/skills/` → `/improve-claude-md` |
| **visual-plan** | `cp -R skills/visual-plan ~/.claude/skills/` → `/visual-plan plan plan.md` |
| **diagram** | `cp -R skills/diagram ~/.claude/skills/` → `/diagram sequence checkout flow` |
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

## pstack (by reference)

[pstack](https://github.com/cursor/plugins/tree/main/pstack) is poteto's (Lauren Tan) set of 56 agent skills and principles for writing less but better-verified code: `/poteto-mode` for rigorous work, verification skills, subagent workflows, and writing clean-up. It lives upstream in [`cursor/plugins`](https://github.com/cursor/plugins) under `pstack/`.

**This pack does not vendor pstack.** pstack is MIT (Copyright (c) 2026 Lauren Tan, see its [`LICENSE`](https://github.com/cursor/plugins/blob/main/pstack/LICENSE)), so copying would be allowed. It still stays upstream: it is released several times a week, and a copy here would go stale and blur whose skill is whose. This repo only documents and pins the version we use and provides an install script.

**Pinned version:** pstack **0.15.29**, upstream commit [`88d4751`](https://github.com/cursor/plugins/tree/88d47514b82e7c44f00f2b2a72ff6dd12158038c/pstack). `cursor/plugins` has no pstack tags, so the pin is the commit that set `pstack/plugin.json` to `0.15.29`.

No pstack skill name clashes with a skill in this pack.

### Install

| Tool | How |
|------|-----|
| **Claude Code + Codex** (symlinks) | `scripts/install-pstack.sh`: it fetches the pinned commit to `~/.local/share/pstack/0.15.29` and symlinks each skill into `~/.claude/skills/` and `~/.codex/skills/`. |
| **Cursor** | Marketplace plugin: `/add-plugin pstack`. Cursor reads `pstack/` directly; the script does not touch `~/.cursor`. |
| Claude Code, official alternative | `/plugin marketplace add cursor/plugins` then `/plugin install pstack@cursor-plugins`. This gives upstream's generated Claude Code tree; commands are prefixed (`/pstack:poteto-mode`). Do not combine it with the symlinks, or every skill exists twice. |

```bash
scripts/install-pstack.sh --dry-run         # show what would change, write nothing
scripts/install-pstack.sh                   # Claude Code + Codex
scripts/install-pstack.sh --targets codex   # one tool only
```

The script is safe to re-run.
- It never overwrites a file, directory or symlink that does not point into `~/.local/share/pstack` (`PSTACK_ROOT`). It reports that name as skipped and exits `3`.
- It refuses a `PSTACK_ROOT` that is relative, `/`, not normalised, or a symlink.
- It relinks skills that point at an older pstack version, and removes links to skills the new version no longer ships.

Manual equivalent:

```bash
git clone --filter=blob:none --no-checkout https://github.com/cursor/plugins.git /tmp/cursor-plugins
git -C /tmp/cursor-plugins sparse-checkout set pstack
git -C /tmp/cursor-plugins checkout 88d47514b82e7c44f00f2b2a72ff6dd12158038c
mkdir -p ~/.local/share/pstack && cp -R /tmp/cursor-plugins/pstack ~/.local/share/pstack/0.15.29
for d in ~/.local/share/pstack/0.15.29/skills/*/; do
  for t in ~/.claude/skills ~/.codex/skills; do
    mkdir -p "$t"; [ -e "$t/$(basename "$d")" ] || ln -s "${d%/}" "$t/$(basename "$d")"
  done
done
```

Then run `/setup-pstack` once to pick models and a reasoning budget.

pstack skills use Cursor tool and model names (`Task`, `AskQuestion`, Cursor model slugs). The official Claude Code plugin ships with the mapping. The symlink install does not, and Claude Code does not read the adapter by itself. Add one line to your `~/.claude/CLAUDE.md`:

```markdown
When you run a pstack skill, first read ~/.local/share/pstack/0.15.29/docs/harness/claude-code.md and map Cursor names with it.
```

The adapter maps `Task` → `Agent` and `AskQuestion` → `AskUserQuestion`, and says to skip Cursor-only steps such as Bugbot or Automations. Codex has no such adapter, so read Cursor names as their nearest Codex equivalent.

### Update

1. Look up the new version and its commit:
   ```bash
   gh api 'repos/cursor/plugins/commits?path=pstack/plugin.json&per_page=3' --jq '.[]|.sha+" "+.commit.message'
   ```
2. Bump `PSTACK_VERSION` and `PSTACK_REF` in `scripts/install-pstack.sh`, plus the pin in this section. For a one-off install, pass `--version V --ref SHA` instead.
3. Run `scripts/install-pstack.sh`. It fetches into a new `~/.local/share/pstack/<version>` folder and re-points the links. The script checks that `plugin.json` at that commit really has the version you asked for.
4. Delete the old version folder once you are happy with the new one.
5. Cursor updates through the marketplace plugin.

### Most useful skills

| Skill | Use it for |
|-------|-----------|
| `/setup-pstack` | First run: choose models per role and a reasoning budget. |
| `/poteto-mode` | Any work that needs rigor. Concise answers, deliberate subagents, simple code, verified results. |
| `/create-verification-skill` | Generate a project-local skill that drives your app (UI, CLI or service) the way a user does, so "it works" is proven. Keep it current with `/maintain-verification-skill`. |
| `/create-formal-verification-skill` (beta) | Generate a project-local skill that formally checks one costly property (races, retries, state machines, parsers) with a model checker or prover. It is the newest of the verification skills, so treat it as beta; upstream gives it no stability label. Keep it current with `/maintain-formal-verification-skill`. |
| `principle-prove-it-works` | Before saying "done": check the real artifact (run it, read the value, inspect the diff), not a proxy or "it compiles". |
| `/show-me-your-work` | Long or unattended runs: a TSV decision trail (what, why, evidence, result) for a reviewer. |
| `/unslop` | Cut AI tells from any writing: PR bodies, docs, messages. |
| `/interrogate` | Multi-model adversarial review of a change. |
| `/poteto-help` | Not sure which skill fits? Ask here. |

Most pstack skills set `disable-model-invocation: true`, so you call them by name instead of relying on the agent to pick them. In Claude Code and Cursor that means typing `/name`. In Codex, mention the skill by name. The full list is in [pstack's README](https://github.com/cursor/plugins/tree/main/pstack#readme).

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
- [cursor/plugins pstack](https://github.com/cursor/plugins/tree/main/pstack) — poteto's pstack (referenced, see [pstack](#pstack-by-reference))

## Contributors / credits

- **[HumanLayer](https://github.com/humanlayer)** — `/rpi` is adapted from HumanLayer's `research_codebase`, `create_plan` and `implement_plan` Claude Code commands (Apache-2.0); `/improve-claude-md` is adapted from HumanLayer's `improve-claude-md` skill (MIT). `/visual-plan` and `/diagram` borrow the "smallest view that makes the point" approach and the text/Mermaid views from HumanLayer's `show-me` skill (MIT). All were modified for this pack; see [NOTICE](NOTICE).
- **[display.dev](https://github.com/display-dev/visualize)** — `/visual-plan` structure (plan, plan review, diff review, recap) and `/diagram` type routing and budgets are adapted from display-dev/visualize (MIT), modified.
- **[Cocoon AI](https://github.com/Cocoon-AI/architecture-diagram-generator)** — `/diagram` SVG layout rules (edge z-order, masking, spacing, legend placement, role colors) are adapted from the `architecture-diagram` skill (MIT), modified.
- **[Matt Pocock](https://github.com/mattpocock/skills)** — `/grilling` (MIT).
- **[Cursor](https://github.com/cursor/plugins)** — team-kit ports and `/cli-for-agents` (MIT).
- **[tt-a1i/archify](https://github.com/tt-a1i/archify)** — Archify engine and upstream skill (MIT).
- **[Lauren Tan (poteto)](https://github.com/poteto)** — pstack (MIT), referenced and installed from upstream `cursor/plugins`; no pstack files are copied into this repo.

## Attribution

See [ATTRIBUTION.md](ATTRIBUTION.md). Ports are **rewritten for Claude Code**; they are not a Cursor plugin install. ELI5 is an original rewrite inspired by public ELI5 writeups — not a verbatim copy of proprietary skill text.

## License

MIT — see [LICENSE](LICENSE). Upstream Cursor plugin sources, Archify, HumanLayer's skills repo, display-dev/visualize and Cocoon AI's architecture-diagram-generator are MIT; HumanLayer's commands used by `/rpi` are Apache-2.0. pstack (MIT, Lauren Tan) is installed from upstream and not redistributed here. Third-party license texts are in [`LICENSES/`](LICENSES/) and notices in [NOTICE](NOTICE).
