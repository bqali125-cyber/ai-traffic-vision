@echo off
chcp 65001 >nul
set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8

echo Starting AI Traffic Vision Backend (FastAPI on http://127.0.0.1:8080)...
call .venv\Scripts\activate.bat
python -m uvicorn src.ai_traffic_vision.api.app:app --host 127.0.0.1 --port 8080 --reload
pause
