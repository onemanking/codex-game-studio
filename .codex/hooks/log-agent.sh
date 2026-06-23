#!/usr/bin/env bash
set -u

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT" || exit 0

mkdir -p production/session-logs
STAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
LOG_FILE="production/session-logs/agent-events.log"

{
  echo "[$STAMP] agent-start"
  head -c 4000 2>/dev/null || true
  echo ""
} >> "$LOG_FILE"

exit 0
