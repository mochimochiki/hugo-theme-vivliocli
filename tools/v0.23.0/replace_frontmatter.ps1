# ----------------------------------------------------
# Settings
# ----------------------------------------------------

# Target directory ('.' = current directory)
$targetDir = "../../exampleSite/content"

# ----------------------------------------------------
# Regex
# ----------------------------------------------------

# Converts:
#
# _build:
#   list: false
#
# _build:
#   list: 'false'
#
# _build:
#   list: "false"
#
# to:
#
# build:
#   list: 'never'
#

$searchPattern = '(?im)_build\s*:\s*\r?\n(\s*)list\s*:\s*["'']?false["'']?'

Write-Host "Scanning markdown files..." -ForegroundColor Cyan

$changedCount = 0

Get-ChildItem -Path $targetDir -Filter *.md -Recurse | ForEach-Object {

  $file = $_

  try {

    # Read raw bytes
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)

    # Detect UTF-8 BOM
    $hasBom =
    $bytes.Length -ge 3 -and
    $bytes[0] -eq 0xEF -and
    $bytes[1] -eq 0xBB -and
    $bytes[2] -eq 0xBF

    # Decode UTF-8
    $content = [System.Text.Encoding]::UTF8.GetString($bytes)

    # Preserve original line ending style
    $newline =
    if ($content.Contains("`r`n")) {
      "`r`n"
    }
    else {
      "`n"
    }

    if (-not [regex]::IsMatch($content, $searchPattern)) {
      return
    }

    $newContent = [regex]::Replace(
      $content,
      $searchPattern,
      {
        param($m)

        $indent = $m.Groups[1].Value

        "build:${newline}${indent}list: 'never'"
      }
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
