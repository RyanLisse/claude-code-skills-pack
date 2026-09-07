# Archify + Claude Code

Full interactive HTML delivery needs the upstream Archify engine (Node.js), not only this pack’s thin skill.

## Option 1 — Recommended with this pack

Keep this pack’s `skills/archify/SKILL.md` under Claude Code skills, and point at a clone of the engine:

```bash
mkdir -p ~/.claude/skills
cp -R /path/to/claude-code-skills-pack/skills/archify ~/.claude/skills/

git clone --depth 1 https://github.com/tt-a1i/archify.git ~/src/archify
echo 'export ARCHIFY_HOME=~/src/archify/archify' >> ~/.bashrc   # or ~/.zshrc
export ARCHIFY_HOME=~/src/archify/archify
node "$ARCHIFY_HOME/bin/archify.mjs" doctor
```

In Claude Code: `/archify Map Browser -> API -> Redis -> Postgres`.

## Option 2 — Full upstream skill tree only

```bash
git clone --depth 1 https://github.com/tt-a1i/archify.git /tmp/archify-src
mkdir -p ~/.claude/skills
rm -rf ~/.claude/skills/archify
cp -R /tmp/archify-src/archify ~/.claude/skills/archify
node ~/.claude/skills/archify/bin/archify.mjs doctor
```

Do **not** mix two different trees under the same `archify` skill name.

Optional skills CLI / agent switcher:

```bash
npx skills add tt-a1i/archify -g
# https://tt-a1i.github.io/archify/start.html?agent=claude-code&type=architecture
```

## Env

- `ARCHIFY_HOME` — root containing `bin/archify.mjs` (Option 1)
- `ARCHIFY_UPDATE_CHECK_DISABLED=1` — disable upstream’s optional update reminder networking (see upstream README)

## Attribution

MIT — https://github.com/tt-a1i/archify — see repo `ATTRIBUTION.md`.
