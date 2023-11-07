param(
    $GithubUserName ="apobekiaris",
    $GithubPass=$env:apobekiarisToken,
    $GitUserEmail,
    $DXApiFeed=$env:DxFeed
)

$yaml = @"
- Name: XpandPwsh
  Version: 1.221.0.7
"@
& "$PSScriptRoot\Install-Module.ps1" $yaml
$directory ="$env:TEMP\CR"
if (Test-Path $directory){
    Remove-Item $directory -Recurse -Force
}
New-Item $directory -ItemType Directory -Force 
Set-Location $directory
$url = "https://$GithubUserName`:$GithubPass@github.com/apobekiaris/CryptoManager2.git"
git clone $url
cd .\CryptoManager2


dotnet nuget add source $DXApiFeed --name DX
dotnet nuget add source https://xpandnugetserver.azurewebsites.net/nuget --name Xpand
Start-Build -Configuration DEBUG

& sqllocaldb start mssqllocaldb