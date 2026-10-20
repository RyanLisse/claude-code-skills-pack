<!--
Adapted from HumanLayer, `.claude/commands/research_codebase_generic.md` in
https://github.com/humanlayer/humanlayer at commit 99abe673498cf8bdcd5f989aebe9406a27185b3b
Copyright (c) 2024, humanlayer Authors. Licensed under the Apache License, Version 2.0 (https://www.apache.org/licenses/LICENSE-2.0; full text in LICENSES/Apache-2.0.txt in the pack repo).
Modified for this pack: output path moved to docs/research/; thoughts/, Linear and custom-agent references removed;
uses Claude Code's built-in subagents only; research is limited to describing current code (no proposals);
commands must be checked against their source files; shortened.
-->

# Research the codebase

Answer the research questions by running parallel subagents and combining what they find. The output describes the code as it is today. It does not propose changes.

## Steps

1. **Read the named files first.**
   - Read `docs/intent.md`, `spec.md` (if present) and any file the user mentions, in full, in the main context.
   - Do this before spawning subagents, so you can split the work well.

2. **Break the question down.**
   - Turn the intent into 3–6 concrete research questions.
   - Note which directories, components and patterns each one touches.
   - Track them with the todo list.

3. **Spawn parallel subagents.**
   - Use Claude Code's built-in subagents (the Agent tool, formerly Task; for example the Explore agent). No plugins or MCP servers.
   - One focused question per subagent. Tell it which directories to search, that it is read-only, and to return `path:line` references.
   - Find what exists first, then read the most relevant hits in depth.
   - Ask for examples and usage patterns, not just definitions.

4. **Wait for all subagents, then combine.**
   - Wait for every subagent before writing.
   - Treat live code as the source of truth. Check any surprising claim yourself.
   - Connect findings across components.
   - Answer each question with concrete evidence and `path:line` references.

5. **Collect the commands.**
   - Find the real build, test, single-test, lint and typecheck commands.
   - Record where each one is defined: `package.json` scripts, `Makefile`, `justfile`, `pyproject.toml`, CI workflow steps.

6. **Write the research file.**
   - Path: `docs/research/YYYY-MM-DD-<slug>.md` (or the repo's existing research location).
   - Use `assets/research.md`. Fill in date, commit (`git rev-parse --short HEAD`) and branch. No placeholder values.
   - Sections: questions, findings per question, code references, conventions to follow, commands, open questions.

7. **Optional permalinks.** If the commit is pushed and `gh` is signed in, you may turn `path:line` references into GitHub permalinks (`https://github.com/<owner>/<repo>/blob/<commit>/<file>#L<line>`). Skip this otherwise.

8. **Present and follow up.**
   - Give the user a short summary with the key references.
   - For follow-up questions, append a `## Follow-up (<date>)` section to the same file.

## Notes

- Always run fresh research. An older research file is context, not proof.
- Keep the main thread on synthesis; let subagents do the wide reading.
- The file must stand alone: someone reading only it should understand the findings.
- Describe, do not judge. "`export.ts:40` builds rows in memory" is a finding. "This should stream" belongs in the plan.
