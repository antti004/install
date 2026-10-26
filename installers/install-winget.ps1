
if(!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{
    Start-Process "powershell.exe" -Verb "runAs" -ArgumentList ("& '" +$myinvocation.mycommand.definition + "'")
    break
}

Write-Host "Install Nuget".PadLeft(10).PadRight(80)  -ForegroundColor DarkGreen -BackgroundColor White
Install-PackageProvider -Name NuGet -Force
Write-Host "Install WinGet".PadLeft(10).PadRight(80)  -ForegroundColor DarkGreen -BackgroundColor White
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery -Scope AllUsers
Write-Host "Repair PackageManager".PadLeft(10).PadRight(80)  -ForegroundColor DarkGreen -BackgroundColor White
Repair-WinGetPackageManager
Write-Host "Install DesktopAppInstaller".PadLeft(10).PadRight(80)  -ForegroundColor DarkGreen -BackgroundColor White
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
Write-Host "All Done".PadLeft(10).PadRight(80)  -ForegroundColor DarkGreen -BackgroundColor White
pause
