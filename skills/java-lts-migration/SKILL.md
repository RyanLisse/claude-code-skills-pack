---
name: java-lts-migration
description: "Upgrade a Java codebase (Maven, Gradle or Ant) between LTS versions 8, 11, 17, 21 and 25, one hop at a time, with minimal behavior change and test-parity evidence. Use for 'upgrade to Java 17/21/25', 'bump the JDK', 'migrate from Java 8', or errors like 'Unsupported class file major version' and 'InaccessibleObjectException'. Not for adopting new language features or Spring Boot major upgrades."
argument-hint: "[target version, e.g. 21]"
---

# Java LTS migration

Move a project from its current Java version to a target LTS (11, 17, 21 or 25) with minimal behavior change. The result is one reviewable PR per hop that builds and passes the same tests on the target JDK, with before/after evidence.

Target: $ARGUMENTS (if empty, ask once; default to the newest LTS the project's framework supports).

## Principles

- **One LTS hop at a time:** 8 → 11 → 17 → 21 → 25. Get each intermediate hop green before starting the next. Skipping hops mixes unrelated failures.
- **Baseline first.** Record a build and test run on the current JDK before changing anything, so pre-existing failures are not blamed on the migration.
- **Deterministic tools first, the model second.** OpenRewrite does the mechanical edits; you fix what is left.
- **Mechanical diffs only.** No refactors, no framework majors, no new language features. Those are follow-ups.
- **Stay on the classpath.** Do not add `module-info.java` unless the project already has one.
- **Upgrade libraries before adding flags.** Every `--add-opens`, `--enable-native-access` or compatibility property is temporary, documented and linked to the library that needs it.
- **Never** disable, delete or weaken a test; never add `-DskipTests`, `@Disabled`, `failOnError=false` or `-Dnet.bytebuddy.experimental=true` to get green. Never commit keystores, credentials or tokens.
- **Follow repo conventions** for branches, commits and PR templates; fall back to `chore/java-<target>-migration` and Conventional Commits.
- **Org policy wins.** If `docs/migration-policy.md` or `.github/java-migration/*.md` exists, read it first; it overrides these defaults (JDK vendor, base images, allowed flags).

## Files in this skill

Read them when the step says so, not up front.

| File | Read when |
|---|---|
| `assets/MIGRATION_PLAN.md` | Step 1: copy to the repo root and fill in |
| `references/hop-8-to-11.md` … `hop-21-to-25.md` | Step 5: only the hop you are on |
| `references/library-matrix.md` | Steps 1 and 5: minimum library versions per JDK |
| `references/openrewrite.md` | Step 4: commands, scope control, fallback |
| `references/troubleshooting.md` | Whenever a build or test fails |
| `scripts/intake.sh` | Step 1 |
| `scripts/test-count.sh` | Steps 2 and 8 |
| `scripts/check-bytecode.sh`, `scripts/scan-flags.sh` | Step 8 |

Run scripts with `bash <skill-dir>/scripts/<name>.sh` from the project root.

## Workflow

Track progress in `MIGRATION_PLAN.md`: tick each step as it completes and record decisions there. That file is how the work resumes if the session ends.

### 1. Intake and route

1. Run `scripts/intake.sh`. It reports the build tool, wrapper versions, Java version pins, JDK pins in CI and Dockerfiles, JVM flags and frameworks.
2. Decide: library (must keep older consumers: keep its `release` target, only upgrade the build/test JDK) or application.
3. List the hops from current to target.
4. **Framework gate.** Check the framework supports the target JDK (`references/library-matrix.md`). If the hop forces a framework major (for example Spring Boot 2.x to Java 25), stop and say so: that is a separate migration.
5. Copy `assets/MIGRATION_PLAN.md` to the repo root and fill in Project, Environments, Goals, Guidelines and the step checklist.
6. **Checkpoint.** If the user is present, show the plan and wait for approval. If working unattended, state the plan in one line and continue.

### 2. Baseline

Build and test on the current JDK. Run `scripts/test-count.sh` and record the totals, the failing and skipped tests, and the coverage figure in the plan. If the baseline is red, record which tests fail; they are not the migration's to fix.

### 3. Build tooling (still on the old JDK)

Upgrade the build tool and plugins in their own commit before changing the Java version.

- **Maven:** set `maven.compiler.release` (remove `source`/`target`); upgrade compiler, surefire, failsafe, javadoc, jar/war, enforcer and jacoco to current stable; add an Enforcer `requireJavaVersion` rule.
- **Gradle:** use a toolchain only (no `sourceCompatibility`/`targetCompatibility` alongside it); upgrade the wrapper one major at a time. Gradle 9 needs JDK 17+ to run, so on the 8→11 and 11→17 hops the wrapper stays on 8.x.
- **Ant:** set `release` on `<javac>`.
- Do not introduce `-Werror`; each JDK adds lint warnings. Keep it only if it was already there.

### 4. OpenRewrite pass

Follow `references/openrewrite.md`: dry-run the hop's recipe **on the current JDK**, review the patch against the mechanical-diffs principle, drop unwanted sub-recipes, then run it and commit the output alone (`chore: OpenRewrite UpgradeToJava<N>`). If OpenRewrite is unavailable, note it in the plan and do the hop by hand.

### 5. Switch the JDK and apply the hop

Switch the build to the target JDK, then work through `references/hop-<from>-to-<to>.md`: removed APIs, library minimums, behavior changes, flags.

### 6. Build-fix loop

Build and test on the target JDK. For each failure:

1. Classify it. Check whether it also fails on the baseline JDK; if so, it is pre-existing: record it and move on.
2. Fix **one class of error per iteration**, in this order of preference: upgrade the library → change config → change code → add a targeted flag (last resort, with the reason and library issue in the plan).
3. Rebuild after every fix.
4. **Stop after 5 attempts on the same error class.** Record what was tried and the remaining error in the plan, and report it; do not keep guessing.

Use `references/troubleshooting.md` for known symptoms.

### 7. Runtime, CI and docs

Update base images (for example `eclipse-temurin:<N>-jre`), `.java-version`/`.sdkmanrc`/`.tool-versions`, `setup-java` in CI, deploy scripts and Helm charts. One full build in CI (`mvn -B verify` or `./gradlew build`); keep a JDK matrix only for libraries. Remove removed flags wherever they live.

### 8. Verify

All of these, with output recorded in the plan:

- `scripts/test-count.sh`: **same number of tests as the baseline**, no new skips or failures.
- `scripts/check-bytecode.sh <release>`: every class file has the target major version (skip for libraries that keep an older `release`).
- `scripts/scan-flags.sh <target>`: no removed or obsolete JVM flags anywhere.
- `jdeps --jdk-internals` and `jdeprscan --release <N> --for-removal` on the target JDK, including dependency JARs; compare with the baseline.
- Start the application once and grep the log for `WARNING: Illegal`, `sun.misc.Unsafe`, `restricted method`, `dynamically loaded` and `Security Manager`.
- Dependency and CVE check: report available updates (`mvn versions:display-dependency-updates` or the Gradle Versions Plugin) and run the repo's existing scanner (OWASP Dependency-Check, `osv-scanner`, or similar) before and after. No new CVEs; mention existing ones.
- Coverage within 2 points of the baseline, or the difference explained.

### 9. Deliver

- `MIGRATION_NOTES.md`: hops done, dependencies added or upgraded, flags removed or added (each with removal plan), risks, what could not be verified here, follow-ups. Keep or delete `MIGRATION_PLAN.md` according to repo convention.
- README/CONTRIBUTING: new JDK requirement.
- PR description: summary, build changes, OpenRewrite recipe and version, manual fixes, flags, a before/after table of test counts and coverage, jdeps/jdeprscan diff, unverified areas, follow-ups.
- Commit order per hop: build tooling → OpenRewrite output → manual fixes → JVM flags → CI/runtime → docs.
- For a large multi-module repo, one PR per hop or per module group. Raising library floors beyond what the hop needs is a separate, optional PR.

## Done when

- [ ] Build and tests pass on the target JDK locally and in CI, with the baseline's test count
- [ ] Class files target the right version; no removed flags; jdeps clean or exceptions documented
- [ ] No illegal-access, Unsafe, native-access or agent-loading warnings, or each is covered by a documented, targeted flag
- [ ] No new CVEs; coverage within 2 points
- [ ] Plan, notes and README updated; unverified areas (production load, real TLS endpoints, app server deployment) stated plainly
