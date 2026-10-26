function Ensure-Key { param([string]$Path) if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null } }
function Set-Reg {
    param([string]$Path,[string]$Name,$Value,[ValidateSet('String','ExpandString','Binary','DWord','QWord','MultiString')][string]$Type='DWord')
    Ensure-Key $Path
    New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force | Out-Null
}
function Remove-Reg { param([string]$Path,[string]$Name) if (Test-Path $Path) { Remove-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue } }
function Set-ServiceState {
    param([string]$Name,[ValidateSet('Automatic','Manual','Disabled')][string]$StartupType,[switch]$Stop)
    $svc = Get-Service -Name $Name -ErrorAction SilentlyContinue
    if (-not $svc) { return }
    if ($Stop -and $svc.Status -ne 'Stopped') { Stop-Service -Name $Name -Force -ErrorAction SilentlyContinue }
    Set-Service -Name $Name -StartupType $StartupType -ErrorAction SilentlyContinue
}
