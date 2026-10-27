

$ver=17
$scriptName = Split-Path -Leaf $PSCommandPath
Write-Host "# $scriptName VERSION $ver" -ForegroundColor yellow

$IsDebug = $args -contains '-debug' -or $args -contains 'debug'


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


Function Remove-TempFiles($repoFiles){
    $files = Get-ChildItem  -File -Path .

    foreach ($file in $files)
     {
        Write-Host "-- $($file.Name)"
        if (-not ($repoFiles | Where-Object { $_.name -eq $file.Name })) {
            Write-Host "Remove local $($file.Name)"
            Remove-Item -LiteralPath $file.FullName -Force
        }
    }



}





$resp = Invoke-WebRequest -Uri $REPO_URL
$repoContent = $resp.Content | ConvertFrom-Json


$repoFiles = @($repoContent | Where-Object { $_.type -eq 'file' })
Write-Host "Repo contains $($repoContent.Count)"

Remove-TempFiles -repoFiles $repoFiles

if($IsDebug){
    return
}


foreach ($item in $repoContent) {

    if ($item.type -eq 'dir'){
        Write-Host "[$($item.name)] ($($item.type))" -ForegroundColor  DarkYellow
        Get-GitFiles -baseUrl $REPO_URL -dirName $item.name
        continue
    }
    
    if($item.type -eq 'file'){
        Write-Host $item.name $item.size -ForegroundColor DarkYellow

        Invoke-WebRequest -Uri $item.download_url -OutFile (Join-Path $PSScriptRoot $item.name)
    }
}




