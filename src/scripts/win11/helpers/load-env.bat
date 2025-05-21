@echo off
:: ===============================================================
:: initialise environment for all helpers
:: BASE_DIR  - project root
:: ===============================================================

:: STEP 1 – go to script folder (...\src\scripts\helpers)
cd /d "%~dp0"

:: STEP 2 – climb three levels up (to project root) and set BASE_DIR
cd ..\..\..
set "BASE_DIR=%CD%"

:: STEP 3 – fixed config path (src\config\config.ini)
set "CFG=%BASE_DIR%\src\config\config.ini"
echo [START] Loading variables from %CFG%

:: STEP 4 – verify config file exists; show error & (pause on DEBUG) then abort
if not exist "%CFG%" (
    echo [ERROR] config.ini not found at %CFG%
    if /I "%DEBUG%"=="true" pause
    exit /b 1
)

:: STEP 5 – load KEY=VALUE pairs
for /f "usebackq tokens=1,* delims==" %%A in ("%CFG%") do (
    set "%%A=%%B"
)

:: STEP 6 – optional debug pause
echo [DONE] Environment variables loaded.
if /I "%DEBUG%"=="true" pause
