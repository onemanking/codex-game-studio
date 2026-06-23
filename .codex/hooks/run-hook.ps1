param(
  [Parameter(Mandatory = $true)]
  [string]$Hook
)

$ErrorActionPreference = "Stop"

function Get-RepoRoot {
  $root = (& git rev-parse --show-toplevel 2>$null)
  if ($LASTEXITCODE -eq 0 -and $root) {
    return $root.Trim()
  }
  return (Get-Location).Path
}

function Get-GitBash {
  $candidates = New-Object System.Collections.Generic.List[string]

  if ($env:GIT_BASH) {
    $candidates.Add($env:GIT_BASH)
  }

  $gitExecPath = (& git --exec-path 2>$null)
  if ($LASTEXITCODE -eq 0 -and $gitExecPath) {
    $libexec = Split-Path -Parent $gitExecPath.Trim()
    $mingw = Split-Path -Parent $libexec
    $gitRoot = Split-Path -Parent $mingw
    $candidates.Add((Join-Path $gitRoot "bin\bash.exe"))
    $candidates.Add((Join-Path $gitRoot "usr\bin\bash.exe"))
  }

  $candidates.Add("C:\Program Files\Git\bin\bash.exe")
  $candidates.Add("C:\Program Files\Git\usr\bin\bash.exe")
  $candidates.Add("C:\Program Files (x86)\Git\bin\bash.exe")
  $candidates.Add("C:\Program Files (x86)\Git\usr\bin\bash.exe")

  $pathBash = Get-Command bash.exe -ErrorAction SilentlyContinue
  if ($pathBash -and
      $pathBash.Source -notlike "*\Windows\System32\bash.exe" -and
      $pathBash.Source -notlike "*\WindowsApps\bash.exe") {
    $candidates.Add($pathBash.Source)
  }

  foreach ($candidate in $candidates) {
    if ($candidate -and (Test-Path -LiteralPath $candidate)) {
      return $candidate
    }
  }

  throw "Git Bash was not found. Install Git for Windows or set GIT_BASH to bash.exe."
}

$repoRoot = Get-RepoRoot
$hookPath = Join-Path $repoRoot (Join-Path ".codex\hooks" $Hook)

if (-not (Test-Path -LiteralPath $hookPath)) {
  throw "Hook script not found: $hookPath"
}

$bash = Get-GitBash
$stdin = [Console]::In.ReadToEnd()
$hookArg = $hookPath -replace "\\", "/"

if ($stdin.Length -gt 0) {
  $stdin | & $bash $hookArg
} else {
  & $bash $hookArg
}

exit $LASTEXITCODE
