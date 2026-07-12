@echo off
setlocal

for /f %%i in ('git rev-parse --short HEAD') do set GIT_COMMIT=%%i

for /f "delims=" %%i in ('powershell -NoProfile -Command "Get-Date -Format s"') do set BUILD_DATE=%%i

echo Building hardware-tools...
echo   Commit : %GIT_COMMIT%
echo   Date   : %BUILD_DATE%
echo.

docker compose build

if errorlevel 1 exit /b %errorlevel%
docker compose up -d --force-recreate

endlocal