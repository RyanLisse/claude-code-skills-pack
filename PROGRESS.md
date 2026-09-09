# Build log

**Historical, append-only.** This file records _what shipped and the evidence_ — not current status. **Live status lives in <TRACKER>** (project **<PROJECT NAME>**); this log does not mirror it.

- Entries are past-tense and immutable: append new ones, never rewrite old ones. A correction is a new entry (or a dated `**Correction (YYYY-MM-DD):**` line inside the original) — never a silent edit.
- Entries cite tracker keys (**`<KEY>-*`**), decision-register rows (**D<nn>**), ADRs (**ADR-<nnnn>**), PRs (**#<nnn>**) and migration numbers (**<nnnn>_<name>**).
- Any status word in a dated entry below (e.g. "Done"/"In Review"/"Active") is a point-in-time snapshot from when the entry was written — not the current state. The tracker is authoritative.
- **Key caveat (optional):** <note any key/ID scheme migration, renumbering or retired mapping table — and where the reader should resolve old keys instead of here.>

Per entry: date, what shipped, the evidence, what was deliberately left out. Newest entries at the bottom.

<!--
WRITING RULES (keep this comment; it does not render)

Voice
- Past tense. Say what happened, what it was measured against, and what the reader should watch for. No "we plan to", no status words presented as current.
- Prose with bold lead-ins per bullet. One idea per bullet; a bullet is 1–3 sentences, not a heading.
- Name the artifact, not the effort: files, functions, tables, migration numbers, test counts, exit codes.

Every entry must be able to answer
1. What shipped — the concrete change (files/packages/tables/routes), and which ticket(s) it closes or advances.
2. Why it mattered — the defect, gap, or decision that made this worth doing. If a behaviour was "declared but never called", say so.
3. Validation — exact commands/suites, counts (N passed / M skipped / K env-gated), exit codes, and what was proven live vs. only in unit tests. Distinguish "green" from "not run here" and say why (no Docker, no credentials, no stack in this worktree, binary not on PATH).
4. Deliberately not done — scope left out on purpose, each with an owner (ticket key) or a reason. This is the section most likely to save the next reader time.

Evidence discipline
- A test that cannot fail is not evidence: when a guard/gate/test is new, record how it was proven non-vacuous (mutation reverted, flag flipped, fixture broken on purpose).
- Distinguish "found" from "fixed". Findings from an adversarial review get their own bullet list, each with the fix and the regression test.
- Record environment gates explicitly (testcontainers suites skipped without Docker, sandbox contract tests skipped without SANDBOX_* creds) so a green run cannot be read as a claim it did not make.
- Record numbers that could go stale (coverage %, row counts, timings) only with the date they were measured — which the entry header already gives.
- Never paste secrets, real personal data or credentials. Env var NAMES are fine; values are not.

Register / numbering
- Claim decision-register ids and migration numbers at merge time, after the final rebase; gaps are tolerated, duplicates are not. State "next free D-id / migration" when a wave changes them.
- If an entry lands out of date order (catch-up, backfill, rebased branch), say so in the first bullet.

Length
- A one-line fix gets a four-bullet entry. A cross-cutting change gets as many bullets as it has lessons, no more.
-->

## Archive

Earlier entries are rotated by quarter into `docs/progress/` to keep this file from growing unbounded. Current-quarter entries stay below, verbatim.

- [YYYY Qn (Mon–Mon)](progress/yyyy-qn.md)

<!-- ========================================================================
     ENTRY TEMPLATES — copy the one that fits, delete the rest.
     Header format:  ## YYYY-MM-DD — <past-tense title> (<KEY>-<n>[, <KEY>-<m>])
     ======================================================================== -->

## YYYY-MM-DD — <Past-tense title of the change> (<KEY>-<n>)

- **What shipped:** <the concrete change — packages, files, tables, routes, UI surface; which ticket(s)/AC(s) it closes or advances>. Decision register **D<nn>**; migration **<nnnn>_<name>** (if any).
- **Why it mattered:** <the defect or gap, stated as behaviour: what a user/operator saw, what was silently wrong, what could not be done>.
- **How, and what was rejected:** <the mechanism in one or two sentences, plus the alternative(s) considered and why they lost — or a pointer to the D-row that has the full reasoning>.
- **Validation:** `<command>` — <N passed / M skipped (env-gated: <reason>)>, exit 0; `<typecheck>` clean; `<lint/gates>` clean. <What was proven live (browser / real Postgres / real provider) vs. unit-only.> <Any evidence artifacts (clips, screenshots) and where they are attached.>
- **Deliberately not done:** <scope left out, each with an owner ticket or a reason>. <Anything not verified in this environment and why.>

---

## YYYY-MM-DD — <Symptom, stated as what broke> (<KEY>-<n>)

<!-- Hotfix / bug entry -->

- **The report:** <what was observed, where, by whom, on which environment>.
- **Cause:** <root cause, established by reproducing rather than inferring; name the file/line or config that carried it>.
- **Fix, at the layer that owns the problem:** <the change and why it lives there and not somewhere closer to the symptom>.
- **Proven both ways:** <the reproduction fails on the old code and passes on the new — say how>.
- **Also corrected in passing / found but not fixed:** <adjacent defects; which got a ticket>.
- **Validation:** <suites, counts, exit codes>.

---

## YYYY-MM-DD — <What the review found> (<KEY>-<n>, follow-up to #<PR>)

<!-- Adversarial-review / hardening pass -->

- **What was found:** <one bullet per real defect: the failing scenario, the mechanism, and why the earlier validation could not see it>.
  1. <finding — fix — regression test>
  2. <finding — fix — regression test>
- **Not a defect, recorded so it is not re-litigated:** <accepted behaviours/readings and the reasoning>.
- **Validation, deliberately broader than the first pass:** <what was re-run and what was added — live Postgres, real image, real browser>.
- **Deliberately not done:** <what the review raised that stays open, with owner>.

---

## YYYY-MM-DD — <Wave / batch name>: <one-line summary of the set>

<!-- Batch of PRs landed together -->

- **What changed:** <PR list with ticket keys and D-rows, one clause each>: #<n> (<summary>, <KEY>-<n>, D<nn>), #<n> (…), …
- **Reviews and CI that changed the code:** <the findings that altered a PR before merge, one clause each; who/what caught them>.
- **Register / numbering:** next free D-id **D<nn>**, next migration **<nnnn>**.
- **Evidence:** <clips/screenshots attached to which tickets; what was NOT re-recorded and why>.
- **Board reconciliation:** <status moves made by hand, tickets auto-closed by branch name and reopened, tickets filed from findings>.
- **Process lessons recorded:** <operational gotchas worth keeping — worktree, tooling, harness limits>.
- **Deliberately not done:** <colleague PRs left alone, waves not started, scope parked>.

| Issue | PR | Merge SHA | Notes |
| --- | --- | --- | --- |
| <KEY>-<n> | [#<n>](<url>) | `<sha>` | <one line> |

---

## YYYY-MM-DD — <Docs / decision-only change> (<KEY>-<n>)

<!-- Docs-only, ADR, runbook, register housekeeping -->

- **What changed:** <files, ADR status transitions, register rows, glossary rows>. No code or migration.
- **Why:** <the gap the doc closes or the decision it records>.
- **Verification:** <doc gates run: register check, formatter, link/parity checks>.
- **Deliberately not done:** <what the doc does not decide; who has to confirm it>.

---

## YYYY-MM-DD — <Title> (<KEY>-<n>, catch-up entry)

<!-- Catch-up / backfill for work that merged without an entry -->

- **Catch-up entry:** <KEY>-<n> shipped and merged as PR #<n> (commit `<sha>`) on <date> without a log entry; this records the history already on `main`, it claims no new work.
- **What shipped:** …
- **Accepted, not defects — recording so neither gets re-litigated:** …
- **Deliberately not done:** …

---

### Follow-up (same day) — <what changed after the entry above>

<!-- Sub-entry under an existing dated entry: same ticket, same day, new fact -->

<one or two short paragraphs: what was reworked, what a review or a live run surfaced, what was verified again>.

**Validation:** <re-run suites and counts>.

<!-- ========================================================================
     OPTIONAL BULLETS — use when they apply, drop when they do not
     ======================================================================== -->

<!--
- **Proven on real data (not just the synthetic fixture):** <live run against a real tenant/provider/image and the numbers it produced>.
- **Findings from an adversarial pass, fixed here with a regression test proven to fail without its fix:** …
- **A dead end worth recording:** <the approach that was tried and why it cannot work, so nobody repeats it>.
- **The lesson worth keeping:** <the generalisable failure mode — a signal gap, a silent-green, a copied shape without its reason>.
- **Operational note:** <what a developer has to do after pulling this — restart, rebuild, migrate, re-seed>.
- **Env note:** <tooling breakage on this machine and the workaround used>.
- **Residual gaps (not in this slice):** …
- **Correction (YYYY-MM-DD):** <the earlier claim that was wrong, what is actually true, and how it was verified> — appended, never edited in place.
-->
