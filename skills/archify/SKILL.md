---
name: archify
description: >-
  Turn a codebase or system description into a polished, validated interactive
  HTML system map (architecture, workflow, sequence, dataflow, lifecycle) using
  the Archify engine. Use when the user asks to visualize architecture,
  infrastructure, workflows, API sequences, data pipelines, state machines, or
  to convert/beautify Mermaid into a trustworthy diagram artifact.
argument-hint: "[system description, path, or diagram type]"
---

# Archify (Claude Code)

Produce a **self-contained interactive HTML** diagram from typed JSON IR. Claude Code authors the JSON; the Archify CLI validates and delivers HTML/SVG. Prefer truth over spectacle: do not invent topology, runtime impact, or merge safety.

Request: $ARGUMENTS

## Engine setup (required for delivery)

This skill is a Claude Code workflow adapter. The renderer lives in upstream **tt-a1i/archify** (MIT). Resolve `ARCHIFY_ROOT` in this order:

1. `$ARCHIFY_HOME` if set and contains `bin/archify.mjs` (recommended with this pack’s thin skill)
2. `~/.claude/skills/archify` **only if** that directory contains `bin/archify.mjs` (full upstream skill install — Option 2)
3. `.claude/skills/archify` in the current project, same `bin/archify.mjs` check
4. Otherwise clone the engine once (do not overwrite this thin `SKILL.md` unless switching to Option 2):

```bash
git clone --depth 1 https://github.com/tt-a1i/archify.git ~/src/archify
export ARCHIFY_HOME=~/src/archify/archify   # persist in shell profile
# Or full upstream skill: cp -R ~/src/archify/archify ~/.claude/skills/archify
# Or: npx skills add tt-a1i/archify -g
```

Then:

```bash
export ARCHIFY_ROOT="${ARCHIFY_HOME:-$HOME/.claude/skills/archify}"
node "$ARCHIFY_ROOT/bin/archify.mjs" doctor
```

If Node or the engine is unavailable, say so clearly and stop—do not hand-wave a fake “validated” HTML.

## Choose a diagram type

| Type | Use for |
|------|---------|
| `architecture` | Components, services, storage, trust/cloud boundaries |
| `workflow` | CI/CD, approvals, tool calls, runbooks |
| `sequence` | API calls, cache miss, auth, async traces |
| `dataflow` | Pipelines, lineage, PII, consumers |
| `lifecycle` | States, retries, waits, terminal outcomes |

Ambiguous? Ask one clarifying question, or run:

```bash
node "$ARCHIFY_ROOT/bin/archify.mjs" guide "<scenario>" --json
```

## Fast authoring path

1. **Pick type** from the table (or guide output).
2. **Read only** the matching schema + one JSON example under `$ARCHIFY_ROOT/schemas/` and `$ARCHIFY_ROOT/examples/` for field shape—not facts to copy. Author **fresh** stable IDs and domain wording.
3. **Write a candidate JSON file first** (artifact before prose coordinates). Aim for one clear main path, short side branches, sparse labels, ≤12 primary nodes. Prefer `meta.quality_profile: "showcase"` unless the user asks for dense `standard`.
4. **Validate after every candidate edit** and before handoff:

```bash
node "$ARCHIFY_ROOT/bin/archify.mjs" validate <type> <candidate.json> --quality showcase --json
```

Showcase acceptance needs a full showcase receipt (not a minimal subset of checks). On failure: fix only the diagnosed subject using supported fixes; do not rewrite unrelated structure.

5. **Deliver once** when validation is green:

```bash
node "$ARCHIFY_ROOT/bin/archify.mjs" deliver <type> <candidate.json> <output.html> --quality showcase --json
```

Non-zero exit is never success. A failed delivery may leave a previous last-good file—do not claim the new candidate shipped.

6. **Optional** browser evidence (does not replace human polish review):

```bash
node "$ARCHIFY_ROOT/bin/archify.mjs" visual-check <output.html> --json
```

Add `--open` on deliver only if the user wants an immediate local preview. Do not start `preview` by default.

## Authoring invariants (rewritten)

- One obvious main path; drop low-value edges before adding routing knobs.
- Default visual preset/theme: omit fancy presets unless the user asks (`signal-flow`, `blueprint`, `editorial`).
- Preserve exact product names, paths, protocols, and identifiers.
- Brand marks are optional and explicit—never infer a brand from a vague role like “database”.
- Relationship labels are semantic; move or shorten before deleting meaning.
- Mermaid input: extract topology/meaning, then author fresh Archify JSON—do not mechanically re-skin Mermaid styles.
  - flowchart/graph → `workflow` or `architecture`
  - sequenceDiagram → `sequence`
  - stateDiagram → `lifecycle`
- New workflows: prefer schema v2; keep v1 only when preserving legacy fixed geometry.
- Architecture `deployment-ownership` profile is fail-closed and only when the user explicitly asks for ownership/deployment review with known facts.

For field enums, spacing math, evidence beacons, and viewer deep-links, read upstream references under `$ARCHIFY_ROOT/references/` only when needed—not before the first candidate.

## Architecture delta (PR review)

When comparing two validated architecture snapshots:

```bash
node "$ARCHIFY_ROOT/bin/archify.mjs" compare architecture base.json head.json architecture-delta.html --json
```

Report authored added/removed/changed/moved/rerouted facts only. Do not invent risk or merge recommendations.

## Output to the user

```text
## Result
HTML: <path>
Type: architecture|workflow|sequence|dataflow|lifecycle
Validate: pass|fail (summary)
Deliver: pass|fail (receipt summary if any)
Visual-check: ran|skipped|failed (honest)

## Notes
- What was authored vs inferred from the repo
- Open questions / unresolved diagnostics
```

Never claim success for a failed command or claim visual inspection you did not perform.

## Attribution

Adapted for Claude Code from [tt-a1i/archify](https://github.com/tt-a1i/archify) (MIT). This pack ships a **workflow rewrite + install path**, not a verbatim dump of the full upstream skill package (schemas, renderers, brand marks). Prefer installing the upstream `archify/` tree into `~/.claude/skills/archify` for the engine.
