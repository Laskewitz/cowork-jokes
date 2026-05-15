<#
.SYNOPSIS
  Builds the Cowork plugin .zip package.

.DESCRIPTION
  Zips manifest.json, the two icons, and the skills/ folder into dist\<packageName>.zip.
  The package name and version are read from manifest.json.

.EXAMPLE
  .\scripts\build.ps1
#>
[CmdletBinding()]
param(
    [string]$Root = (Resolve-Path "$PSScriptRoot\.."),
    [string]$OutDir = (Join-Path (Resolve-Path "$PSScriptRoot\..") "dist")
)

$ErrorActionPreference = "Stop"

$manifestPath = Join-Path $Root "manifest.json"
if (-not (Test-Path $manifestPath)) {
    throw "manifest.json not found at $manifestPath"
}

$manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json
$pkgName = $manifest.packageName
$version = $manifest.version
if (-not $pkgName) { $pkgName = "cowork-plugin" }

$zipName = "$pkgName-$version.zip"
$zipPath = Join-Path $OutDir $zipName

if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir | Out-Null }
if (Test-Path $zipPath) { Remove-Item $zipPath -Force }

Push-Location $Root
try {
    $items = @("manifest.json", "color.png", "outline.png", "skills")
    foreach ($i in $items) {
        if (-not (Test-Path $i)) { throw "Missing required package item: $i" }
    }
    Compress-Archive -Path $items -DestinationPath $zipPath -Force
}
finally {
    Pop-Location
}

Write-Host "Built package: $zipPath" -ForegroundColor Green
Write-Host "  id:      $($manifest.id)"
Write-Host "  name:    $($manifest.name.short)"
Write-Host "  version: $version"
