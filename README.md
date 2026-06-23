# Codex Game Studio

Codex Game Studio is a workspace-local Codex template for building games with a
full studio workflow, first-class Web Browser game support, and Codex-native
agents.

Clone this repository as the starting point for each game project, then open that
project folder in Codex. The active template surfaces are the repo-local
`.codex/skills` and `.codex/agents` directories, with browser-game routing
provided by the installed Codex Game Studio plugin.

## What Is Included

- 131 Codex skills under `.codex/skills`.
- 54 Codex-native agent TOMLs under `.codex/agents`.
- Studio workflow docs, rules, templates, and agent memory under `.codex/`.
- Repo-local Codex hook routing in `.codex/hooks.json` and hook scripts in
  `.codex/hooks/`.
- Engine-family coverage for Godot, Unity, Unreal, and Web Browser.
- Web Browser specialist agents plus mirrored Phaser, Three.js, and React Three
  Fiber library skills. Browser umbrella skills come from the Codex Game Studio
  plugin and are not duplicated in this repository.
- A reusable skill testing framework in `Codex Skill Testing Framework/`.
- Repeatable sync and validation scripts in `scripts/`.
- Source inventories in `sources/`.

## Skill Sources

- Studio workflow skills: 73 Codex-native skills with normal names such as
  `prototype`, `test-setup`, `skill-test`, and `team-ui`.
- React Three Fiber skills: 11 skills using `r3f-*` names.
- Phaser official skills: 28 skills using `phaser-*` names.
- Three.js game skills: 19 skills using the upstream `threejs-*` names.

The studio workflow skills are maintained directly in this template. Browser
entrypoint skills such as `game-studio`, `web-game-foundations`,
`phaser-2d-game`, `three-webgl-game`, `react-three-fiber-game`,
`game-ui-frontend`, `web-3d-asset-pipeline`, `sprite-pipeline`, and
`game-playtest` are supplied by the installed Codex Game Studio plugin, so this
repository does not keep local copies of them. The browser-library mirrors can
be regenerated from upstream clones with the sync script.

## Validate

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-skills.ps1
```

Expected result:

```text
Validated 131 Codex skills and 54 Codex agents
```

## Regenerate Browser Skills

The source clones are expected at `..\work\upstreams` when working from this local
workspace.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\sync-codex-workspace.ps1
```

This regenerates the R3F, Phaser, and Three.js skill mirrors, then validates the
workspace. It does not regenerate agents or duplicate browser-game plugin
skills.

## How To Use This Template

Use this repository as a per-project Codex workspace template. Do not copy these
skills or agents into your global `~/.codex` folder for normal project use.
Codex should be opened from the game project root so it can read the repo-local
`.codex/` directory.

### New Game Project

Clone this template as the starting folder for a new game:

```powershell
cd E:\YourGameProjects
git clone https://github.com/onemanking/codex-game-studio.git my-new-game
cd my-new-game
```

If this clone will become your own game repository, point `origin` at your own
GitHub repo before pushing project work:

```powershell
git remote set-url origin https://github.com/<your-user>/<your-game-repo>.git
```

Then open `my-new-game` in Codex. The active Codex surfaces are:

```text
AGENTS.md
.codex/config.toml
.codex/hooks.json
.codex/agents/
.codex/skills/
```

Validate the workspace after cloning:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-skills.ps1
```

Start the studio flow in Codex with:

```text
/start
```

For browser-game projects, route through the installed Codex Game Studio plugin
first, then use this template's agents and mirrored deep library skills as
needed:

```text
/game-studio
/web-game-foundations
```

### Existing Game Project

If you already have a game repository, copy the Codex workspace surface into
that project:

```powershell
Copy-Item -Recurse E:\CodexUtility\codex-game-studio\.codex E:\YourExistingGame\.codex
Copy-Item -Recurse E:\CodexUtility\codex-game-studio\scripts E:\YourExistingGame\scripts
Copy-Item E:\CodexUtility\codex-game-studio\AGENTS.md E:\YourExistingGame\AGENTS.md
```

If the existing project already has `AGENTS.md`, merge the instructions instead
of overwriting the file. Keep any project-specific rules that already describe
the real game codebase. If the existing project already has a `scripts/`
directory, copy or merge at least `scripts/validate-skills.ps1` because the
repo-local hooks use it for Codex skill and agent validation.

After copying, open `E:\YourExistingGame` in Codex and run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-skills.ps1
```

### What Codex Actually Uses

Codex uses the repo-local `.codex/skills`, `.codex/agents`, hooks, and
`AGENTS.md` from the project folder you open, plus installed Codex plugin skills.
The `vendor/upstream-skills` directory is not the active runtime surface; it is
kept as a source snapshot for traceability and future regeneration of mirrored
browser-library skills.

No legacy assistant-specific workspace directory or instruction file is required
for this template.
