@echo off
chcp 65001 >nul
set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8

echo ==============================================================================
echo                 STARTING AI TRAFFIC VISION APPLICATION
echo ==============================================================================
echo Backend API: http://127.0.0.1:8080
echo Simple Studio: http://127.0.0.1:8080/simple.html
echo Full Dashboard: http://localhost:5173
echo.

:: Start backend in separate console window
start "AI Traffic Vision - Backend API" cmd /k run_backend.bat

echo Waiting for backend server to initialize...
powershell -Command "for ($i=0; $i -lt 40; $i++) { try { $res = Invoke-WebRequest -Uri 'http://127.0.0.1:8080/simple.html' -UseBasicParsing -TimeoutSec 2; if ($res.StatusCode -eq 200) { Write-Host 'Backend is READY!'; exit 0 } } catch { Start-Sleep -Milliseconds 500 } }; exit 1"

:: Start frontend in separate console window
start "AI Traffic Vision - Frontend UI" cmd /k run_frontend.bat

echo Opening Simple Studio in browser...
start http://127.0.0.1:8080/simple.html
