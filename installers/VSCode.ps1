$ProgressPreference = 'SilentlyContinue'
$installer = Join-Path $env:TEMP 'VSCodeSetup-x64.exe'

Write-Host "Downloading latest Visual Studio Code..." -ForegroundColor Cyan
Invoke-WebRequest -Uri "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64" -OutFile $installer

Write-Host "Installing..." -ForegroundColor Cyan
Start-Process -FilePath $installer -ArgumentList '/VERYSILENT', '/NORESTART', '/MERGETASKS=!runcode,addtopath,addcontextmenufiles,addcontextmenufolder','/SUPPRESSMSGBOXES' -Wait

Remove-Item -Path $installer -ErrorAction SilentlyContinue
Write-Host "Visual Studio Code installation complete!" -ForegroundColor Green