# PowerShell script to disable the Windows 11 "Show more options" context menu.
# Created by Shawn Brink, October 4, 2021.
# https://www.elevenforum.com/t/disable-show-more-options-context-menu-in-windows-11.1589/

$registryPath = 'HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32'
New-Item -Path $registryPath -Force | Out-Null
Set-Item -Path $registryPath -Value ''

