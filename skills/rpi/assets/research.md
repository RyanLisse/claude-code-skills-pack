<!--
Template adapted from the research document structure in HumanLayer `.claude/commands/research_codebase_generic.md`
(https://github.com/humanlayer/humanlayer, commit 99abe673498cf8bdcd5f989aebe9406a27185b3b), Apache-2.0.
Modified: thoughts/ sections removed; commands and conventions sections added; shortened.
-->

# Research: [task]

Date: [YYYY-MM-DD] · Commit: [short sha] · Branch: [branch] · Intent: `docs/intent.md`

Describes the code as it is. No proposals.

## Questions

1. [question]
2. [question]

## Summary

[Short answer to the questions.]

## Findings

### [question or component 1]

- [fact] (`path/to/file.ts:42`)
- [how it connects to other parts]

### [question or component 2]

- …

## Code references

- `path/to/file.py:123` — [what is there]
- `another/file.ts:45-67` — [what the block does]

## Conventions to follow

- [naming, error handling, test layout, with an example path]

## Commands

| Purpose | Command | Defined in |
|---|---|---|
| Build | `[cmd]` | [package.json / Makefile / CI] |
| Test (all) | `[cmd]` | |
| Test (one file) | `[cmd]` | |
| Lint / typecheck | `[cmd]` | |

## Open questions

- [question] — needs: [human decision / more reading]
