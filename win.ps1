Write-Host "Version 1.1"

$INSTALLING = "Installing"
$ID = 1

function  Progress {
    param (
        [int]$Id,
        [string]$Activity,
        [int]$Value,
        [string]$Status
    )
    Write-Progress -Id $Id -Activity $Activity -PercentComplete $Value -Status $Status
}

function LogInfo{
    param (
        [string]$Message
    )
    Write-Host $Message -Foreground Yellow -Background Gray
}

#
#  Main program
#
LogInfo -Message "Check execution policy"

$exePolicy = Get-ExecutionPolicy
Write-Host "Current ExecutionPolixy=$($exePolicy)"

if ($exePolicy -ne 'Bypass'){
    Write-Host "Set Execution polixy to ByPass"
    Set-ExecutionPolicy -ExecutionPolicy Bypass
}





LogInfo -Message "Install neccesary programs"
Progress -Id $Id -Activity $INSTALLING -Value 10 -Status "NuGet" 
Install-PackageProvider -Name NuGet -Force
Progress -Id $Id -Activity $INSTALLING -Value 30 -Status "WinGet client" 
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery -Scope AllUsers
Progress -Id $Id -Activity $INSTALLING -Value 70 -Status "Repain WinGet" 
Repair-WinGetPackageManager
Progress -Id $Id -Activity $INSTALLING -Value 100 -Status "" 
Delay 1
