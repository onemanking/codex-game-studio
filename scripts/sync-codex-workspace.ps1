param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
  [string]$UpstreamRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\work\upstreams')).Path
)

$ErrorActionPreference = 'Stop'

& (Join-Path $PSScriptRoot 'sync-upstream-skills.ps1') -RepoRoot $RepoRoot -UpstreamRoot $UpstreamRoot
& (Join-Path $PSScriptRoot 'validate-skills.ps1') -RepoRoot $RepoRoot
