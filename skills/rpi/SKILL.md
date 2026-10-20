---
name: rpi
description: "Research, plan, then implement a change in phases, with a human approving the plan and reviewing before merge. Use for features or fixes that touch several files, unfamiliar code, or work that must survive a session reset; follows the docs/intent.md → spec.md → plan.md → PROGRESS.md → docs/review.md artifact chain. Not for one-line fixes."
argument-hint: "[task, or path to docs/intent.md]"
disable-model-invocation: true
---

# RPI: research → plan → implement

> Adapted from HumanLayer's `research_codebase`, `create_plan` and `implement_plan` commands (Apache-2.0) and modified for this pack. See [ATTRIBUTION.md](https://github.com/RyanLisse/claude-code-skills-pack/blob/main/ATTRIBUTION.md) and [NOTICE](https://github.com/RyanLisse/claude-code-skills-pack/blob/main/NOTICE).

Three passes, each leaving a file behind. The files carry the state, so any pass can start in a fresh session.

Task: $ARGUMENTS

## Artifact chain

| Stage | File | Written by | Gate |
|---|---|---|---|
| Intent | `docs/intent.md` | Human | Exists before you start |
| Research | `docs/research/YYYY-MM-DD-<slug>.md` | You | None; facts only |
| Spec | `spec.md` | You draft, human edits | Human accepts |
| Plan | `plan.md` | You | **Human approves** |
| Progress | `PROGRESS.md` | You, per phase | Verification green |
| Review | `docs/review.md` | You | **Human reviews before merge** |

If the repo already keeps these files elsewhere, use its locations. Never overwrite a human's `docs/intent.md` or `spec.md` without asking.

## Files in this skill

Read them when the step says so, not up front.

| File | Read when |
|---|---|
| `references/research.md` | Step 1 |
| `assets/research.md` | Step 1: template for the research file |
| `references/plan.md` | Step 2 |
| `assets/plan.md` | Step 2: template for `plan.md` |
| `references/implement.md` | Step 3 |

## Rules

- Human review is policy. You do not approve your own plan, and you never merge.
- Facts come from the code, not memory. Cite `path:line` for every claim in research.
- A phase is done only when its verification commands pass. "Should work" is not done.
- Scope comes from `spec.md`. Anything else goes in the plan's out-of-scope list.
- Local tools only: Read, Grep, Glob, Bash and Claude Code's built-in subagents. Works on a Claude Code subscription; no MCP servers or API keys.
- Never skip hooks, disable tests or weaken a check to get green.

## 0. Resume or start

1. If `plan.md` exists, read it and `PROGRESS.md`:
   - Not approved → step 2, ask for approval.
   - Approved, phases left → step 3, from the first unticked phase.
   - All phases ticked and verified → step 4.
2. Otherwise read `docs/intent.md`. If it is missing, stop: ask the human to write it (problem, outcome, constraints), or offer a draft for them to edit. Do not invent the goal.
3. Pick a short slug for the task (`add-csv-export`).

## 1. Research

Follow `references/research.md`. Turn the intent into 3–6 questions, answer them from the code with parallel read-only subagents, and write `docs/research/YYYY-MM-DD-<slug>.md`. Record the real build/test/lint commands and where each is defined. Describe; do not propose.

If `spec.md` is missing, draft it from the intent and research: what changes, acceptance criteria, non-goals. Ask the human to accept it before planning.

## 2. Plan

Follow `references/plan.md`. Agree the phases with the human, then write `plan.md`: per phase, the files to change, automated verification (exact commands, expected result) and manual verification. No open questions in the final plan.

**Stop and ask for approval.** Record who approved and when under **Approval** in `plan.md`. No code changes before that.

## 3. Implement

Follow `references/implement.md`, phase by phase:

1. Make the phase's changes.
2. Run its automated verification. Stop after 3 failed attempts on the same problem.
3. Tick the phase in `plan.md` and append a `PROGRESS.md` entry with the commands and results.
4. Pause for manual verification if the phase lists any.

If the code disagrees with the plan, stop, propose a plan change and wait for approval.

## 4. Review handoff

Write `docs/review.md`:

- Each acceptance criterion from `spec.md` with its evidence (test name, command output, screenshot)
- Deviations from the plan and why
- What was not verified here and why
- Risks and suggested follow-ups

Tell the human the work is ready for review. Do not merge, and do not mark the review approved yourself.

## Context hygiene

Long sessions drift. Between passes, if the context is heavy, start a fresh session and resume from the files. Keep raw search output out of the main thread: subagents read widely and return short findings.

## Done when

- [ ] The research file cites code for every claim
- [ ] `plan.md` was approved by a human before implementation started
- [ ] Every phase is ticked with green verification recorded in `PROGRESS.md`
- [ ] `docs/review.md` maps each acceptance criterion to evidence
- [ ] A human has the PR for review; nothing was merged by you
