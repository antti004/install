
$version="1.5"
Write-Host "Version: $version" -ForegroundColor White 


$REPO_URL="https://api.github.com/repos/antti004/install/contents"




function Get-GitFiles($baseUrl,$dirName){

    $tarUrl = $baseUrl
    if($path -ne ''){
        $tarUrl = "$baseUrl/$dirName"
    }

    Write-Host "TargetUrl: '$tarUrl'" -ForegroundColor Green

    $targetDir = Join-Path $PSScriptRoot $dirName
    if (-not (Test-Path -LiteralPath $targetDir -PathType Container)) {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }

    $resp = Invoke-WebRequest -Uri $tarUrl
    $repoContent = $resp.Content | ConvertFrom-Json

    foreach ($item in $repoContent) {

        if($item.type -eq 'file'){

            $targetFile = Join-Path $PSScriptRoot $dirName
            $targetFile = Join-Path $targetFile  $item.name
            Write-Host $item.name $item.size $targetFile

            Invoke-WebRequest -Uri $item.download_url -OutFile $targetFile

        }
    }   

}



#Get-GitFiles($REPO_URL,"")


$resp = Invoke-WebRequest -Uri $REPO_URL
$repoContent = $resp.Content | ConvertFrom-Json

foreach ($item in $repoContent) {

    if ($item.type -eq 'dir'){
        Write-Host "$($item.name) ($($item.type))" -ForegroundColor Magenta
        Get-GitFiles -baseUrl $REPO_URL -dirName $item.name
        continue
    }
    
    continue
    if($item.type -eq 'file'){
        Write-Host $item.name $item.size

        Invoke-WebRequest -Uri $item.download_url -OutFile (Join-Path $PSScriptRoot $item.name)
    }
}




