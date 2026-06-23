# Codex Game Studio

Codex Game Studio is a workspace-local Codex template for building games with a
full studio workflow, first-class Web Browser game support, and Codex-native
agents.

Clone this repository as the starting point for each game project, then open that
project folder in Codex. The active runtime surfaces are the repo-local
`.codex/skills` and `.codex/agents` directories.

## What Is Included

- 140 Codex skills under `.codex/skills`.
- 54 Codex-native agent TOMLs under `.codex/agents`.
- Studio workflow docs, rules, templates, and agent memory under `.codex/`.
- Repo-local Codex hook routing in `.codex/hooks.json` and hook scripts in
  `.codex/hooks/`.
- Engine-family coverage for Godot, Unity, Unreal, and Web Browser.
- Web Browser skills for Phaser, Three.js, React Three Fiber, hybrid browser
  games, UI/HUD, assets, sprites, and browser playtesting.
- A reusable skill testing framework in `Codex Skill Testing Framework/`.
- Repeatable sync and validation scripts in `scripts/`.
- Source inventories in `sources/`.

## Skill Sources

- Studio workflow skills: 73 Codex-native skills with normal names such as
  `prototype`, `test-setup`, `skill-test`, and `team-ui`.
- Browser game studio skills: 9 Codex-native skills such as
  `web-browser-game`, `web-game-foundations`, `phaser-2d-game`,
  `three-webgl-game`, `react-three-fiber-game`, and `game-playtest`.
- React Three Fiber skills: 11 skills using `r3f-*` names.
- Phaser official skills: 28 skills using `phaser-*` names.
- Three.js game skills: 19 skills using the upstream `threejs-*` names.

The studio workflow and browser game studio skills are maintained directly in
this template. The browser-library mirrors can be regenerated from upstream
clones with the sync script.

## Validate

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-skills.ps1
```

Expected result:

```text
Validated 140 Codex skills and 54 Codex agents
```

## Regenerate Browser Skills

The source clones are expected at `..\work\upstreams` when working from this local
workspace.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\sync-codex-workspace.ps1
```

This regenerates the R3F, Phaser, and Three.js skill mirrors, then validates the
workspace. It does not regenerate agents or repo-local Web Browser family
routing.

## Template Usage

1. Clone this repository for a new game project.
2. Open the cloned project folder in Codex.
3. Keep project-specific skill and agent edits inside the cloned repo.
4. Use global skill installation only when you explicitly want machine-wide reuse.

No legacy assistant-specific workspace directory or instruction file is required
for this template.
