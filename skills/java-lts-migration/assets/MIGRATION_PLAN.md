# Java migration plan: <current> → <target>

Living checkpoint for this migration. Update it after every step; a new session resumes from here.

## Project

- Build tool and wrapper: <maven 3.9.x / gradle 8.x wrapper / ant>
- Modules: <list or "single module">
- Packaging and runtime: <fat JAR / WAR on Tomcat 9 / container base image>
- Library or application: <application | library (keeps release N for consumers)>
- Frameworks: <Spring Boot x.y, Lombok x.y, Mockito x.y, …>

## Environments

- Current JDK: <vendor + version, where it is pinned>
- Target JDK: <vendor + version>
- Hops: <e.g. 8 → 11 → 17>

## Goals

- Build and tests green on <target> with the baseline test count
- Required library floors: <from references/library-matrix.md>

## Guidelines

- Repo conventions: <branch naming, commit style, PR template>
- Forbidden: refactors, framework majors, disabling tests, broad --add-opens, <org-specific>
- Org policy file: <path or "none">

## Baseline (current JDK)

- Command: `<mvn -B verify | ./gradlew build>`
- Tests: tests=<N> failures=<F> errors=<E> skipped=<S>
- Pre-existing failures: <list or "none">
- Coverage: <x %>
- jdeps/jdeprscan findings: <summary>

## Steps

- [ ] 1. Intake and route
- [ ] 2. Baseline recorded
- [ ] 3. Build tooling upgraded (old JDK)
- [ ] 4. OpenRewrite <recipe> run and reviewed
- [ ] 5. JDK switched, hop reference applied
- [ ] 6. Build-fix loop green
- [ ] 7. Runtime, CI, docs updated
- [ ] 8. Verification recorded below
- [ ] 9. PR opened

## Decisions and deviations

| # | Decision | Why | Removal plan / owner |
|---|---|---|---|
| 1 | | | |

## Build-fix log

| Error class | Attempts | Fix | Status |
|---|---|---|---|

## Verification (target JDK)

- Tests: tests=<N> failures=<F> errors=<E> skipped=<S> (baseline: <…>)
- Bytecode: <output of check-bytecode.sh>
- Flags: <output of scan-flags.sh>
- jdeps/jdeprscan diff: <…>
- Runtime warnings: <none | list>
- CVEs before/after: <…>
- Coverage: <x %> (baseline <y %>)
- Not verified here: <…>
