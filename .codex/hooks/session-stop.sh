#!/usr/bin/env bash
set -u

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT" || exit 0

mkdir -p production/session-logs

STAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
DAY="$(date -u +"%Y%m%d")"
BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
HEAD_SHA="$(git rev-parse --short HEAD 2>/dev/null || true)"
STATUS_COUNT="$(git status --short 2>/dev/null | wc -l | tr -d ' ')"
LOG_FILE="production/session-logs/session-$DAY.log"

{
  echo "[$STAMP] branch=${BRANCH:-unknown} head=${HEAD_SHA:-unknown} changes=$STATUS_COUNT"
  git status --short 2>/dev/null | sed 's/^/  /'
  echo ""
} >> "$LOG_FILE"

echo "Recorded session summary in $LOG_FILE"
exit 0
