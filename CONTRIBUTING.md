# Contributing to Codex Game Studio

This repository is a Codex-native game-development template. Contributions should
improve the template itself: skills, agents, docs, validation scripts, testing
framework assets, or browser-game skill imports.

## Good Contributions

- Fix a broken Codex skill, agent, doc reference, or validation rule.
- Add a missing game-development workflow skill with a clear use case.
- Improve Three.js, React Three Fiber, Phaser, or browser-game coverage.
- Tighten testing, validation, or source inventory behavior.
- Clarify docs for workspace-local Codex usage.

Do not commit game-specific outputs from projects built with this template, such
as generated GDDs, level docs, project assets, or sprint plans.

## Technical Rules

- Skills live in `.codex/skills/<name>/SKILL.md`.
- Agent definitions live in `.codex/agents/<name>.toml`.
- Studio workflow skills use normal names; browser-library skills keep useful
  namespaces such as `r3f-*`, `phaser-*`, and `threejs-*`.
- Run `scripts/validate-skills.ps1` after changing skills, agents, inventories,
  or sync scripts.
- Browser-library skill imports should be repeatable through
  `scripts/sync-upstream-skills.ps1`.

## Review Standard

Every change should be inspectable, scoped, and reversible. Skills and agents
must not silently read secrets, make undisclosed network calls, or write outside
their documented scope.

Use Conventional Commits when practical:

```text
feat: add browser-game input mapping skill
fix: correct Phaser relative skill links
docs: clarify workspace-local Codex setup
```
