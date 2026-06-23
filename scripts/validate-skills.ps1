param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'
$skillsRoot = Join-Path $RepoRoot '.codex\skills'
$failures = New-Object System.Collections.Generic.List[string]

function Get-PortableRelativePath {
  param([string]$FromPath, [string]$ToPath)
  $fromFull = [System.IO.Path]::GetFullPath($FromPath)
  $toFull = [System.IO.Path]::GetFullPath($ToPath)
  if ((Test-Path -LiteralPath $fromFull -PathType Container) -and -not $fromFull.EndsWith('\')) {
    $fromFull += '\'
  }
  if ((Test-Path -LiteralPath $toFull -PathType Container) -and -not $toFull.EndsWith('\')) {
    $toFull += '\'
  }
  $fromUri = [System.Uri]::new($fromFull)
  $toUri = [System.Uri]::new($toFull)
  return [System.Uri]::UnescapeDataString($fromUri.MakeRelativeUri($toUri).ToString()).TrimEnd('/', '\').Replace('/', '\')
}

if (-not (Test-Path -LiteralPath $skillsRoot)) {
  throw "Missing skills directory: $skillsRoot"
}

$skillDirs = @(Get-ChildItem -LiteralPath $skillsRoot -Directory | Sort-Object Name)
if ($skillDirs.Count -eq 0) {
  throw "No skills found in $skillsRoot"
}

$names = New-Object System.Collections.Generic.HashSet[string]

foreach ($dir in $skillDirs) {
  $skillFile = Join-Path $dir.FullName 'SKILL.md'
  if (-not (Test-Path -LiteralPath $skillFile)) {
    $failures.Add("Missing SKILL.md: $($dir.FullName)")
    continue
  }

  $text = Get-Content -LiteralPath $skillFile -Raw -Encoding UTF8
  $frontmatterMatch = [regex]::Match($text, '(?s)^---\s*\r?\n(.+?)\r?\n---')
  if (-not $frontmatterMatch.Success) {
    $failures.Add("Missing frontmatter: $skillFile")
    continue
  }

  $frontmatter = $frontmatterMatch.Groups[1].Value
  $nameMatch = [regex]::Match($frontmatter, '(?m)^name:\s*([a-z0-9-]+)\s*$')
  $descriptionMatch = [regex]::Match($frontmatter, '(?m)^description:\s*(.+)\s*$')
  $blockDescriptionMatch = [regex]::Match($frontmatter, '(?m)^description:\s*[>|]-?\s*$')

  if (-not $nameMatch.Success) {
    $failures.Add("Missing or invalid name: $skillFile")
    continue
  }

  $name = $nameMatch.Groups[1].Value
  if ($name -ne $dir.Name) {
    $failures.Add("Name '$name' does not match folder '$($dir.Name)': $skillFile")
  }

  if (-not $names.Add($name)) {
    $failures.Add("Duplicate skill name: $name")
  }

  if (-not $descriptionMatch.Success -and -not $blockDescriptionMatch.Success) {
    $failures.Add("Missing description: $skillFile")
  }
}

foreach ($markdownFile in Get-ChildItem -LiteralPath $skillsRoot -Recurse -File -Include '*.md') {
  $text = Get-Content -LiteralPath $markdownFile.FullName -Raw -Encoding UTF8
  $matches = [regex]::Matches($text, '(\.\./(?:\.\./)*(?:skills/)?[a-z0-9-]+/SKILL\.md)')
  foreach ($match in $matches) {
    $target = [System.IO.Path]::GetFullPath((Join-Path (Split-Path $markdownFile.FullName -Parent) $match.Groups[1].Value))
    if (-not (Test-Path -LiteralPath $target)) {
      $relativeMarkdown = Get-PortableRelativePath -FromPath $RepoRoot -ToPath $markdownFile.FullName
      $failures.Add("Broken relative skill link '$($match.Groups[1].Value)' in $relativeMarkdown")
    }
  }
}

$manifest = Join-Path $RepoRoot 'sources\upstream-skill-inventory.json'
if (Test-Path -LiteralPath $manifest) {
  $rows = Get-Content -LiteralPath $manifest -Raw -Encoding UTF8 | ConvertFrom-Json
  foreach ($row in $rows) {
    $codexFolder = Join-Path $RepoRoot ($row.codex_folder -replace '/', '\')
    if (-not (Test-Path -LiteralPath $codexFolder -PathType Container)) {
      $failures.Add("Inventory skill folder missing: $($row.codex_folder)")
    }
  }
}

$agentsRoot = Join-Path $RepoRoot '.codex\agents'
if (-not (Test-Path -LiteralPath $agentsRoot)) {
  $failures.Add("Missing agents directory: $agentsRoot")
} else {
  $agentFiles = @(Get-ChildItem -LiteralPath $agentsRoot -File -Filter '*.toml' | Sort-Object Name)
  $agentNames = New-Object System.Collections.Generic.HashSet[string]
  foreach ($agentFile in $agentFiles) {
    $agentText = Get-Content -LiteralPath $agentFile.FullName -Raw -Encoding UTF8
    $agentNameMatch = [regex]::Match($agentText, '(?m)^name\s*=\s*"([^"]+)"\s*$')
    $agentDescriptionMatch = [regex]::Match($agentText, '(?m)^description\s*=\s*".+"\s*$')
    $agentInstructionsMatch = [regex]::Match($agentText, "(?m)^developer_instructions\s*=\s*('''|"""")")

    if (-not $agentNameMatch.Success) {
      $failures.Add("Missing agent name: $($agentFile.FullName)")
      continue
    }

    $agentName = $agentNameMatch.Groups[1].Value
    $expectedFile = "$agentName.toml"
    if ($agentFile.Name -ne $expectedFile) {
      $failures.Add("Agent file '$($agentFile.Name)' does not match name '$agentName'")
    }
    if (-not $agentNames.Add($agentName)) {
      $failures.Add("Duplicate agent name: $agentName")
    }
    if (-not $agentDescriptionMatch.Success) {
      $failures.Add("Missing agent description: $($agentFile.FullName)")
    }
    if (-not $agentInstructionsMatch.Success) {
      $failures.Add("Missing agent developer_instructions: $($agentFile.FullName)")
    }
  }

  $agentManifest = Join-Path $RepoRoot 'sources\codex-agent-inventory.json'
  if (Test-Path -LiteralPath $agentManifest) {
    $agentRows = Get-Content -LiteralPath $agentManifest -Raw -Encoding UTF8 | ConvertFrom-Json
    $agentRowCount = ($agentRows | Measure-Object).Count
    if ($agentRowCount -ne $agentFiles.Count) {
      $failures.Add("Agent inventory count $agentRowCount does not match agent file count $($agentFiles.Count)")
    }
  }
}

if ($failures.Count -gt 0) {
  Write-Host "Validation failed:" -ForegroundColor Red
  $failures | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
  exit 1
}

if (Test-Path -LiteralPath $agentsRoot) {
  $agentCount = @(Get-ChildItem -LiteralPath $agentsRoot -File -Filter '*.toml').Count
  Write-Host "Validated $($skillDirs.Count) Codex skills and $agentCount Codex agents"
} else {
  Write-Host "Validated $($skillDirs.Count) Codex skills under $skillsRoot"
}
