# Workspace Codex Surface

This directory is the active Codex surface for projects cloned from this template.

- `skills/`: workspace-local studio workflow skills and mirrored deep library
  skills loaded by Codex for the current repository.
- `agents/`: workspace-local native agent TOMLs for game-studio roles.
- `config.toml`: repo-local Codex feature defaults for this template.
- `hooks.json`: repo-local hook routing for session, commit, push, and stop checks.
- `hooks/`: shell hook scripts for context, validation, logging, and optional events.
- `docs/`: studio workflow docs and templates used by skills.
- `rules/`: domain rules for code, design, tests, narrative, and assets.
- `agent-memory/`: repo-local agent notes carried over for this template.

Web Browser is represented here as an engine family alongside Godot, Unity, and
Unreal. Browser projects route through the installed Codex Game Studio plugin
`game-studio` skill, then into Phaser, Three.js, React Three Fiber, UI, asset,
sprite, or browser QA skills as needed. Those plugin skills are intentionally
not duplicated in this repo-local `.codex/skills` directory.

Do not copy these into global `C:\Users\Rachen\.codex` for normal template use.
Clone this repository per game project and open that project folder in Codex.
