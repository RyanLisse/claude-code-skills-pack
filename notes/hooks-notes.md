# Hooks notes (optional)

Claude Code supports [hooks](https://code.claude.com/docs/en/hooks) for deterministic automation around tool events. This pack does **not** ship mandatory hooks.

Ideas if you want to add your own later:

- After `git commit` / stop hooks: remind to run `/deslop` if the branch touches many AI-authored files
- Before push: suggest `/fix-ci` when `gh pr checks` shows failures
- Prefer skills with `disable-model-invocation: true` for ship/CI so Claude does not auto-run them

Do not put secrets in hook scripts. Keep hooks project-local under `.claude/` and review them before enabling in shared repos.
