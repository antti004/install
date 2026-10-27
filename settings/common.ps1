# PowerShell script to disable the Windows 11 "Show more options" context menu.
# Created by Shawn Brink, October 4, 2021.
# https://www.elevenforum.com/t/disable-show-more-options-context-menu-in-windows-11.1589/

$pathShowMoreOptions = 'HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32'
New-Item -Path $pathShowMoreOptions -Force | Out-Null
Set-Item -Path $pathShowMoreOptions -Value ''

# Disable checkbox prefix on files
Write-Host "Disable checkboxes" -ForegroundColor Yellow
$pathCheckbox = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
New-Item -Path $pathCheckbox -Force | Out-Null

Set-ItemProperty -Path $pathCheckbox -Name "AutoCheckSelect" -Value 0 -Type DWord
Set-ItemProperty -Path $pathCheckbox -Name "UseCheckBoxes" -Value 0 -Type DWord