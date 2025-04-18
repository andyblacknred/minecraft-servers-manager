@echo off
:: ===============================================================
::  • Checks if %VERSION%.jar exists in cache\versions
::  • Downloads from Mojang if missing
:: ===============================================================

:: STEP 2 – prepare path to the cached JAR
set "JAR_CACHE=%BASE_DIR%\cache\versions\%VERSION%.jar"

:: STEP 3 – skip download if already cached
if exist "%JAR_CACHE%" (
    echo [CACHE] Found server.jar - %JAR_CACHE%
    if /I "%DEBUG%"=="true" pause
    exit /b 0
)

:: STEP 4 – download JAR into cache
echo [DOWNLOAD] %VERSION% not found in cache - downloading
mkdir "%BASE_DIR%\cache\versions" >nul 2>&1

powershell -NoLogo -NoProfile -Command ^
  "$v = '%VERSION%';" ^
  "$man = Invoke-RestMethod 'https://piston-meta.mojang.com/mc/game/version_manifest.json';" ^
  "$entry = $man.versions | Where-Object { $_.id -eq $v };" ^
  "if (-not $entry) { Write-Error 'Version not found'; exit 1 };" ^
  "$meta = Invoke-RestMethod $entry.url;" ^
  "$url = $meta.downloads.server.url.TrimStart([char]0xFEFF);" ^
  "Write-Host '[INFO] Download URL -' $url;" ^
  "Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile '%JAR_CACHE%'"

:: STEP 5 – verify download success
if not exist "%JAR_CACHE%" (
    echo [ERROR] Download failed for %VERSION%.
    if /I "%DEBUG%"=="true" pause
    exit /b 1
)
echo [DONE] Downloaded - %JAR_CACHE%

:: STEP 6 – diagnostics: file size
echo [INFO] Cached JAR size:
for %%I in ("%JAR_CACHE%") do echo    %%~nxI = %%~zI bytes

:: STEP 7 – diagnostics: check magic bytes (should print "50-4B")
echo [INFO] Checking magic bytes:
powershell -NoLogo -NoProfile -Command ^
  "$fs = [IO.File]::OpenRead('%JAR_CACHE%');" ^
  "$buf = New-Object Byte[] 2;" ^
  "$fs.Read($buf,0,2) | Out-Null;" ^
  "$fs.Close();" ^
  "Write-Host '[DEBUG] Magic bytes:' ([BitConverter]::ToString($buf))"

:: STEP 8 – optional debug pause
if /I "%DEBUG%"=="true" pause

exit /b 0
