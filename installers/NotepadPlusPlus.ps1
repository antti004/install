$ErrorActionPreference = 'Stop'

Write-Host "Fetching the latest Notepad++ release information..." -ForegroundColor Cyan

# Query GitHub API for the latest release
$apiUri = "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"
$headers = @{ "User-Agent" = "PowerShell" }
$release = Invoke-RestMethod -Uri $apiUri -Headers $headers -UseBasicParsing

# Find the 64-bit installer asset
$asset = $release.assets | Where-Object { $_.name -match "Installer\.x64\.exe$" }
if (-not $asset) {
    Write-Error "Could not find the 64-bit Notepad++ installer in the latest release."
    exit 1
}

$downloadUrl = $asset.browser_download_url
$fileName = $asset.name
$outputPath = Join-Path $env:TEMP $fileName



if (Test-Path -Path $outputPath -PathType Leaf) {
    Write-Host "Installer already exists at $outputPath; skipping download." -ForegroundColor Yellow
} else {
    Write-Host "Downloading Notepad++ $($release.tag_name)..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $downloadUrl -OutFile $outputPath
}


Start-Process -FilePath $outputPath  -Wait

# Clean up the downloaded installer file
Remove-Item -Path $outputPath -ErrorAction SilentlyContinue
