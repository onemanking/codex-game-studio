#!/usr/bin/env bash
set -u

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT" || exit 0

echo "=== Codex Game Studio: Session Context ==="

BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
REMOTE="$(git remote get-url origin 2>/dev/null || true)"
HEAD_SHA="$(git rev-parse --short HEAD 2>/dev/null || true)"

[ -n "$BRANCH" ] && echo "Branch: $BRANCH"
[ -n "$HEAD_SHA" ] && echo "Head: $HEAD_SHA"
[ -n "$REMOTE" ] && echo "Remote: $REMOTE"

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  STATUS_COUNT="$(git status --short 2>/dev/null | wc -l | tr -d ' ')"
  echo "Working tree changes: $STATUS_COUNT"
fi

if [ -d ".codex/skills" ]; then
  SKILL_COUNT="$(find .codex/skills -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')"
  echo "Codex skills: $SKILL_COUNT"
fi

if [ -d ".codex/agents" ]; then
  AGENT_COUNT="$(find .codex/agents -maxdepth 1 -type f -name '*.toml' 2>/dev/null | wc -l | tr -d ' ')"
  echo "Codex agents: $AGENT_COUNT"
fi

if [ -f "production/stage.txt" ]; then
  echo "Project stage: $(tr -d '\r\n' < production/stage.txt)"
fi

echo ""
echo "Recent commits:"
git log --oneline -5 2>/dev/null | sed 's/^/  /' || true

STATE_FILE="production/session-state/active.md"
if [ -f "$STATE_FILE" ]; then
  echo ""
  echo "Active session state:"
  sed -n '1,40p' "$STATE_FILE" 2>/dev/null | sed 's/^/  /' || true
fi

echo "=========================================="
exit 0
