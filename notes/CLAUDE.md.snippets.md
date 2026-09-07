# Optional CLAUDE.md snippets

Paste only what you need into a project `CLAUDE.md`. Keep CLAUDE.md factual; put long procedures in skills.

```markdown
## Skills pack

This repo may use skills from RyanLisse/claude-code-skills-pack:
- `/eli5` for onboarding into unfamiliar code
- `/deslop` before review if the diff looks AI-heavy
- `/verify-this` when claiming a fix works
- `/fix-ci`, `/get-pr-comments`, `/make-pr-easy-to-review`, `/new-branch-and-pr`, `/review-and-ship` for PR/CI flow

Prefer invoking skills with `/name` for side-effect workflows (ship, CI, PR).
```

```markdown
## PR hygiene

- One logical change set per PR
- Describe risk, test plan, and how to review generated vs core files
- Do not bypass git hooks unless explicitly requested
```
