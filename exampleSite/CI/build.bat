@echo off
chcp 65001
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
:: math convert
:: ----------
pushd %scriptdir%\MathConverter
powershell -NoProfile -ExecutionPolicy RemoteSigned ^
  ".\MathConverter.ps1 -dir \"%hugodir%\public_%hugo_env%\" -logname MathConverter_%hugo_env%.log;exit $LASTEXITCODE"
popd
if not %errorlevel% == 0 exit /B 1


:: ----------
:: JP PDF
:: ----------
pushd %scriptdir%
powershell -NoProfile -ExecutionPolicy RemoteSigned ^
  ".\CollectConfig.ps1 \"%hugodir%\public_%hugo_env%\jp\";exit $LASTEXITCODE"
powershell -NoProfile -ExecutionPolicy RemoteSigned ^
  ".\vivliocli.ps1 -dir \"%hugodir%\public_%hugo_env%\jp\*.*\";exit $LASTEXITCODE"
popd
if not %errorlevel% == 0 exit /B 1

:: ----------
:: EN PDF
:: ----------
pushd %scriptdir%
powershell -NoProfile -ExecutionPolicy RemoteSigned ^
  ".\CollectConfig.ps1 \"%hugodir%\public_%hugo_env%\en\";exit $LASTEXITCODE"
powershell -NoProfile -ExecutionPolicy RemoteSigned ^
  ".\vivliocli.ps1 -dir \"%hugodir%\public_%hugo_env%\en\*.*\";exit $LASTEXITCODE"
popd
if not %errorlevel% == 0 exit /B 1

echo build was completed.
exit /B 0