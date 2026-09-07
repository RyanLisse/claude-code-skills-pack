---
name: fix-ci
description: Find failing PR checks, inspect logs, and apply focused fixes until green. Use when CI is red on the current branch or PR.
disable-model-invocation: true
allowed-tools: Bash(gh *) Bash(git *)
---

# Fix CI

## Context

- PR checks: !`gh pr checks --json name,bucket,state,workflow,link 2>/dev/null || true`
- PR: !`gh pr view --json number,url,title,headRefName 2>/dev/null || true`

## Workflow

1. Resolve the active PR; treat `gh pr checks` as source of truth.
2. Open the first failing job; extract the first actionable error (Actions logs or external check link).
3. Apply the smallest safe fix.
4. Push, re-check, repeat until green (or blocked on human input).

## Guardrails

- One actionable failure at a time
- Prefer low-risk fixes before refactors
- Do not bypass hooks unless the user explicitly asks

## Output

- Primary failing job + root error
- Fixes applied (iteration order)
- Current CI status + next action
