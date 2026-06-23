#!/usr/bin/env bash
set -u

INPUT="$(cat 2>/dev/null || true)"
MESSAGE="Codex Game Studio hook notification"

if command -v jq >/dev/null 2>&1; then
  PARSED="$(printf '%s' "$INPUT" | jq -r '.message // .notification // empty' 2>/dev/null || true)"
  [ -n "$PARSED" ] && MESSAGE="$PARSED"
fi

echo "$MESSAGE"
exit 0
