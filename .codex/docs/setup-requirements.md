# Setup Requirements

This template requires a few tools to be installed for full functionality.
All hooks fail gracefully if tools are missing — nothing will break, but
you'll lose validation features.

## Required

| Tool | Purpose | Install |
| ---- | ---- | ---- |
| **Git** | Version control, branch management | [git-scm.com](https://git-scm.com/) |
| **Codex** | AI agent CLI | `npm install -g @openai/codex` |

## Recommended

| Tool | Used By | Purpose | Install |
| ---- | ---- | ---- | ---- |
| **jq** | Hooks | JSON parsing for hook payloads when available | See below |
| **Python 3** | Hooks (2 of 12) | JSON validation for data files | [python.org](https://www.python.org/) |
| **PowerShell** | Hook launcher | Finds Git Bash and forwards hook payloads | Built into Windows |
| **Bash** | Hook scripts | Shell script execution | Included with Git for Windows |

### Installing jq

**Windows** (any of these):
```
winget install jqlang.jq
choco install jq
scoop install jq
```

**macOS**:
```
brew install jq
```

**Linux**:
```
sudo apt install jq     # Debian/Ubuntu
sudo dnf install jq     # Fedora
sudo pacman -S jq       # Arch
```

## Platform Notes

### Windows
- The hooks in `.codex/hooks.json` call `.codex/hooks/run-hook.ps1`.
  The launcher finds Git Bash from your Git for Windows installation, even when
  `bash` in PATH points to WSL.
- Ensure Git for Windows itself is on PATH so the launcher can locate the Git
  installation.
- If Git Bash is installed in a custom location, set `GIT_BASH` to the full
  path of `bash.exe`.

### macOS / Linux
- Bash is available natively
- Install `jq` via your package manager for full hook support

## Verifying Your Setup

Run these commands to check prerequisites:

```bash
git --version          # Should show git version
bash --version         # Should show bash version
jq --version           # Should show jq version (optional)
python3 --version      # Should show python version (optional)
```

## What Happens Without Optional Tools

| Missing Tool | Effect |
| ---- | ---- |
| **jq** | Hook payload parsing falls back to lightweight shell parsing. Most checks still run, but complex payloads may not be recognized. |
| **Python 3** | JSON data file validation in commit and asset hooks is skipped. Invalid JSON can be committed without warning. |
| **Both** | Hooks still execute without error where possible. Secret filename checks and staged diff checks still run, but JSON payload parsing and JSON-file validation are reduced. |

## Recommended IDE

Codex works with any editor, but the template is optimized for:
- **VS Code** with the Codex extension
- **Cursor** (Codex compatible)
- Terminal-based Codex CLI
