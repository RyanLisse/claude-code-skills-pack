<!--
Adapted from HumanLayer, `.claude/commands/implement_plan.md` in
https://github.com/humanlayer/humanlayer at commit 99abe673498cf8bdcd5f989aebe9406a27185b3b
Copyright (c) 2024, humanlayer Authors. Licensed under the Apache License, Version 2.0 (https://www.apache.org/licenses/LICENSE-2.0; full text in LICENSES/Apache-2.0.txt in the pack repo).
Modified for this pack: plan path changed to plan.md; refuses to start without recorded human approval;
appends PROGRESS.md entries per phase; adds a 3-attempt stop rule and a no-bypass rule; generic
`make check test` replaced by the plan's own commands; shortened.
-->

# Implement the plan

Implement an approved `plan.md`, one phase at a time. Each phase lists its changes and its verification.

## Getting started

- Read `plan.md` in full. Check **Approval**: if no human is recorded there, stop and ask for approval.
- Note ticked phases (`[x]`). Read `spec.md`, the research file and every file the plan names, in full.
- Make a todo list for the current phase.

## How to follow the plan

Follow the plan's intent and adapt to small surprises: a renamed variable, an extra import. Finish each phase before starting the next. Tick items in `plan.md` as you go.

If the code and the plan disagree in a way that changes the design, stop and report:

```
Issue in Phase [N]:
Expected: [what the plan says]
Found: [actual situation]
Why this matters: [explanation]
Proposed plan change: [edit to plan.md]

How should I proceed?
```

Record any approved change under **Plan changes** in `plan.md` before continuing.

## Verification

After each phase:

1. Run the phase's automated verification commands from the plan, exactly as written.
2. Fix failures and re-run. After 3 failed attempts on the same problem, stop and report what you tried.
3. Tick the phase's automated items in `plan.md`.
4. Append a `PROGRESS.md` entry: date, phase, what changed (files), commands run and their results, anything deferred. Past tense, no status words presented as current.
5. If the phase lists manual verification, pause:

```
Phase [N] complete. Ready for manual verification.

Automated verification passed:
- [command] → [result]

Please check:
- [manual items from the plan]

Tell me when this is done so I can start Phase [N+1].
```

Do not tick manual items until the human confirms them. If the human asked for several phases in a row, pause only after the last one.

Never skip hooks, disable tests or weaken a check to get green.

## If you get stuck

- Make sure you have read all the relevant code.
- Check whether the code changed since the plan was written (`git log` on the planned files).
- Report the mismatch and ask. Use subagents only for targeted debugging or unfamiliar areas.

## Resuming

If `plan.md` has ticked phases, trust them and start at the first unticked item. Re-check earlier work only if something looks wrong.
