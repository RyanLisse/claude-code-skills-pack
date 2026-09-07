---
name: deslop
description: Remove AI-generated code slop and clean up style in the current branch diff. Use for deslop, unslop, clean AI cruft, or tighten a diff without changing behavior.
disable-model-invocation: true
---

# Deslop / unslop

Clean AI-generated slop from the branch diff against the default base branch. Prefer behavior-preserving edits.

## Context

- Diff vs base: !`git fetch origin main 2>/dev/null; git diff origin/main...HEAD 2>/dev/null || git diff main...HEAD 2>/dev/null || git diff HEAD`
- Status: !`git status --short`

## Focus

- Comments that restate the code or mismatch local style
- Defensive try/catch or null checks abnormal for trusted paths
- `any` / type escapes used only to silence the compiler
- Deep nesting that should be early returns
- Patterns inconsistent with neighboring code

## Guardrails

- Keep behavior unchanged unless fixing a clear bug
- Minimal focused edits; no drive-by rewrites
- Summarize in 1–3 sentences when done

## Output

- Files touched
- What slop was removed
- Anything left intentionally (with reason)
