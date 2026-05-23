$apps = "Microsoft.PowerShell", "MIcrosoft.WindowsTerminal"

foreach ($app in $apps) {
    Write-Host "Installing : $app" -ForegroundColor Cyan
    winget install $app
}