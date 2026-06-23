# Local Codex Overrides

This template does not require a committed `.codex/settings.json` or
`.codex/settings.local.json`. Shared project behavior lives in:

- `.codex/config.toml` for repo-local Codex feature defaults
- `.codex/hooks.json` for repo-local hook routing
- `.codex/hooks/` for shell scripts used by the hook router

Personal machine preferences belong in your global Codex configuration, usually
`~/.codex/config.toml`. Do not commit personal approvals, credentials, local
paths, API keys, or machine-specific tool paths into this template.

## Permission Modes

Codex supports different permission modes. Recommended for game dev:

### During Development (Default)
Use **normal mode** — Codex asks before running most commands. This is safest
for production code.

### During Prototyping
Use **auto-accept mode** with limited scope — faster iteration on throwaway code.
Only use this when working in `prototypes/` directory.

### During Code Review
Use **read-only** permissions — Codex can read and search but not modify files.

## Customizing Hooks Locally

Keep shared hooks in `.codex/hooks.json`. For personal experiments, use a
gitignored local file such as `.codex/hooks.local.json` only if your Codex
install explicitly supports loading it. Otherwise, test local hook commands
manually before proposing them as shared template behavior.
