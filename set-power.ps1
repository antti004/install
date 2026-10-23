
function LogInfo {
	param([string]$Message)
	Write-Host $Message -ForegroundColor Yellow -BackgroundColor DarkCyan
}

LogInfo 'Disable monitor timeout'
powercfg /change monitor-timeout-ac 0

LogInfo 'Disable computer timeout'
powercfg /change standby-timeout-ac 0

LogInfo 'Disabling hibernate'
powercfg -h off

