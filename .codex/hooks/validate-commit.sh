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
  git\ commit*|*"; git commit"*|*"&& git commit"*|*" git commit "*)
    ;;
  *)
    exit 0
    ;;
esac

echo "=== Codex Game Studio: Commit Validation ==="

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not inside a git work tree; skipping commit validation."
  exit 0
fi

STAGED_FILES="$(git diff --cached --name-only --diff-filter=ACMR 2>/dev/null || true)"

if [ -z "$STAGED_FILES" ]; then
  echo "No staged files detected."
  exit 0
fi

BLOCKED=0

is_sensitive_filename() {
  local lower
  lower="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"
  case "$lower" in
    .env.example|*/.env.example|.env.sample|*/.env.sample)
      return 1
      ;;
    .env|.env.*|*/.env|*/.env.*|*.pem|*.key|*.p12|*.pfx|*.jks|*.keystore|*/credentials.json|*/secrets.json|*/id_rsa|*/id_dsa|*/.npmrc|*/.pypirc|*/.netrc)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

SECRET_RE='(sk-[A-Za-z0-9]{20,}|gh[pousr]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]+|AKIA[0-9A-Z]{16}|AIza[0-9A-Za-z_-]{35}|xox[baprs]-[A-Za-z0-9-]{10,}|BEGIN (RSA|DSA|EC|OPENSSH|PRIVATE) KEY|Bearer[[:space:]]+[A-Za-z0-9._-]{20,})'

while IFS= read -r file; do
  [ -z "$file" ] && continue

  if is_sensitive_filename "$file"; then
    echo "BLOCKED: sensitive filename staged: $file"
    BLOCKED=1
    continue
  fi

  [ -f "$file" ] || continue

  if grep -I -nE "$SECRET_RE" "$file" >/tmp/codex-hook-secret-match.txt 2>/dev/null; then
    echo "BLOCKED: possible secret detected in staged file: $file"
    sed -n '1,3p' /tmp/codex-hook-secret-match.txt | sed 's/^/  /'
    BLOCKED=1
  fi

  case "$file" in
    *.json)
      if command -v python >/dev/null 2>&1; then
        if ! python -m json.tool "$file" >/dev/null 2>&1; then
          echo "BLOCKED: invalid JSON: $file"
          BLOCKED=1
        fi
      elif command -v python3 >/dev/null 2>&1; then
        if ! python3 -m json.tool "$file" >/dev/null 2>&1; then
          echo "BLOCKED: invalid JSON: $file"
          BLOCKED=1
        fi
      fi
      ;;
  esac
done <<EOF
$STAGED_FILES
EOF

if ! git diff --cached --check >/tmp/codex-hook-diff-check.txt 2>&1; then
  echo "BLOCKED: staged diff has whitespace or conflict-marker issues."
  sed -n '1,20p' /tmp/codex-hook-diff-check.txt | sed 's/^/  /'
  BLOCKED=1
fi

NEEDS_CODEX_VALIDATION=0
while IFS= read -r file; do
  case "$file" in
    .codex/skills/*|.codex/agents/*|.codex/hooks/*|.codex/hooks.json|.codex/config.toml|scripts/validate-skills.ps1)
      NEEDS_CODEX_VALIDATION=1
      ;;
  esac
done <<EOF
$STAGED_FILES
EOF

run_codex_validation() {
  if [ ! -f "scripts/validate-skills.ps1" ]; then
    echo "WARN: scripts/validate-skills.ps1 is missing; skipping Codex skill validation."
    return 0
  fi

  if command -v pwsh >/dev/null 2>&1; then
    pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/validate-skills.ps1
  elif command -v powershell >/dev/null 2>&1; then
    powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-skills.ps1
  elif command -v powershell.exe >/dev/null 2>&1; then
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts/validate-skills.ps1
  else
    echo "WARN: PowerShell not found; skipping Codex skill validation."
    return 0
  fi
}

if [ "$NEEDS_CODEX_VALIDATION" -eq 1 ]; then
  echo "Running Codex studio skill validation..."
  if ! run_codex_validation; then
    echo "BLOCKED: Codex studio validation failed."
    BLOCKED=1
  fi
fi

if [ "$BLOCKED" -ne 0 ]; then
  echo "Commit validation failed."
  exit 2
fi

echo "Commit validation passed."
exit 0
