param(
    $GithubUserName ="apobekiaris",
    $GithubPass=$env:apobekiarisToken,
    $GitUserEmail,
    $DXApiFeed=$env:DxFeed
)
$url = "https://$GithubUserName`:$GithubPass@github.com/apobekiaris/CryptoManager2.git"
git clone $url
cd .\CryptoManager2

dotnet nuget add source $DXApiFeed --name DX
dotnet nuget add source https://xpandnugetserver.azurewebsites.net/nuget --name Xpand
dotnet build --configuration DEBUG

& sqllocaldb start mssqllocaldb