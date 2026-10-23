


function Enable-RdpRegistry {
    param (
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Position=0, Mandatory)]
        [string]$ComputerName
    )

    process {

        if (-not (Test-Connection -ComputerName $ComputerName -BufferSize 16 -Count 1 -Quiet -ErrorAction SilentlyContinue)) {
            $out = [PSCustomObject][Ordered] @{
                ComputerName = $ComputerName
                Status = 'Unavailable'
            }
            return $out
        }
        
        $result = [PSCustomObject][Ordered] @{
            ComputerName = $ComputerName
            Status = ''
        }

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
        }
        $BaseKey.Close()

        $result
        
    }

}

Enable-RdpRegistry
