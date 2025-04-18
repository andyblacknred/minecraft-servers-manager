@echo off
:: ===============================================================
::  • Takes src\config\server.template.properties
::  • Substitutes WORLD_NAME, PORT, MOTD - writes to build\<WORLD_NAME>\
:: ===============================================================

echo [START] Generating server.properties from template

:: STEP 1 – PowerShell: read template -> make substitutions - write file
powershell -NoLogo -NoProfile -Command ^
  "$w='%WORLD_NAME%';$p='%PORT%';$m='%MOTD%';" ^
  "$tpl=Get-Content '%BASE_DIR%\\src\\config\\server.template.properties';" ^
  "$tpl=$tpl -replace '@WORLD_NAME@',$w;" ^
  "$tpl=$tpl -replace '@PORT@',$p;" ^
  "$tpl=$tpl -replace '@MOTD@',$m;" ^
  "$tpl | Set-Content '%BASE_DIR%\\build\\%WORLD_NAME%\\server.properties' -Encoding UTF8"

echo [DONE] server.properties created - build\%WORLD_NAME%\server.properties

:: STEP 3 – optional debug pause
if /I "%DEBUG%"=="true" pause
exit /b 0
