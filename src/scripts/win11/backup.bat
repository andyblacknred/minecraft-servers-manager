@echo off
echo [START] Manual backup trigger...

call "%~dp0helpers\load-env.bat"
call "%~dp0helpers\show-env.bat"
call "%BASE_DIR%\src\scripts\win11\helpers\create-backup.bat"

echo [DONE] Backup created.
pause