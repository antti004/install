$result = [PSCustomObject]@{ Status = $null }

try {
    # Enable Remote Desktop
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
    
    # Require Network Level Authentication
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 1
    
    $result.Status = 'Success'
} 
catch {
    $result.Status = 'Error'
    Write-Error $_
}

$result
    
