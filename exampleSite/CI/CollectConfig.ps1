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

Function Get-DirHash {
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
    [string]$Path
  )
  $temp = [System.IO.Path]::GetTempFileName()
  Get-ChildItem -File -Recurse $Path | Get-FileHash | Select-Object -ExpandProperty Hash | Out-File $temp -NoNewline
  $hash = Get-FileHash $temp
  Remove-Item $temp
  $hash.Path = $Path
  return $hash
}

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
  $hash = Get-DirHash $TargetPath
  foreach ($file in $files) {
    $tailFileName = Split-Path $file -Leaf
    if ( $tailFileName.Contains('.vivlio.cover.html') ) {
      $hashValue = $hash.Hash
      $output = Join-Path $OutputPath "$hashValue.vivlio.cover.html"
      Copy-Item $file.FullName $output
    }
    if ( $tailFileName.Contains('.vivlio.config.js') ) {
      $hashValue = $hash.Hash
      $output = Join-Path $OutputPath "$hashValue.vivlio.config.js"
      Copy-Item $file.FullName $output
      $data = Get-Content -Encoding utf8 $output | ForEach-Object { $_ -creplace "_pdf.vivlio.cover.html", "$hashValue.vivlio.cover.html" }
      $data = $data | ForEach-Object { $_ -creplace "_pdfcolophon.vivlio.colophon.html", "$hashValue.vivlio.colophon.html" }
      $data | Out-File -Encoding utf8 $output | Set-Content -Path $output -Encoding Byte
    }
    if ( $tailFileName.Contains('.vivlio.colophon.html') ) {
      $hashValue = $hash.Hash
      $output = Join-Path $OutputPath "$hashValue.vivlio.colophon.html"
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
foreach ($dir in $dirs) {
  CopyVivlioConfigFile $dir.FullName $path
}