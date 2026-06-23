# Codex Adaptation

This folder documents the Codex-native shape of the template.

## Main Surfaces

- `.codex/skills/`: Codex-loadable studio, R3F, Phaser, and Three.js skills.
- `.codex/agents/`: Codex-native agent TOMLs for studio roles.
- `.codex/docs/` and `.codex/rules/`: workflow docs, templates, and domain rules.
- `Codex Skill Testing Framework/`: reusable skill and agent evaluation assets.
- `vendor/upstream-skills/`: source copies for browser-library skill imports.
- `sources/`: generated and static inventories.
- `scripts/sync-upstream-skills.ps1`: repeatable browser-skill importer.
- `scripts/sync-codex-workspace.ps1`: runs browser-skill sync and validation.
- `scripts/validate-skills.ps1`: validates Codex skills and agents.

## Naming

Studio workflow skills use normal names such as `prototype`, `test-setup`, and
`team-ui`. Phaser skills keep a `phaser-` prefix to avoid broad trigger
collisions. R3F and Three.js skills already carry useful namespaces.
