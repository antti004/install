
$version="1.1"
Write-Host "Version: $version" -ForegroundColor White -BackgroundColor DarkCyan
Write-Host ""



$repoUrl="https://api.github.com/repos/antti004/install/contents"

$resp = Invoke-WebRequest -Uri $repoUrl

$repoContent = $resp.Content | ConvertFrom-Json
$repoContent
foreach ($item in $repoContent) {
    if ($item.type -ne 'file'){
        Write-Host "- $($item.name) ($($item.type))" -ForegroundColor DarkGray
        continue
    }
    Write-Host $item.Name $item.size $item.download_url

    Invoke-WebRequest -Uri $item.download_url -OutFile (Join-Path $PSScriptRoot $item.name)

}

