#!/usr/bin/env bash
set -u

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT" || exit 0

echo "=== Codex Game Studio: Asset Check ==="

if [ ! -d "assets" ]; then
  echo "No assets directory found; skipping asset checks."
  exit 0
fi

WARNINGS=0

while IFS= read -r file; do
  [ -z "$file" ] && continue
  [ -f "$file" ] || continue

  case "$file" in
    *.json)
      if command -v python >/dev/null 2>&1; then
        if ! python -m json.tool "$file" >/dev/null 2>&1; then
          echo "WARN: invalid asset JSON: $file"
          WARNINGS=$((WARNINGS + 1))
        fi
      elif command -v python3 >/dev/null 2>&1; then
        if ! python3 -m json.tool "$file" >/dev/null 2>&1; then
          echo "WARN: invalid asset JSON: $file"
          WARNINGS=$((WARNINGS + 1))
        fi
      fi
      ;;
  esac

  if [ -f "$file" ]; then
    SIZE_BYTES="$(wc -c < "$file" 2>/dev/null || echo 0)"
    if [ "${SIZE_BYTES:-0}" -gt 26214400 ]; then
      echo "WARN: large asset over 25MB: $file"
      WARNINGS=$((WARNINGS + 1))
    fi
  fi
done <<EOF
$(find assets -type f 2>/dev/null)
EOF

if [ "$WARNINGS" -eq 0 ]; then
  echo "Asset check passed."
else
  echo "Asset check completed with $WARNINGS warning(s)."
fi

exit 0
