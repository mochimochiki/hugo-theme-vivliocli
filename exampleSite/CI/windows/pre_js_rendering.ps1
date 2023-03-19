param(
  [string]$dir = "public"
)

# setup
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path -Parent $scriptPath
Push-Location $scriptDir

Write-Output @"
-------------------------------
Pre javascript rendering
target dir: $($dir)
-------------------------------
"@

# check if target files exist
$fileNum = 0
$targetFiles = New-Object System.Collections.Generic.List[string]
Get-ChildItem $dir -recurse -include *.html | ForEach-Object {
  if($_.GetType().Name -eq "FileInfo") {
    try {
      if ((Select-String $_ -Pattern "@pre_rendering_type_js" -SimpleMatch).Length -ge 1) {
        $targetFiles.Add($_)
        $fileNum++
      }
    }
    catch {
      Write-Output $_.Exception.Message
      exit 1
    }
  }
}

# pre rendering
if ($targetFiles.Count)
{
  Write-Output "Pre rendering required files exist."
  $targetFiles | ForEach-Object {
    Write-Output "rendering...$($_)"
    node pre_js_rendering.js $_
  }
  Pop-Location
}

Write-Output @"
Pre rendering is completed. (Number of files: $($fileNum))
"@

Pop-Location