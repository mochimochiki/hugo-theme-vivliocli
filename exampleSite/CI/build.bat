@echo off
set scriptdir=%~dp0
set hugodir=%~dp0..
pushd %hugodir%

if "%1" == "" (
  echo "arg1:environment was not specified. Build with [pdf] environment..."
  set hugo_env=pdf_sample
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
if not %errorlevel% == 0 exit /B 1

:: ----------
:: JP PDF
:: ----------
vivliostyle build -c public_%hugo_env%\jp\index.js
if not %errorlevel% == 1 exit /B 1


popd

echo build was completed.
exit /B 0