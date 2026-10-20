<!--
Template adapted from the plan template in HumanLayer `.claude/commands/create_plan_generic.md`
(https://github.com/humanlayer/humanlayer, commit 99abe673498cf8bdcd5f989aebe9406a27185b3b), Apache-2.0.
Modified: approval and plan-change sections added; links to the W5 artifact chain; shortened.
-->

# [Task] implementation plan

Intent: `docs/intent.md` · Spec: `spec.md` · Research: `docs/research/<file>.md`

## Approval

- Approved by: [name] on [YYYY-MM-DD]  ← a human fills this in; implementation waits for it

## Overview

[What we are building and why, in 1–2 sentences.]

## Current state

[What exists now, what is missing, constraints found.]

Key discoveries:
- [finding with path:line]
- [pattern to follow]

## Desired end state

[What is true when the plan is done, and how to check it. Matches the acceptance criteria in spec.md.]

## What we are not doing

- [item] — [reason or follow-up]

## Approach

[Strategy and reasoning in a few sentences.]

---

## Phase 1: [name]

[What this phase achieves.]

### Changes

- `path/to/file.ext` — [summary of change]

### Success criteria

#### Automated verification
- [ ] [check]: `[command]`

#### Manual verification
- [ ] [what a human checks, or "none"]

Pause after this phase for manual verification before Phase 2.

---

## Phase 2: [name]

[Same structure.]

---

## Testing strategy

- Unit: [what to test, key edge cases]
- Integration: [end-to-end scenarios]
- Manual: [steps]

## Migration and rollback

[If applicable.]

## Plan changes

- [YYYY-MM-DD] — [what changed, why, approved by whom]
