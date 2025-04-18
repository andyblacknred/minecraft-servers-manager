@echo off
:: ===============================================================
::  • Detects local LAN IPv4 and (optionally) Radmin‑VPN IPv4
::  • Prints both addresses with the configured PORT
:: ===============================================================

echo [START] Detecting server addresses

:: STEP 1 – obtain first non‑Radmin, non‑APIPA local IPv4
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /i "IPv4" ^| findstr /v "169." ^| findstr /v "26."') do (
    if not defined LOCAL_IP set "LOCAL_IP=%%A"
)

:: STEP 2 trim leading space
set "LOCAL_IP=%LOCAL_IP:~1%"

:: STEP 3 – obtain first Radmin‑VPN IPv4 (26.x.x.x) if present
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /i "IPv4" ^| findstr "26."') do (
    if not defined RADMIN_IP set "RADMIN_IP=%%A"
)
if defined RADMIN_IP (
    set "RADMIN_IP=%RADMIN_IP:~1%"
    set "RADMIN_LINE=  Radmin VPN:  %RADMIN_IP%:%PORT%"
) else (
    set "RADMIN_LINE=  Radmin VPN:  Not found"
)

:: STEP 4 – pretty output
echo.
echo ==================================================
echo   Minecraft Server is starting
echo.
echo   Local IP:    %LOCAL_IP%:%PORT%
echo %RADMIN_LINE%
echo ==================================================
echo.

:: STEP 5 – optional debug pause
if /I "%DEBUG%"=="true" pause
exit /b 0
