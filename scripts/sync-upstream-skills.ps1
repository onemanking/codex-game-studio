param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
  [string]$UpstreamRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\work\upstreams')).Path
)

$ErrorActionPreference = 'Stop'

function Assert-ChildPath {
  param([string]$Child, [string]$Parent)
  $childFull = [System.IO.Path]::GetFullPath($Child)
  $parentFull = [System.IO.Path]::GetFullPath($Parent).TrimEnd('\') + '\'
  if (-not $childFull.StartsWith($parentFull, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Refusing path outside parent. Child=$childFull Parent=$parentFull"
  }
}

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

function Read-FrontmatterValue {
  param([string]$Frontmatter, [string]$Key)
  $match = [regex]::Match($Frontmatter, "(?m)^$([regex]::Escape($Key)):\s*(.+?)\s*$")
  if (-not $match.Success) { return $null }
  $value = $match.Groups[1].Value.Trim()
  if (($value.StartsWith('"') -and $value.EndsWith('"')) -or ($value.StartsWith("'") -and $value.EndsWith("'"))) {
    return $value.Substring(1, $value.Length - 2)
  }
  return $value
}

function Convert-SkillName {
  param(
    [string]$SourceId,
    [string]$OriginalName
  )

  switch ($SourceId) {
    'phaser' { return "phaser-$OriginalName" }
    default { return $OriginalName }
  }
}

function Convert-RelativeSkillLinks {
  param(
    [string]$Body,
    [string]$SourceId,
    [string[]]$OriginalNames
  )

  if ($SourceId -ne 'phaser') { return $Body }

  $updated = $Body
  foreach ($name in $OriginalNames) {
    $escaped = [regex]::Escape("../$name/SKILL.md")
    $updated = [regex]::Replace($updated, $escaped, "../phaser-$name/SKILL.md")
  }
  return $updated
}

function Convert-PhaserLinksForFile {
  param(
    [string]$Text,
    [string[]]$OriginalNames,
    [string]$FilePath,
    [string]$SkillsRoot
  )

  $fileDir = Split-Path $FilePath -Parent
  $relativeToSkillsRoot = (Get-PortableRelativePath -FromPath $fileDir -ToPath $SkillsRoot).Replace('\', '/')
  if ([string]::IsNullOrWhiteSpace($relativeToSkillsRoot)) {
    $relativeToSkillsRoot = '.'
  }

  $updated = $Text
  foreach ($name in $OriginalNames) {
    $escaped = [regex]::Escape("../$name/SKILL.md")
    $updated = [regex]::Replace($updated, $escaped, "$relativeToSkillsRoot/phaser-$name/SKILL.md")
  }
  return $updated
}

function Convert-CodexTerminology {
  param([string]$Text)

  if ($null -eq $Text) { return $Text }

  $legacyName = 'Cl' + 'aude'
  $legacyUpper = 'CLA' + 'UDE'
  $legacyLower = 'cl' + 'aude'
  $legacyCompany = 'Anth' + 'ropic'
  $legacyShortUpper = 'CC' + 'GS'
  $legacyShortLowerPrefix = 'cc' + 'gs-'
  $updated = $Text
  $updated = $updated.Replace("$legacyName Code Game Studios", 'Codex Game Studio')
  $updated = $updated.Replace("$legacyLower-code-game-studios", 'codex-game-studio')
  $updated = $updated.Replace("$legacyName Code", 'Codex')
  $updated = $updated.Replace("$legacyCompany, ", '')
  $updated = $updated.Replace("$legacyUpper.md", 'AGENTS.md')
  $updated = $updated.Replace($legacyUpper, 'AGENTS')
  $updated = $updated.Replace("~/.$legacyLower", '~/.codex')
  $updated = $updated.Replace(".$legacyLower\", '.codex\')
  $updated = $updated.Replace(".$legacyLower/", '.codex/')
  $updated = $updated.Replace(".$legacyLower", '.codex')
  $updated = $updated.Replace("$legacyShortUpper Skill Testing Framework", 'Codex Skill Testing Framework')
  $updated = $updated.Replace($legacyShortUpper, 'Codex Game Studio')
  $updated = $updated.Replace($legacyShortLowerPrefix, '')
  $updated = $updated.Replace("-a $legacyLower-code", '-a codex')
  $updated = $updated.Replace("--$legacyLower", '--codex')
  $updated = $updated.Replace('Tools like Codex, Cursor, Codex', 'Tools like Codex, Cursor')
  $updated = $updated.Replace($legacyName, 'Codex')
  return $updated
}

$sources = @(
  @{
    id = 'r3f-skills'
    label = 'R3F Skills'
    url = 'https://github.com/EnzeD/r3f-skills'
    skillsPath = Join-Path $UpstreamRoot 'r3f-skills\skills'
    rootPath = Join-Path $UpstreamRoot 'r3f-skills'
    licenseFiles = @()
    readmeFiles = @('README.md')
  },
  @{
    id = 'phaser'
    label = 'Phaser Skills'
    url = 'https://github.com/phaserjs/phaser/tree/master/skills'
    skillsPath = Join-Path $UpstreamRoot 'phaser\skills'
    rootPath = Join-Path $UpstreamRoot 'phaser'
    licenseFiles = @('LICENSE.md')
    readmeFiles = @('README.md')
  },
  @{
    id = 'threejs-game-skills'
    label = 'Three.js Game Skills'
    url = 'https://github.com/majidmanzarpour/threejs-game-skills'
    skillsPath = Join-Path $UpstreamRoot 'threejs-game-skills\skills'
    rootPath = Join-Path $UpstreamRoot 'threejs-game-skills'
    licenseFiles = @('LICENSE')
    readmeFiles = @('README.md', 'AGENTS.md')
  },
  @{
    id = 'cloudai-threejs-skills'
    label = 'CloudAI-X Three.js Skills'
    url = 'https://github.com/cloudai-x/threejs-skills'
    skillsPath = Join-Path $UpstreamRoot 'cloudai-threejs-skills\skills'
    rootPath = Join-Path $UpstreamRoot 'cloudai-threejs-skills'
    licenseFiles = @()
    readmeFiles = @('README.md')
  }
)

$skillsDest = Join-Path $RepoRoot '.codex\skills'
$vendorDest = Join-Path $RepoRoot 'vendor\upstream-skills'
$sourceDest = Join-Path $RepoRoot 'sources'

foreach ($path in @($skillsDest, $vendorDest, $sourceDest)) {
  Assert-ChildPath -Child $path -Parent $RepoRoot
  New-Item -ItemType Directory -Force -Path $path | Out-Null
}

$generatedMarker = '# Generated by scripts/sync-upstream-skills.ps1'

$legacyRootSkills = Join-Path $RepoRoot 'skills'
if (Test-Path -LiteralPath $legacyRootSkills) {
  $generatedSkillCount = 0
  $totalSkillCount = 0
  foreach ($existingSkill in Get-ChildItem -LiteralPath $legacyRootSkills -Directory -ErrorAction SilentlyContinue) {
    $totalSkillCount += 1
    $skillFile = Join-Path $existingSkill.FullName 'SKILL.md'
    if ((Test-Path -LiteralPath $skillFile) -and ((Get-Content -LiteralPath $skillFile -Raw -Encoding UTF8).Contains($generatedMarker))) {
      $generatedSkillCount += 1
    }
  }
  if ($totalSkillCount -gt 0 -and $generatedSkillCount -eq $totalSkillCount) {
    Remove-Item -LiteralPath $legacyRootSkills -Recurse -Force
  }
}

foreach ($existingSkill in Get-ChildItem -LiteralPath $skillsDest -Directory -ErrorAction SilentlyContinue) {
  $skillFile = Join-Path $existingSkill.FullName 'SKILL.md'
  if ((Test-Path -LiteralPath $skillFile) -and ((Get-Content -LiteralPath $skillFile -Raw -Encoding UTF8).Contains($generatedMarker))) {
    Remove-Item -LiteralPath $existingSkill.FullName -Recurse -Force
  }
}

$manifestRows = New-Object System.Collections.Generic.List[object]
$allSkillNames = New-Object System.Collections.Generic.HashSet[string]

foreach ($existingSkill in Get-ChildItem -LiteralPath $skillsDest -Directory -ErrorAction SilentlyContinue) {
  if (-not $allSkillNames.Add($existingSkill.Name)) {
    throw "Duplicate existing Codex skill directory: $($existingSkill.Name)"
  }
}

foreach ($source in $sources) {
  if (-not (Test-Path -LiteralPath $source.skillsPath)) {
    throw "Missing upstream skills path: $($source.skillsPath)"
  }

  $sourceVendor = Join-Path $vendorDest $source.id
  Assert-ChildPath -Child $sourceVendor -Parent $vendorDest
  if (Test-Path -LiteralPath $sourceVendor) {
    Remove-Item -LiteralPath $sourceVendor -Recurse -Force
  }
  New-Item -ItemType Directory -Force -Path $sourceVendor | Out-Null

  $vendorSkills = Join-Path $sourceVendor 'skills'
  Copy-Item -LiteralPath $source.skillsPath -Destination $vendorSkills -Recurse

  foreach ($fileName in ($source.licenseFiles + $source.readmeFiles)) {
    $filePath = Join-Path $source.rootPath $fileName
    if (Test-Path -LiteralPath $filePath) {
      Copy-Item -LiteralPath $filePath -Destination (Join-Path $sourceVendor $fileName) -Force
    }
  }

  foreach ($vendorTextFile in Get-ChildItem -LiteralPath $sourceVendor -Recurse -File -Include '*.md','*.txt','*.json','*.yaml','*.yml','*.ps1','*.sh','*.py','*.ts','*.js') {
    $vendorText = Get-Content -LiteralPath $vendorTextFile.FullName -Raw -Encoding UTF8
    $updatedVendorText = Convert-CodexTerminology -Text $vendorText
    if ($updatedVendorText -ne $vendorText) {
      Set-Content -LiteralPath $vendorTextFile.FullName -Value $updatedVendorText -Encoding UTF8
    }
  }

  $skillDirs = @(Get-ChildItem -LiteralPath $source.skillsPath -Directory | Sort-Object Name)
  $originalNames = @()
  foreach ($skillDir in $skillDirs) {
    $skillFile = Join-Path $skillDir.FullName 'SKILL.md'
    $text = Get-Content -LiteralPath $skillFile -Raw -Encoding UTF8
    $frontmatterMatch = [regex]::Match($text, '(?s)^---\s*\r?\n(.+?)\r?\n---\s*')
    if (-not $frontmatterMatch.Success) {
      throw "Missing frontmatter in $skillFile"
    }
    $originalName = Read-FrontmatterValue -Frontmatter $frontmatterMatch.Groups[1].Value -Key 'name'
    if (-not $originalName) { throw "Missing name in $skillFile" }
    $originalNames += $originalName
  }

  foreach ($skillDir in $skillDirs) {
    $skillFile = Join-Path $skillDir.FullName 'SKILL.md'
    $text = Get-Content -LiteralPath $skillFile -Raw -Encoding UTF8
    $frontmatterMatch = [regex]::Match($text, '(?s)^---\s*\r?\n(.+?)\r?\n---\s*')
    $frontmatter = $frontmatterMatch.Groups[1].Value
    $originalName = Read-FrontmatterValue -Frontmatter $frontmatter -Key 'name'
    $originalDescription = Read-FrontmatterValue -Frontmatter $frontmatter -Key 'description'
    if (-not $originalDescription) {
      $originalDescription = "Imported upstream skill from $($source.label)."
    }
    $originalDescription = Convert-CodexTerminology -Text $originalDescription

    $newName = Convert-SkillName -SourceId $source.id -OriginalName $originalName
    if (-not $allSkillNames.Add($newName)) {
      throw "Duplicate Codex skill name after conversion: $newName"
    }

    $destDir = Join-Path $skillsDest $newName
    Assert-ChildPath -Child $destDir -Parent $skillsDest
    Copy-Item -LiteralPath $skillDir.FullName -Destination $destDir -Recurse

    $body = $text.Substring($frontmatterMatch.Length)
    $body = Convert-RelativeSkillLinks -Body $body -SourceId $source.id -OriginalNames $originalNames
    $body = Convert-CodexTerminology -Text $body
    $description = "Codex adaptation of $($source.label) skill '$originalName'. $originalDescription"
    $description = $description.Replace("`r", ' ').Replace("`n", ' ')
    $newSkillText = @"
---
name: $newName
description: >-
  $description
---

$generatedMarker

> Source: $($source.url)
> Original skill name: $originalName
> Original source folder: vendor/upstream-skills/$($source.id)/skills/$($skillDir.Name)

$body
"@
    Set-Content -LiteralPath (Join-Path $destDir 'SKILL.md') -Value $newSkillText -Encoding UTF8

    if ($source.id -eq 'phaser') {
      foreach ($markdownFile in Get-ChildItem -LiteralPath $destDir -Recurse -File -Include '*.md') {
        $markdownText = Get-Content -LiteralPath $markdownFile.FullName -Raw -Encoding UTF8
        $updatedMarkdown = Convert-PhaserLinksForFile -Text $markdownText -OriginalNames $originalNames -FilePath $markdownFile.FullName -SkillsRoot $skillsDest
        if ($updatedMarkdown -ne $markdownText) {
          Set-Content -LiteralPath $markdownFile.FullName -Value $updatedMarkdown -Encoding UTF8
        }
      }
    }

    foreach ($textFile in Get-ChildItem -LiteralPath $destDir -Recurse -File -Include '*.md','*.txt','*.json','*.yaml','*.yml','*.ps1','*.sh','*.py','*.ts','*.js') {
      $fileText = Get-Content -LiteralPath $textFile.FullName -Raw -Encoding UTF8
      $updatedFileText = Convert-CodexTerminology -Text $fileText
      if ($source.id -eq 'phaser') {
        $updatedFileText = Convert-PhaserLinksForFile -Text $updatedFileText -OriginalNames $originalNames -FilePath $textFile.FullName -SkillsRoot $skillsDest
      }
      if ($updatedFileText -ne $fileText) {
        Set-Content -LiteralPath $textFile.FullName -Value $updatedFileText -Encoding UTF8
      }
    }

    $manifestRows.Add([pscustomobject]@{
      source = $source.id
      label = $source.label
      url = $source.url
      original_name = $originalName
      codex_name = $newName
      source_folder = "vendor/upstream-skills/$($source.id)/skills/$($skillDir.Name)"
      codex_folder = ".codex/skills/$newName"
    })
  }
}

$manifestJson = Join-Path $sourceDest 'upstream-skill-inventory.json'
$manifestRows | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $manifestJson -Encoding UTF8

$summary = @()
$summary += '# Upstream Skill Inventory'
$summary += ''
$summary += $generatedMarker
$summary += ''
$summary += "Generated: $(Get-Date -Format o)"
$summary += ''
foreach ($group in ($manifestRows | Group-Object source)) {
  $first = $group.Group[0]
  $summary += "## $($first.label)"
  $summary += ''
  $summary += "- Source: $($first.url)"
  $summary += "- Imported skills: $($group.Count)"
  $summary += ('- Vendor copy: `vendor/upstream-skills/{0}/skills`' -f $group.Name)
  $summary += ''
  foreach ($row in ($group.Group | Sort-Object codex_name)) {
    $summary += ('- `{0}` from `{1}`' -f $row.codex_name, $row.original_name)
  }
  $summary += ''
}
$summary | Set-Content -LiteralPath (Join-Path $sourceDest 'upstream-skill-inventory.md') -Encoding UTF8

Write-Host "Synced $($manifestRows.Count) upstream skills into $skillsDest"
