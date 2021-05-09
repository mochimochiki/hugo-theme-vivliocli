param(
  [String]$dir = "public_pdf_sample"
)

# setup
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path -Parent $scriptPath
Push-Location $scriptDir\..\..

Write-Output @"
-----------------------
MathConverter
target dir: $($dir)
-----------------------
"@

# check if math files exist
$fileNum = 0
$mathFileList = New-Object System.Collections.Generic.List[string]
Get-ChildItem $dir -recurse -include *.html | ForEach-Object {
  if ($_.GetType().Name -eq "FileInfo") {
    try {
      Select-String $_ -Pattern "@HTMLHasMath" | ForEach-Object {
        $mathFileList.Add($_.Path)
        $fileNum++
      }
    }
    catch {
      Write-Output $_.Exception.Message
      exit 1
    }
  }
}

# convert math files
if ($mathFileList.Count)
{
  Write-Output "Math file exists. setup npm packages..."
  Push-Location $scriptDir
  npm install

  $mathFileList | ForEach-Object {
    Write-Output "convert...$($_)"
    node -r esm .\tex2chtml-page $_
  }
  Pop-Location
}

Write-Output @"
-----------------------
Convertion completed ! (Number of math files: $($fileNum))
-----------------------
"@

Pop-Location