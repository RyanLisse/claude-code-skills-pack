---
name: get-pr-comments
description: Fetch and summarize review comments on the active pull request into a prioritized action list.
disable-model-invocation: true
allowed-tools: Bash(gh *)
---

# Get PR comments

## Context

- PR: !`gh pr view --json number,url,title 2>/dev/null || true`
- Review comments: !`gh api repos/{owner}/{repo}/pulls/$(gh pr view --json number -q .number)/comments --jq '.[].body' 2>/dev/null | head -200 || true`
- Issue comments: !`gh pr view --comments 2>/dev/null | head -200 || true`

## Workflow

1. Resolve the active PR for the current branch.
2. Fetch review + discussion comments.
3. Group by severity and actionability.
4. Return a concise action list.

## Output

- Grouped feedback summary
- Action list (priority order)
- Open questions still needing clarification
