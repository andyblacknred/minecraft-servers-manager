@echo off
echo [START] Show versions...

call "%~dp0helpers\load-env.bat"
call "%~dp0helpers\show-env.bat"
call "%BASE_DIR%\src\scripts\win11\helpers\show-versions-list.bat"

echo [DONE] End of the versions list.
pause