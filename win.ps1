$VERSION = "6"

Write-Host " Version $VERSION " -Foreground Yellow 

if( $args.Contains("upgrade")  ){
    Write-Host "Upgrade downoad..."
    Invoke-WebRequest https://github.com/antti004/install/raw/main/win.ps1 -o win.ps1
    return
}

function LogInfo{
    param (
        [string]$Message
    )
    Write-Host $Message -Foreground Yellow 
    #-Background Gray
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
Repair-WinGetPackageManager  -ErrorAction SilentlyContinue

LogInfo -Message "Done"
Sleep 1

LogInfo -Message "Remove BloatWare using WinGet"
$ar = @("Microsoft.Office","Microsoft.OneDrive","Microsoft.Teams.Classic","OneNote","Skype")
$ar += @("Microsoft Tips","MSN Weather","Feedback Hub","Groove Music","Movies & TV","Your Phone")
$ar += @("Xbox Game Bar Plugin","Xbox Game Bar","Xbox Speech Window","Xbox Identity Provider","Xbox")
$ar += @("TeamViwer.TeamViewer")

foreach($it in $ar){
  WinGet remove $it
}

LogInfo -Message "Remove BloatWare using AppxPackage"
$ar = @("*3dbuilder*"," *Microsoft.GetHelp*","*getstarted*","*skypeapp*","*zunemusic*")
$ar += @("*bingfinance*","*zunevideo*","*news*","*onenote*","*windowsphone*","*bingsports*")
$ar += @("*weather*","*todo*","*clipchamp*")
$ar += @("MicrosoftTeams","MSTeams","Microsoft.OutlookForWindows")

LogInfo -Message "Remove using AppxPackage AllUsers"

foreach($it in $ar){
    Write-Host $it
    Get-AppxPackage $it | Remove-AppxPackage -AllUsers -Verbose -ErrorAction Continue
}

$ar = @("*windowscommunicationsapps*","*windowsmaps*","*linkedin*","*office*")
$ar += @("*xboxapp*","Microsoft.Xbox.*")
$ar += @("*GetHelp*","*StickyNotes*","*Solitaire*")

LogInfo -Message "Remove using AppxPackage User"

foreach($it in $ar){
    Write-Host $it
    Get-AppxPackage $it | Remove-AppxPackage -Verbose -ErrorAction Continue
}





