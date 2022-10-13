Param(
  [Parameter(Mandatory = $true)]
  [ValidateScript( {
      if (Test-Path -Path $_ -ErrorAction SilentlyContinue) {
        return $true
      }
      else {
        throw "$($_) is not a valid path."
      }
    })]
  [String]$path
)

function CopyVivlioConfigFile {
  [Cmdletbinding()]
  Param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( {
        if (Test-Path -Path $_ -ErrorAction SilentlyContinue) {
          return $true
        }
        else {
          throw "$($_) is not a valid path."
        }
      })]
    [string]$TargetPath,
    [Parameter(Mandatory = $true)]
    [ValidateScript( {
        if (Test-Path -Path $_ -ErrorAction SilentlyContinue) {
          return $true
        }
        else {
          throw "$($_) is not a valid path."
        }
      })]
    [string]$OutputPath
  )
  $files = Get-ChildItem -Path $TargetPath | Where-Object { ! $_.PSIsContainer }
  $relativePath = Resolve-Path $TargetPath -Relative
  $relativePath = $relativePath.TrimStart(".\").Replace("\","_")
  foreach ($file in $files) {
    $tailFileName = Split-Path $file -Leaf
    if ( $tailFileName.Contains('.vivlio.cover.html') ) {
      $output = Join-Path $OutputPath "$relativePath.vivlio.cover.html"
      Copy-Item $file.FullName $output
    }
    if ( $tailFileName.Contains('.vivlio.config.js') ) {
      $output = Join-Path $OutputPath "$relativePath.vivlio.config.js"
      Copy-Item $file.FullName $output
      $data = Get-Content -Encoding utf8 $output | ForEach-Object { $_ -creplace "_pdf.vivlio.cover.html", "$relativePath.vivlio.cover.html" }
      $data = $data | ForEach-Object { $_ -creplace "_pdfcolophon.vivlio.colophon.html", "$relativePath.vivlio.colophon.html" }
      $data | Out-File -Encoding utf8 $output | Set-Content -Path $output -Encoding Byte
    }
    if ( $tailFileName.Contains('.vivlio.colophon.html') ) {
      $output = Join-Path $OutputPath "$relativePath.vivlio.colophon.html"
      Copy-Item $file.FullName $output
    }
  }
  $dirs = Get-ChildItem -Path $TargetPath | Where-Object { $_.PSIsContainer }
  foreach ($dir in $dirs) {
    CopyVivlioConfigFile $dir.FullName $OutputPath
  }
}
 
if (-not (Test-Path $path)) {
  Write-host "Folder is not found"
  exit
}

$dirs = Get-ChildItem -Path $path | Where-Object { $_.PSIsContainer }
pushd $path
foreach ($dir in $dirs) {
  CopyVivlioConfigFile $dir.FullName $path
}
popd