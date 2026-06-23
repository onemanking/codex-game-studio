#!/usr/bin/env bash
set -u

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT" || exit 0

echo "=== Codex Game Studio: Pre-Compact State ==="
echo "Branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
echo "Head: $(git rev-parse --short HEAD 2>/dev/null || echo unknown)"
echo ""
echo "Changed files:"
git status --short 2>/dev/null | sed 's/^/  /' || true

STATE_FILE="production/session-state/active.md"
if [ -f "$STATE_FILE" ]; then
  echo ""
  echo "Active session state:"
  sed -n '1,80p' "$STATE_FILE" 2>/dev/null | sed 's/^/  /' || true
fi

echo "=========================================="
exit 0
