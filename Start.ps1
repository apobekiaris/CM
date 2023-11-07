param(
    $GithubUserName =$env:CM_GitHub_UserName,
    $GithubPass=$env:cmToken,
    $DXApiFeed=$env:DxFeed
)
$url = "https://$GithubUserName`:$GithubPass@github.com/apobekiaris/CryptoManager2.git"
git clone $url
cd .\CryptoManager2

dotnet nuget add source $DXApiFeed --name DX
dotnet nuget add source https://xpandnugetserver.azurewebsites.net/nuget --name Xpand
dotnet build --configuration Debug

if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}

& sqllocaldb start mssqllocaldb