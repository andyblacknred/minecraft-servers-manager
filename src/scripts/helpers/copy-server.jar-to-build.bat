@echo off
:: ===============================================================
::  • Copies %VERSION%.jar from cache\versions to build\<WORLD_NAME>\
:: ===============================================================

:: STEP 1 – compose source and destination paths
set "JAR_CACHE=%BASE_DIR%\cache\versions\%VERSION%.jar"
set "BUILD_DIR=%BASE_DIR%\build\%WORLD_NAME%"
set "JAR_BUILD=%BUILD_DIR%\server.jar"

:: STEP 2 – debug dump (only if DEBUG=true)
if /I "%DEBUG%"=="true" (
    echo [DEBUG] BASE_DIR   = %BASE_DIR%
    echo [DEBUG] VERSION    = %VERSION%
    echo [DEBUG] WORLD_NAME = %WORLD_NAME%
    echo [DEBUG] JAR_CACHE  = %JAR_CACHE%
    echo [DEBUG] BUILD_DIR  = %BUILD_DIR%
    echo [DEBUG] JAR_BUILD  = %JAR_BUILD%
)

:: STEP 3 – verify cached JAR exists
if not exist "%JAR_CACHE%" (
    echo [ERROR] Cached server.jar not found: %JAR_CACHE%
    if /I "%DEBUG%"=="true" pause
    exit /b 1
)

:: STEP 4 – ensure build folder exists
if not exist "%BUILD_DIR%" (
    echo [CREATE] Making build folder: %BUILD_DIR%
    mkdir "%BUILD_DIR%"
) else (
    echo [SKIP] Build folder already exists: %BUILD_DIR%
)

:: STEP 5 – copy JAR into build
echo [COPY] "%JAR_CACHE%" - "%JAR_BUILD%"
copy /Y "%JAR_CACHE%" "%JAR_BUILD%" >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Failed to copy server.jar to build folder.
    if /I "%DEBUG%"=="true" pause
    exit /b 1
)

:: STEP 6 – confirm success
echo [DONE] server.jar is ready at: %JAR_BUILD%

:: STEP 7 – optional debug pause
if /I "%DEBUG%"=="true" pause

exit /b 0
