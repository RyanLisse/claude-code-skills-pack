<!--
Adapted from HumanLayer, `.claude/commands/create_plan_generic.md` in
https://github.com/humanlayer/humanlayer at commit 99abe673498cf8bdcd5f989aebe9406a27185b3b
Copyright (c) 2024, humanlayer Authors. Licensed under the Apache License, Version 2.0 (https://www.apache.org/licenses/LICENSE-2.0; full text in LICENSES/Apache-2.0.txt in the pack repo).
Modified for this pack: output path changed to plan.md; inputs are docs/intent.md, spec.md and the research file;
thoughts/, Linear, `model: opus` and custom-agent references removed; uses Claude Code's built-in subagents only;
adds a recorded human approval gate; plan template moved to assets/plan.md; shortened.
-->

# Write the plan

Build `plan.md` with the user, step by step. Be skeptical and thorough. The plan is the contract the human approves before any code changes.

## Step 1: Context

1. **Read the inputs in full:** `docs/intent.md`, `spec.md`, the research file, and any file the user names. Read them yourself before spawning subagents.
2. **Fill gaps with subagents.** If the research does not cover something the plan needs, run focused, read-only subagents in parallel (built-in Agent tool, formerly Task) and ask for `path:line` references.
3. **Read what they found.** Read every file they flag as relevant, in full.
4. **Check the spec against the code.** Find mismatches, hidden assumptions and the real scope.
5. **Present your understanding and only the questions the code cannot answer:**

```
Based on the spec and the code, we need to [accurate summary].

I found:
- [current behavior with path:line]
- [pattern or constraint to respect]
- [complexity or edge case]

Questions the code can't answer:
- [decision that needs human judgment]
```

## Step 2: Options

1. If the user corrects you, verify the correction in the code before accepting it.
2. Look for similar features to model after.
3. Present the current state, design options with pros and cons, and open questions. Ask which approach fits.

## Step 3: Outline

Propose the phases before writing details:

```
Overview: [1–2 sentences]

Phases:
1. [name] — [what it achieves]
2. [name] — [what it achieves]

Does this order and size make sense?
```

Each phase should leave the build green and be reviewable on its own. Common orders:

- **Database change:** schema/migration → data access → business logic → API → clients
- **New feature:** data model → backend logic → API → UI last
- **Refactor:** document current behavior → small steps → keep backwards compatibility

## Step 4: Write plan.md

Write `plan.md` from `assets/plan.md`. For every phase, list the files and changes, then success criteria in two groups:

- **Automated verification:** commands an agent can run, with the expected result. Use the commands recorded in the research file, not guesses.
- **Manual verification:** what a human must check: UI behavior, performance under real conditions, hard-to-automate edge cases.

```markdown
#### Automated verification
- [ ] Unit tests pass: `pnpm test src/report`
- [ ] Types check: `pnpm typecheck`

#### Manual verification
- [ ] Export button downloads a CSV with the visible columns
```

## Step 5: Review and approval

1. Tell the user where the plan is and ask:
   - Are the phases scoped right?
   - Are the success criteria specific enough?
   - Anything missing from the out-of-scope list?
2. Revise until the user is satisfied.
3. **Approval gate:** when the human approves, record their name and the date under **Approval** in `plan.md`. Implementation does not start before this line is filled. You never fill it in on your own.

## Guidelines

- **Skeptical:** question vague requirements; verify with code, do not assume.
- **Interactive:** do not write the whole plan in one shot; get buy-in at each step.
- **Thorough:** include `path:line` references and measurable success criteria.
- **Practical:** small, testable changes; think about migration, rollback and edge cases; list what you are not doing.
- **No open questions in the final plan.** If one comes up, stop and resolve it with research or the human. No "TBD".
