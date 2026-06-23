# Active Hooks

Hooks are configured in `.codex/hooks.json`. On Windows, `hooks.json` calls
`.codex/hooks/run-hook.ps1`, which finds Git Bash and forwards stdin to the
target `.sh` script. The repo also includes optional helper scripts under
`.codex/hooks/` that can be wired locally when your Codex runtime exposes the
matching event.

## Default Wired Hooks

| Hook | Event | Trigger | Action |
| ---- | ----- | ------- | ------ |
| `session-start.sh` | SessionStart | Session begins | Prints branch, HEAD, remote, working tree count, skill/agent counts, recent commits, and `active.md` preview |
| `detect-gaps.sh` | SessionStart | Session begins | Detects missing template surfaces and early project setup gaps |
| `validate-commit.sh` | PreToolUse | `git commit` commands | Blocks likely secrets, sensitive filenames, invalid JSON, staged diff issues, and broken Codex skill validation |
| `validate-push.sh` | PreToolUse | `git push` commands | Warns on direct pushes from `main`/`master` and sensitive-looking local files |
| `validate-assets.sh` | Stop | Session ends | Warns about invalid asset JSON and assets over 25 MB |
| `validate-skill-change.sh` | Stop | Session ends | Runs `scripts/validate-skills.ps1` when Codex skills, agents, hooks, config, or validation scripts changed |
| `session-stop.sh` | Stop | Session ends | Writes a gitignored session summary under `production/session-logs/` |

## Optional Helper Scripts

| Hook | Intended Event | Action |
| ---- | -------------- | ------ |
| `pre-compact.sh` | PreCompact | Prints branch, HEAD, changed files, and `active.md` before context compaction |
| `post-compact.sh` | PostCompact | Reminds Codex to restore from files after context compaction |
| `notify.sh` | Notification | Prints notification text from the hook payload |
| `log-agent.sh` | SubagentStart | Appends a bounded subagent start payload to the gitignored audit log |
| `log-agent-stop.sh` | SubagentStop | Appends a bounded subagent stop payload to the gitignored audit log |

Hook implementation directory: `.codex/hooks/`
Hook input schema documentation: `.codex/docs/hooks-reference/hook-input-schemas.md`
