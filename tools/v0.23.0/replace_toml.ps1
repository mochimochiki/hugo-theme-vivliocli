# ----------------------------------------------------
# replace_toml.ps1
#
# Hugo migration:
#   languageCode      -> locale
#   languageName      -> label
#   languageDirection -> direction
# ----------------------------------------------------

$targetDir = "../../exampleSite"

Write-Host "Scanning TOML files..." -ForegroundColor Cyan

$changedCount = 0

Get-ChildItem -Path $targetDir -Filter *.toml -Recurse | ForEach-Object {

  $file = $_

  try {

    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)

    $hasBom =
    $bytes.Length -ge 3 -and
    $bytes[0] -eq 0xEF -and
    $bytes[1] -eq 0xBB -and
    $bytes[2] -eq 0xBF

    $content = [System.Text.Encoding]::UTF8.GetString($bytes)

    $newContent = $content

    # Key replacement
    $newContent = [regex]::Replace(
      $newContent,
      '(?m)^(\s*)languageCode(\s*=)',
      '$1locale$2'
    )

    $newContent = [regex]::Replace(
      $newContent,
      '(?m)^(\s*)languageName(\s*=)',
      '$1label$2'
    )

    $newContent = [regex]::Replace(
      $newContent,
      '(?m)^(\s*)languageDirection(\s*=)',
      '$1direction$2'
    )

    if ($newContent -eq $content) {
      return
    }

    $utf8 =
    if ($hasBom) {
      New-Object System.Text.UTF8Encoding($true)
    }
    else {
      New-Object System.Text.UTF8Encoding($false)
    }

    [System.IO.File]::WriteAllText(
      $file.FullName,
      $newContent,
      $utf8
    )

    Write-Host "Updated: $($file.FullName)" -ForegroundColor Green
    $changedCount++
  }
  catch {
    Write-Warning "Failed: $($file.FullName)"
    Write-Warning $_.Exception.Message
  }
}

Write-Host ""
Write-Host "----------------------------------------"
Write-Host "Completed. Modified files: $changedCount" -ForegroundColor Cyan
