#!/usr/bin/env bash
set -u

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT" || exit 0

echo "=== Codex Game Studio: Gap Check ==="
GAPS=0

check_path() {
  local path="$1"
  local label="$2"
  if [ ! -e "$path" ]; then
    echo "Missing: $label ($path)"
    GAPS=$((GAPS + 1))
  fi
}

check_path "AGENTS.md" "repo operating instructions"
check_path ".codex/config.toml" "Codex repo config"
check_path ".codex/hooks.json" "Codex hook routing"
check_path ".codex/skills" "Codex studio skills"
check_path ".codex/agents" "Codex studio agents"
check_path "README.md" "template README"

if [ -d ".codex/skills" ]; then
  if ! find .codex/skills -mindepth 2 -maxdepth 2 -name SKILL.md -print -quit 2>/dev/null | grep -q .; then
    echo "Missing: skill entrypoints under .codex/skills/*/SKILL.md"
    GAPS=$((GAPS + 1))
  fi
fi

if [ -d ".codex/agents" ]; then
  if ! find .codex/agents -maxdepth 1 -name '*.toml' -print -quit 2>/dev/null | grep -q .; then
    echo "Missing: agent definitions under .codex/agents/*.toml"
    GAPS=$((GAPS + 1))
  fi
fi

if [ ! -f "production/stage.txt" ] && [ ! -f "design/gdd/game-concept.md" ]; then
  echo "Project setup note: no production/stage.txt or design/gdd/game-concept.md yet."
  echo "Use the studio onboarding flow before major implementation work."
fi

if [ "$GAPS" -eq 0 ]; then
  echo "No required studio-template gaps detected."
else
  echo "Detected $GAPS required template gap(s)."
fi

echo "===================================="
exit 0
