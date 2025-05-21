@echo off
echo [START] Starting server bootstrap...

:: STEP 1: Load BASE_DIR and environment variables
call "%~dp0helpers\load-env.bat"
call "%~dp0helpers\show-env.bat"

:: STEP 2: Prepare build folder and server files
call "%BASE_DIR%\src\scripts\win11\helpers\ensure-build-folder.bat"
call "%BASE_DIR%\src\scripts\win11\helpers\download-server.jar.bat"
call "%BASE_DIR%\src\scripts\win11\helpers\copy-server.jar-to-build.bat"
call "%BASE_DIR%\src\scripts\win11\helpers\generate-eula.bat"
call "%BASE_DIR%\src\scripts\win11\helpers\generate-server.properties.bat"

:: STEP 3: (optional) Backup before launch
call "%BASE_DIR%\src\scripts\win11\helpers\create-backup.bat"

:: STEP 4: Show IPs
call "%BASE_DIR%\src\scripts\win11\helpers\print-server-address.bat"

:: STEP 5: Launch server
cd /d "%BASE_DIR%\build\%WORLD_NAME%"
echo Running from: %CD%
java -Xms%XMS% -Xmx%XMX% -jar server.jar

echo [DONE] Server process exited.
pause
