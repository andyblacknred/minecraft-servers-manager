@echo off
:: STEP 1 – ensure build\<WORLD_NAME> directory exists
set "BUILD_DIR=%BASE_DIR%\build\%WORLD_NAME%"

if not exist "%BUILD_DIR%" (
    echo [CREATE] Creating build folder: %BUILD_DIR%
    mkdir "%BUILD_DIR%"
) else (
    echo [SKIP] Build folder already exists: %BUILD_DIR%
)

:: STEP 2 – optional pause when DEBUG=true
if /I "%DEBUG%"=="true" pause
