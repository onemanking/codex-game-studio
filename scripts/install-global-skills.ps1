param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
  [string]$Destination = (Join-Path $HOME '.codex\skills'),
  [switch]$WhatIf
)

$ErrorActionPreference = 'Stop'
Write-Host "Optional global install path. Normal template use should rely on workspace-local .codex/skills."
& (Join-Path $PSScriptRoot 'validate-skills.ps1') -RepoRoot $RepoRoot

$skillsRoot = Join-Path $RepoRoot '.codex\skills'
if (-not (Test-Path -LiteralPath $Destination)) {
  if ($WhatIf) {
    Write-Host "Would create destination: $Destination"
  } else {
    New-Item -ItemType Directory -Force -Path $Destination | Out-Null
  }
}

foreach ($skill in Get-ChildItem -LiteralPath $skillsRoot -Directory | Sort-Object Name) {
  $target = Join-Path $Destination $skill.Name
  if ($WhatIf) {
    Write-Host "Would sync $($skill.FullName) -> $target"
    continue
  }

  if (Test-Path -LiteralPath $target) {
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $backup = "$target.backup-$stamp"
    Move-Item -LiteralPath $target -Destination $backup
    Write-Host "Backed up existing skill: $backup"
  }

  Copy-Item -LiteralPath $skill.FullName -Destination $target -Recurse
  Write-Host "Installed skill: $($skill.Name)"
}

if ($WhatIf) {
  Write-Host "Dry run complete. No skills were installed."
} else {
  Write-Host "Install complete. Restart Codex to reload skill metadata."
}
