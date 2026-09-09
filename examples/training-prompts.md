# Daily training — example prompts

These prompts are copy-ready starting points for a shared daily training block. Replace the bracketed placeholders with task context before using one. Each prompt asks for an explicit artifact and a human decision; it does not claim evidence that has not been produced. Optional `/eli5`, `/verify-this`, and `/handoff` references assume those skills are installed and available.

## 1. One team, one outcome

```text
We are working together on [TASK / REPO OR PRODUCT] during [TIMEBOX]. Restate the single outcome that would make this block useful, using observable language and one owner for the next decision. Separate the shared outcome from individual learning goals and work that can wait. Return: (1) a one-sentence outcome, (2) two to four acceptance signals, (3) the smallest artifact we can show before the block ends, and (4) one unresolved choice for the humans. Do not invent current status, test results, or stakeholder approval. Humans confirm or edit the outcome before work begins.
```

## 2. Our intent

```text
Using [TASK CONTEXT], help us fill intent.md with: the problem in user or operator terms, the users affected, the desired outcome, constraints, stop rules, open questions, and the one blocker we are willing to address today. Distinguish facts supplied here from assumptions that need checking. Return a concise draft with placeholders preserved where information is missing, plus three questions the humans must answer. Do not turn a proposed solution into the problem statement or infer authorization for production changes, messages, merges, or spending. Humans approve intent.md and its boundaries.
```

## 3. What success looks like

```text
For [OUTCOME] in [REPO / PRODUCT / ENVIRONMENT], turn our definition of success into a small evidence checklist. For each criterion, state the observable result, the check or artifact that could prove it, who can judge it, and whether it is required today or later. Mark anything blocked by missing access or context as unverified; never fill gaps with plausible values. Return the checklist plus a proposed “done for today” line. Humans choose the acceptance threshold and identify which evidence is sufficient for this block.
```

## 4. Check in: what blocks us

```text
For [TASK CONTEXT], prepare two Kahoot questions for the human facilitator: wordcloud — “In at most three words, what blocks your next step today?”; readiness pulse — “1–5: how ready are you to progress today?” If the account lacks wordcloud, use an anonymous shared board. The facilitator runs the activity; process only the supplied responses, omit names, and exclude customer data or secrets. Group the blocker responses into up to five themes and show each theme’s count and representative wording; treat counts as signals, not priority. For each theme, describe likely impact, feasibility of addressing it today, and safety or approval concerns. Return the clusters and tradeoffs. Humans choose the blocker and next step; do not add agent-generated responses or claim resolution without evidence.
```

## 5. Choose today’s outcome

```text
Given [SHARED INTENT], [AVAILABLE TIME], [ROSTER], and [CONSTRAINTS], compare these candidate outcomes: [CANDIDATE A], [CANDIDATE B], [CANDIDATE C]. Score each for user value, evidence we can produce today, dependencies, and risk. Recommend the smallest outcome that advances the shared intent and explain what it deliberately leaves out. Return a one-line choice, acceptance signals, owner, and stop condition. Humans select the outcome and may reject the recommendation; do not start work, contact anyone, or change an environment implicitly.
```

## 6. Today’s rhythm

```text
Design a timeboxed rhythm for [SESSION LENGTH] around [CHOSEN OUTCOME], with [ROLES] and [KNOWN CONSTRAINTS]. Include opening alignment, focused work, evidence checks, a short unblock point, and checkout. For every segment, give a duration, owner, expected artifact, and condition to pause or escalate. Keep enough time for a human review decision before the end. Return a compact agenda and the signals that should trigger a re-plan. Humans set the clock, assign people, and approve any change to the rhythm.
```

## 7. The agentic SDLC

```text
For [TASK / REPO / PRODUCT], choose the SDLC phase that matches the next unresolved question. Use one mini-prompt below, keeping [OUTCOME], [CONSTRAINTS], and [EVIDENCE AVAILABLE] in view. Return the phase, artifact, open risks, and one human decision. Do not imply evidence or deployment that has not happened.
```

**Plan**

```text
Plan — Given [TASK], draft intent.md with the problem, users, desired outcome, constraints, and open questions. After the humans accept the intent and design, draft technical plan.md with scope, dependencies, acceptance signals, and stop condition. Return both drafts and the human decisions still needed.
```

**Design**

```text
Design — Given [OUTCOME] and [CURRENT SHAPE], compare up to three designs against constraints. Return the chosen tradeoffs, rejected options, assumptions to test, and one review question for a human.
```

**Build**

```text
Build — Given the approved [TECHNICAL PLAN / DESIGN] and explicit approval for this bounded slice, implement [CHANGE SLICE]. Keep the diff scoped, report files changed and new risks, and return the completion check. Stop before unrelated work or any newly risky action.
```

**Test**

```text
Test — Given [CHANGE] and [BASELINE], run the available focused checks that fit this context. Report the exact commands or manual checks, actual results, failures, and evidence gaps; label checks that could not run. Stop and surface a new risk instead of widening scope.
```

**Deploy**

```text
Deploy — Given [RELEASE CANDIDATE], draft a staged release and rollback plan for [ENVIRONMENT], including prerequisites and live proof. Return a go/no-go checklist; a named human authorizes any real deployment.
```

**Maintain**

```text
Maintain — Given [RUNNING SYSTEM] and [OBSERVED SIGNAL], propose the smallest safe follow-up: monitor, repair, document, or ticket. Return owner, trigger, evidence to capture, and expiry date; humans decide priority and access.
```

## 8. Start anywhere, connect the loop

```text
Starting from [CURRENT ARTIFACT OR QUESTION] in [TASK CONTEXT], map the nearest useful connections across intent, plan, design, change, test, review, and learning. Identify which link is missing, stale, or contradicted, and name the smallest next artifact that would reconnect the loop. Return a dependency map in plain text, the proposed next handoff, and one question for the human owner. Preserve uncertainty and cite only supplied evidence. Humans decide whether to start at this point, switch to another link, or ask for a /handoff draft.
```

## 9. Our human-agent team

```text
For [OUTCOME], [ROSTER], and [CONSTRAINTS], propose a clear division of responsibility between humans and agents. Assign driver, navigator, researcher or tester, reviewer, remote advocate, and human judgment gates. Rotate the driver every 12–15 minutes so everyone, including remote participants, takes a turn. The remote advocate checks that remote participants can see, hear, and contribute. State what the agent may draft, inspect, or execute within an approved slice and what requires a named human decision. Return a role table, collaboration protocol, and escalation path. Humans accept or revise the assignments before work starts.
```

## 10. Work the next slice

```text
Using the approved [OUTCOME], [PHASE], and [PLAN / DESIGN], work one bounded next slice for [TASK / REPO]. Implement the approved change, run the focused checks available in this context, and report the user-visible result, files or surfaces touched, actual evidence, dependencies, and stop condition. Stop when the acceptance check passes or a new risk appears; do not broaden scope. Return the diff or artifact summary, test results, unresolved questions, and any human decision still required for the next slice.
```

## 11. Show evidence

```text
For the claim “[CLAIM]” about [TASK / CHANGE / ENVIRONMENT], prepare an evidence review. Establish the baseline, state the exact check or observation, record the result with timestamp or revision where available, and distinguish local, CI, provider, and live UI evidence. Mark missing, stale, or inaccessible evidence as unverified; never fabricate logs, screenshots, counts, approvals, or successful runs. You may use /verify-this if available. Return a claim/evidence table and the smallest follow-up check. Humans decide whether the evidence meets the acceptance threshold.
```

## 12. Check out: reflect

```text
Close [SESSION / OUTCOME] in two separate passes. First, ask each human separately: “What can I now do independently, and what evidence supports that?” Also ask what became clearer and what should change. Then ask the agent to summarize only observable artifacts, decisions, unresolved questions, and evidence gaps; keep this separate from individual reflections. Return both sections, plus one improvement with a named owner, target date, and check. Humans choose what to record, share, or carry forward.
```

## 13. Carry it forward

```text
From today’s work on [TASK / OUTCOME], draft a carry-forward note with: keep, drop, trust to widen next, unresolved questions, next owner, and the exact evidence still needed. Include a clipboard-ready /handoff example for the next agent: /handoff [TASK OR ISSUE]: review [ARTIFACT / REVISION], verify [OPEN CLAIM] against [BASELINE], propose the smallest next slice, and report findings before editing; do not push, merge, or post comments. Return the note and handoff prompt with placeholders filled only from supplied context. Humans choose the owner, scope, and any widening of trust.
```
