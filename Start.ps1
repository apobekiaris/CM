param(
    $GithubUserName =$env:CM_GitHub_UserName,
    $GithubPass=$env:cmToken,
    $DXApiFeed=$env:DxFeed
)
$url = "https://$GithubUserName`:$GithubPass@github.com/apobekiaris/CryptoManager2.git"
if (!(Test-Path .\CryptoManager2)){
  git clone $url
}
else{
  Push-Location .\CryptoManager2
  git pull
  Pop-Location
}
cd .\CryptoManager2
if (!(dotnet nuget list source |sls DX)){
  dotnet nuget add source $DXApiFeed --name DX
  dotnet nuget add source https://xpandnugetserver.azurewebsites.net/nuget --name Xpand
}


dotnet build --configuration Debug "/p:TestConstants=TEST"

if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}
if (!(& sqllocaldb info mssqllocaldb | Select-String -Pattern "State:.*Running" -Quiet)){
  & sqllocaldb start mssqllocaldb
}
