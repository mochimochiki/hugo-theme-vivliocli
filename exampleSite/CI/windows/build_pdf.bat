@echo off

:: set config
if "%1" == "" (
  echo "arg1:config was not specified. Build with [pdf.toml] ..."
  set hugo_env="pdf"
) else (
  set hugo_env=%1
)

set scriptdir=%~dp0
set hugodir=%~dp0..\..
set publish_dir=public_%hugo_env%

:: override ispdf=true
set HUGO_PARAMS_ISPDF=true

:: Hugo build
@echo -------------------------------------
@echo Build Hugo site
@echo config          : %hugo_env%.toml
@echo target directory: %publish_dir%
@echo -------------------------------------
pushd %hugodir%
if exist %publish_dir% ( rmdir /s /q %publish_dir% )
hugo --config "config/default.toml","config/%hugo_env%.toml" -b "" -d %publish_dir%
if not %errorlevel% == 0 exit /B 1
popd

:: npm setup
pushd %scriptdir%
@echo.
@echo -------------------------------------
@echo node version
node -v
@echo npm version
call npm -v
@echo npx version
call npx -v
@echo -------------------------------------
call npm install
popd

:: pre rendering
pushd %scriptdir%
powershell -NoProfile -ExecutionPolicy Bypass ^
  ".\pre_js_rendering.ps1 -dir \"%hugodir%\%publish_dir%\" -logname pre_js_rendering.log;exit $LASTEXITCODE"
popd
if not %errorlevel% == 0 exit /B 1

:: PDF build
pushd %scriptdir%
for /d %%A in (%hugodir%\content\*) do (
  @echo.
  @echo -------------------------------------
  @echo Build PDF 
  @echo Language: %%~nA
  @echo -------------------------------------
  powershell -NoProfile -ExecutionPolicy Bypass ".\CollectConfig.ps1 \"%hugodir%\%publish_dir%\%%~nA\";"
  powershell -NoProfile -ExecutionPolicy Bypass ".\vivliocli.ps1 -dir \"%hugodir%\%publish_dir%\%%~nA\*.*\";"
  if not %errorlevel% == 0 exit /B 1
)
popd

@echo.
@echo build was completed.
exit /B 0