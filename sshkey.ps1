$username = [Environment]::UserName
$sshDir = "$env:USERPROFILE\.ssh"

Write-Host $sshDir

If (Test-Path $sshDir) {

    $files = Get-Childitem -Path $sshDir -Filter *.pub
    $pubFile = $files | Select-Object -First 1

    if ($null -ne $pubFile) {
        $content = Get-Content $pubFile -Raw
        Write-Host $content
        $content | Set-Clipboard


    }
}
