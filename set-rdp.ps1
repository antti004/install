
    $ComputerName = 'localhost'
    $BaseKey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
    $TsBase = 'System\CurrentControlSet\Control\Terminal Server'
    $TcpBase = 'System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp'
        
    try {
        $TsKey = $BaseKey.OpenSubKey($TsBase, $true)
        $TsKey.SetValue("fDenyTSConnections","0",[Microsoft.Win32.RegistryValueKind]::DWORD)
        $TsKey.Close()

        $TcpKey = $BaseKey.OpenSubKey($TcpBase, $true)
        $TcpKey.SetValue("UserAuthentication","1",[Microsoft.Win32.RegistryValueKind]::DWORD)
        $TcpKey.Close()
        
        $result.Status = 'Success'
    } catch {
        $result.Status = 'Error'
        Write-Error $_
    }
    $BaseKey.Close()

    
