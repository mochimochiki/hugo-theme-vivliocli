@echo off

set scriptdir=%~dp0
set hugodir=%~dp0..
pushd %hugodir%

if "%1" == "" (
  echo "arg1:environment was not specified. Build with [pdf] environment..."
  set hugo_env=pdf
) else (
  set hugo_env=%1
)

:: environment exist check
if not exist .\config\%hugo_env% (
  echo "%hugo_env% does not exist in config directory."
  exit /B 1
)

:: -----------------------
:: HUGO Build
:: -----------------------
echo Build %hugo_env% environment...
hugo --environment %hugo_env%
popd
if not %errorlevel% == 0 exit /B 1

:: ----------
:: JP PDF
:: ----------
pushd %scriptdir%
powershell -NoProfile -ExecutionPolicy Bypass ^
  ".\CollectConfig.ps1 \"%hugodir%\public_%hugo_env%\jp\";exit $LASTEXITCODE"
powershell -NoProfile -ExecutionPolicy Bypass ^
  ".\vivliocli.ps1 -dir \"%hugodir%\public_%hugo_env%\jp\*.*\";exit $LASTEXITCODE"
popd
if not %errorlevel% == 0 exit /B 1

:: ----------
:: EN PDF
:: ----------
pushd %scriptdir%
powershell -NoProfile -ExecutionPolicy Bypass ^
  ".\CollectConfig.ps1 \"%hugodir%\public_%hugo_env%\en\";exit $LASTEXITCODE"
powershell -NoProfile -ExecutionPolicy Bypass ^
  ".\vivliocli.ps1 -dir \"%hugodir%\public_%hugo_env%\en\*.*\";exit $LASTEXITCODE"
popd
if not %errorlevel% == 0 exit /B 1

echo build was completed.
exit /B 0