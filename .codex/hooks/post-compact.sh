#!/usr/bin/env bash
set -u

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT" || exit 0

echo "=== Codex Game Studio: Post-Compact Reminder ==="
echo "Check git status, current branch, and production/session-state/active.md before resuming implementation claims."
echo "Branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
echo "Head: $(git rev-parse --short HEAD 2>/dev/null || echo unknown)"
echo "==============================================="
exit 0
