@echo off
chcp 65001 >nul
set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8

echo ==============================================================================
echo       AI TRAFFIC VISION - SIMPLE VIDEO PROCESSING STUDIO
echo ==============================================================================
echo Starting backend server on http://127.0.0.1:8080 ...
echo The Simple Studio will open automatically in your browser in a few seconds...
echo.

call .venv\Scripts\activate.bat

:: Launch browser in background after 3 seconds
start "" powershell -WindowStyle Hidden -Command "Start-Sleep -Seconds 3; Start-Process 'http://127.0.0.1:8080/simple.html'"

:: Run Uvicorn directly in this window so it stays open and shows live logs
python -m uvicorn src.ai_traffic_vision.api.app:app --host 127.0.0.1 --port 8080
