param(
  [String]$dir = "public\ja"
)

Write-Output @"
vivliocli.ps1
target dir: $($dir)
"@

Get-ChildItem $dir -include *.js | ForEach-Object {
  Write-Output $_.FullName
  if ($_.GetType().Name -eq "FileInfo") {
    try {
      Write-Output "build...$($_.FullName)"
      npx vivliostyle -v
      npx vivliostyle build -c "$($_.FullName)"
    }
    catch {
      Write-Output $_.Exception.Message
      exit 1
    }
  }
}
