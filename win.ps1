$VERSION = "3"

Write-Host "Version $VERSION" -Foreground Yellow -Background White

if( $args.Contains("upgrade")  ){
    Write-Host "Upgrade downoad..."
    Invoke-WebRequest https://github.com/antti004/install/raw/main/win.ps1 -o win.ps1
    return
}


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

LogInfo -Message "# Install NuGet"
Install-PackageProvider -Name NuGet -Force -ErrorAction SilentlyContinue

LogInfo -Message "# Install WinGet"
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery -Scope AllUsers -ErrorAction SilentlyContinue

LogInfo -Message "# Repair WinGet"
Repair-WinGetPackageManager -Error -ErrorAction SilentlyContinue

LogInfo -Message "Done"
Sleep 1

LogInfo -Message "Remove BloatWare"
$ar = @("Microsoft.Office","Microsoft.OneDrive","Microsoft.Teams.Classic","OneNote","Skype")
$ar += @("Microsoft Tips","MSN Weather","Feedback Hub","Groove Music","Movies & TV","Your Phone")
$ar += @("Xbox Game Bar Plugin","Xbox Game Bar","Xbox Speech Window","Xbox Identity Provider","Xbox")
$ar += @("TeamViwer.TeamViewer")

foreach($it in $ar){
  WinGet remove $it
}

