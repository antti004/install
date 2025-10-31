$exePolicy = Get-ExecutionPolicy
Write-Host "Current ExecutionPolixy=$($exePolicy)"

if ($exePolicy -ne 'Bypass'){
    Write-Host "Set Execution polixy to ByPass"
    Set-ExecutionPolicy -ExecutionPolicy Bypass
}

