# Codex Game Studio Instructions

This repository is a Codex-native game studio template. Treat `.codex/skills`
and `.codex/agents` as the active workspace surfaces.

## Operating Rules

1. Keep skills and agents workspace-local unless the user explicitly asks for a
   global install.
2. Maintain studio workflow skills directly in `.codex/skills`.
3. Regenerate only browser-library skill mirrors through
   `scripts/sync-upstream-skills.ps1`.
4. Run `scripts/validate-skills.ps1` after changing skills, agents, or sync logic.
5. Preserve source attribution for imported skills and templates in `NOTICE.md`.
6. Treat Web Browser as an engine family alongside Godot, Unity, and Unreal;
   route browser games through `web-browser-game` before picking Phaser,
   Three.js, React Three Fiber, or a hybrid stack.

## Game Development Bar

- Keep game rules separate from renderer adapters.
- Prefer proven game libraries for physics, parsing, AI, or engine behavior.
- Verify browser-game behavior in a browser before claiming runtime completion.
- Do not ship debug-first UI as player-facing product.

## Repo Boundaries

- Codex workspace surface: `.codex/`.
- Browser skill provenance: `vendor/upstream-skills/` and `sources/`.
- Local automation and validation: `scripts/`.
- Game production docs and templates: `design/`, `docs/`, `production/`, and
  `.codex/docs`.
