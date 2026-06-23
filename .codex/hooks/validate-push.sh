#!/usr/bin/env bash
set -u

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT" || exit 0

INPUT="$(cat 2>/dev/null || true)"

extract_command() {
  if command -v jq >/dev/null 2>&1; then
    printf '%s' "$INPUT" | jq -r '.tool_input.command // .command // empty' 2>/dev/null
    return 0
  fi

  printf '%s' "$INPUT" | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1
}

COMMAND_TEXT="$(extract_command)"

case "$COMMAND_TEXT" in
  git\ push*|*"; git push"*|*"&& git push"*|*" git push "*)
    ;;
  *)
    exit 0
    ;;
esac

echo "=== Codex Game Studio: Push Check ==="

BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
REMOTE="$(git remote get-url origin 2>/dev/null || true)"

if [ -z "$REMOTE" ]; then
  echo "WARN: no origin remote configured."
fi

if [ "$BRANCH" = "main" ] || [ "$BRANCH" = "master" ]; then
  echo "WARN: pushing directly from $BRANCH. This template allows it, but release branches are safer for large changes."
fi

UNTRACKED_SENSITIVE="$(git status --short 2>/dev/null | awk '{print $2}' | grep -Ei '(^|/)(\.env($|\.)|.*\.(pem|key|p12|pfx|jks|keystore)$|credentials\.json$|secrets\.json$|id_rsa|id_dsa|\.npmrc$|\.pypirc$|\.netrc$)' || true)"
if [ -n "$UNTRACKED_SENSITIVE" ]; then
  echo "WARN: sensitive-looking local files exist. They are not necessarily staged, but check before pushing:"
  printf '%s\n' "$UNTRACKED_SENSITIVE" | sed 's/^/  /'
fi

echo "Push check passed."
exit 0
