@echo off
:: Move to the directory where this script is located
cd /d "%~dp0"
set "CURRENT_DIR=%CD%"

:: powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command ""Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine -Force; ; Set-Location ''%CURRENT_DIR%''""' -Verb RunAs}"

:: Enable script execution and open an elevated PowerShell window in this directory
::#powershell -Command "Start-Process powershell -ArgumentList '-NoExit -Command Set-ExecutionPolicy Bypass -Scope LocalMachine -Force; Set-Location ''%CURRENT_DIR%''' -Verb RunAs"


powershell -Command "Start-Process powershell -ArgumentList '-NoExit -Command Set-Location ''%CURRENT_DIR%''' -Verb RunAs"