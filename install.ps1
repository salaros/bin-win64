Invoke-WebRequest 'https://github.com/salaros/bin-win64/archive/refs/heads/development.zip' -OutFile $env:Temp\bin-win64.zip

Expand-Archive $env:Temp\bin-win64.zip $env:Temp\
Copy-Item -Path "$env:Temp\bin-win64-development\binaries\*" -Destination "$env:userprofile\.bin" -Recurse -Force

Remove-Item  $env:Temp\bin-win64-development -Recurse
Remove-Item $env:Temp\bin-win64.zip

$binFolder="$env:userprofile\.bin"
$oldPath = [System.Environment]::GetEnvironmentVariable("Path","User")
$oldPathArray=($oldPath) -split ';'
if(-Not($oldPathArray -Contains "$binFolder")) {
    $newPath = "$oldPath;$binFolder" -replace ';+', ';'
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")
}
