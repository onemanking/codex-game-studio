#!/usr/bin/env bash
set -u

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT" || exit 0

CHANGED="$(git status --short -- .codex/skills .codex/agents .codex/hooks .codex/hooks.json .codex/config.toml scripts/validate-skills.ps1 2>/dev/null || true)"

if [ -z "$CHANGED" ]; then
  exit 0
fi

echo "=== Codex Game Studio: Skill Change Check ==="

if [ ! -f "scripts/validate-skills.ps1" ]; then
  echo "WARN: scripts/validate-skills.ps1 is missing; cannot validate Codex skills."
  exit 0
fi

if command -v pwsh >/dev/null 2>&1; then
  pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/validate-skills.ps1 || true
elif command -v powershell >/dev/null 2>&1; then
  powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-skills.ps1 || true
elif command -v powershell.exe >/dev/null 2>&1; then
  powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts/validate-skills.ps1 || true
else
  echo "WARN: PowerShell not found; skipping Codex skill validation."
fi

exit 0
