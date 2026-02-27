$username = [Environment]::UserName
$hostname = $env:COMPUTERNAME

$email = "$($username)@$($hostname).local"
write-host  $email -ForegroundColor Cyan
git config --global user.email "$($email)"
git config --global user.name "$($username)"