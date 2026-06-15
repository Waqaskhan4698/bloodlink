@echo off
REM BloodLink Development Server Startup Script

cls
echo.
echo =====================================
echo   BloodLink Development Environment
echo =====================================
echo.

REM Check if Node.js is installed
if exist "C:\Program Files\nodejs\node.exe" (
    echo [OK] Node.js found at C:\Program Files\nodejs
) else (
    echo [ERROR] Node.js not found! Please install Node.js first.
    pause
    exit /b 1
)

REM Set PATH
set PATH=C:\Program Files\nodejs;%PATH%

echo [OK] PATH updated with Node.js
echo.

REM Show Node.js version
echo [INFO] Node.js versions:
"C:\Program Files\nodejs\node.exe" --version
"C:\Program Files\nodejs\npm.cmd" --version
echo.

REM Start backend server in a new window
echo [*] Starting Backend Server on http://localhost:5000...
start "BloodLink Backend (Port 5000)" cmd /k ^
  set PATH=C:\Program Files\nodejs;%PATH%& ^
  cd /d "%cd%\backend" & ^
  "C:\Program Files\nodejs\node.exe" server.js

timeout /t 3 /nobreak

REM Start frontend server in a new window
echo [*] Starting Frontend Server on http://localhost:3000...
start "BloodLink Frontend (Port 3000)" cmd /k ^
  set PATH=C:\Program Files\nodejs;%PATH%& ^
  cd /d "%cd%\frontend" & ^
  "C:\Program Files\nodejs\npm.cmd" start

echo.
echo =====================================
echo [SUCCESS] Both servers are starting!
echo =====================================
echo.
echo Backend: http://localhost:5000
echo Frontend: http://localhost:3000
echo.
pause
