@echo off
:: ===============================================================
::  • Retrieves all available Minecraft version IDs
:: ===============================================================

echo [START] Fetching Minecraft version list...

:: STEP 1 – fetch & print version IDs (multi-line PowerShell)
powershell -NoLogo -NoProfile -Command ^
  "$response = Invoke-RestMethod 'https://piston-meta.mojang.com/mc/game/version_manifest.json';" ^
  "$versions = $response.versions;" ^
  "foreach ($v in $versions) { $v.id }"

:: STEP 2 – completion notice
echo [DONE] Version list fetched.

:: STEP 3 – optional debug pause
if /I "%DEBUG%"=="true" pause

exit /b 0
