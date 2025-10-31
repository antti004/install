@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command ""Set-ExecutionPolicy -ExecutionPolicy Bypass""' -Verb RunAs}"

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest https://github.com/antti004/install/raw/main/win.ps1 -o win.ps1"

del win.cmd
