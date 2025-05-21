@echo off
:: ==============================================================
::  print current environment variables
:: ==============================================================

echo [START] Printing environment variables

echo ==================  ACTIVE ENV  ==================
echo BASE_DIR      = %BASE_DIR%
echo WORLD_NAME    = %WORLD_NAME%
echo MOTD          = %MOTD%
echo DEBUG         = %DEBUG%
echo VERSION       = %VERSION%
echo PORT          = %PORT%
echo XMS           = %XMS%
echo XMX           = %XMX%
echo ==================================================

:: Optional full dump
if /I "%DEBUG%"=="true" (
    echo ------------------  FULL DUMP  ------------------
    set
    echo --------------------------------------------------
)

echo [END] Environment variables printed.

if /I "%DEBUG%"=="true" pause
