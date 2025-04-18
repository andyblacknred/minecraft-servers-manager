@echo off
:: ===============================================================
::  • Creates build\<WORLD_NAME>\eula.txt from eula.template.txt
::  • Inserts current timestamp on 2nd line, preserves leading “#”
:: ===============================================================

echo [START] Generating eula.txt

:: STEP 1 – define template and output paths
set "TPL=%BASE_DIR%\src\config\eula.template.txt"
set "OUT=%BASE_DIR%\build\%WORLD_NAME%\eula.txt"

:: STEP 2 – skip if already exists
if exist "%OUT%" (
    echo [SKIP] eula.txt already exists - %OUT%
    if /I "%DEBUG%"=="true" pause
    exit /b 0
)

:: STEP 3 – check if template exists
if not exist "%TPL%" (
    echo [ERROR] Template not found - %TPL%
    if /I "%DEBUG%"=="true" pause
    exit /b 1
)

:: STEP 4 – copy template as base
copy /Y "%TPL%" "%OUT%" >nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to copy template to: %OUT%
    if /I "%DEBUG%"=="true" pause
    exit /b 1
)

:: STEP 5 – update 2nd line with current timestamp
powershell -NoLogo -NoProfile -Command ^
    "$f = '%OUT%';" ^
    "$lines = Get-Content $f;" ^
    "$now = Get-Date;" ^
    "$abbr = ('EET','EEST')[[TimeZone]::CurrentTimeZone.IsDaylightSavingTime($now)];" ^
    "$culture = [System.Globalization.CultureInfo]::GetCultureInfo('en-US');" ^
    "$lines[1] = '#' + $now.ToString('ddd MMM dd HH:mm:ss', $culture) + ' ' + $abbr + ' ' + $now.Year;" ^
    "Set-Content -Path $f -Value $lines -Encoding UTF8"

echo [DONE] eula.txt created - %OUT%

:: STEP 6 – optional debug pause
if /I "%DEBUG%"=="true" pause
exit /b 0
