param(
  [String]$dir = "public\ja"
)

# Vivliostyle CLI v9 以降は entry / output / workspaceDir / static をプロセスの
# カレントディレクトリ基準で解決する(v8 は config が置かれた階層の基準だった)。
# そのため config のあるディレクトリへ移動してから実行する。Linux の run_vivlio.js と同じ扱い。
# 移動先からは npx でローカルの vivliostyle を解決できないため、実行ファイルを絶対パスで指す。
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$vivlioBin = Join-Path $scriptDir "node_modules\.bin\vivliostyle.cmd"

Write-Output @"
vivliocli.ps1
target dir: $($dir)
"@

Get-ChildItem $dir -include *.js | ForEach-Object {
  Write-Output $_.FullName
  if ($_.GetType().Name -eq "FileInfo") {
    try {
      Write-Output "build...$($_.FullName)"
      Push-Location $_.DirectoryName
      try {
        & $vivlioBin -v
        & $vivlioBin build -c $_.Name
      }
      finally {
        Pop-Location
      }
    }
    catch {
      Write-Output $_.Exception.Message
      exit 1
    }
  }
}
