---
name: review-and-ship
description: Review the current branch for bugs and intent fit, run or add tests, commit focused work, open or update a PR.
disable-model-invocation: true
allowed-tools: Bash(gh *) Bash(git *)
---

# Review and ship

## Context

- Status: !`git status --short`
- Diff vs main: !`git fetch origin main 2>/dev/null; git diff origin/main...HEAD --stat 2>/dev/null || git diff main...HEAD --stat 2>/dev/null || true`
- Checks: !`gh pr checks --json name,bucket,state 2>/dev/null || true`

## Workflow

1. Gather context: base diff, uncommitted changes, recent commits, user intent.
2. Run targeted tests for changed behavior; add tests or document the gap.
3. Review for correctness, regressions, security, intent fit.
4. Fix critical issues; re-run affected tests.
5. Commit selective files with a concise message.
6. Push and open or update a PR.

## Guardrails

- Correctness and security over style-only nits
- Focused commits; no unrelated files
- Fix hook failures rather than bypassing hooks
- Use `gh pr checks` for PR readiness

## Output

- Findings (critical / warning / note)
- Tests run and outcomes
- PR URL
