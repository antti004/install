function LogInfo{
    param (
        [string]$Message
    )
    Write-Host $Message -Foreground Yellow 
    #-Background Gray
}

LogInfo -Message "Check execution policy"

$exePolicy = Get-ExecutionPolicy
Write-Host "Current ExecutionPolixy=$($exePolicy)"

if ($exePolicy -ne 'Bypass'){
    Write-Host "Set Execution polixy to ByPass"
    Set-ExecutionPolicy -ExecutionPolicy Bypass
}

LogInfo -Message "Remove BloatWare using WinGet"
$ar = @("Microsoft.Office","Microsoft.OneDrive","Microsoft.Teams.Classic","OneNote","Skype")
$ar += @("Microsoft Tips","MSN Weather","Feedback Hub","Groove Music","Movies & TV","Your Phone")
$ar += @("Xbox Game Bar Plugin","Xbox Game Bar","Xbox Speech Window","Xbox Identity Provider","Xbox")
$ar += @("TeamViwer.TeamViewer")

foreach($it in $ar){
  WinGet remove $it
}

#####
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

##### 
LogInfo -Message "Remove using AppxPackage User"

$ar = @("*windowscommunicationsapps*","*windowsmaps*","*linkedin*","*office*")
$ar += @("*xboxapp*","Microsoft.Xbox.*")
$ar += @("*GetHelp*","*StickyNotes*","*Solitaire*")


foreach($it in $ar){
    Write-Host $it
    Get-AppxPackage $it | Remove-AppxPackage -Verbose -ErrorAction Continue
}

