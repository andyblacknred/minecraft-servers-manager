@echo off
:: ===============================================================
::  • Copies world folder and key config files into timestamped
::    backup\%WORLD_NAME%\snapshots\<YYYY-MM-DD_HH-MM>\ …
:: ===============================================================

echo [START] Creating backup …

:: STEP 1 – compose paths and timestamp
set "SOURCE=%BASE_DIR%\build\%WORLD_NAME%"
set "DEST=%BASE_DIR%\backup\%WORLD_NAME%\snapshots"
set DATETIME=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%-%TIME:~3,2%
set DATETIME=%DATETIME: =0%
set "TARGET=%DEST%\%DATETIME%"

:: STEP 2 – create target folder
mkdir "%TARGET%"

:: STEP 3 – copy world folder and key configs
xcopy "%SOURCE%\%WORLD_NAME%" "%TARGET%\%WORLD_NAME%" /E /I /H /Y >nul
xcopy "%SOURCE%\server.properties" "%TARGET%\"            /Y >nul
xcopy "%SOURCE%\ops.json"          "%TARGET%\"            /Y >nul
xcopy "%SOURCE%\whitelist.json"    "%TARGET%\"            /Y >nul

:: STEP 4 – finish message
echo [DONE] Backup saved in - %TARGET%

:: STEP 5 – optional debug pause
if /I "%DEBUG%"=="true" pause
exit /b 0
