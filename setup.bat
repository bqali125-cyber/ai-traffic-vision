@echo off
chcp 65001 >nul
set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8

echo ==============================================================================
echo        AI TRAFFIC VISION - WINDOWS 11 AUTOMATED SETUP WIZARD
echo ==============================================================================
echo.

:: 1. Check Python
echo [1/7] Checking Python installation...
python --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Python was not found in PATH. Please install Python 3.10+ and add it to PATH.
    pause
    exit /b 1
)
python --version

:: 2. Check Node.js and npm
echo.
echo [2/7] Checking Node.js and npm...
node --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [WARNING] Node.js was not found. Frontend development mode requires Node.js.
) else (
    node --version
    npm --version
)

:: 3. Setup Virtual Environment
echo.
echo [3/7] Setting up Python virtual environment (.venv)...
if not exist ".venv\Scripts\python.exe" (
    python -m venv .venv
    echo Virtual environment created at .venv.
) else (
    echo Virtual environment already exists at .venv.
)

:: 4. Install Dependencies
echo.
echo [4/7] Installing backend dependencies...
call .venv\Scripts\activate.bat
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

:: 5. Initialize Database & Directory Tree
echo.
echo [5/7] Initializing database and storage directories...
python -c "from src.ai_traffic_vision.core.database import init_db; from src.ai_traffic_vision.core.config import settings; settings.resolve_paths(); init_db(); print('Database initialized successfully.')"

:: 6. Setup Frontend Build
echo.
echo [6/7] Setting up frontend dashboard...
if exist "frontend\package.json" (
    cd frontend
    call npm install
    call npm run build
    cd ..
)

:: 7. Check Hardware and Pretrained Models
echo.
echo [7/7] Verifying models and GPU acceleration...
python -c "import torch; print('CUDA GPU Available:', torch.cuda.is_available()); print('Device Name:', torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'CPU (Lightweight Inference)')"
python -c "import os; print('Vehicle Detector Model:', 'Found' if os.path.exists('models/vehicle_detector/yolov8n.pt') else 'Missing'); print('Iranian Plate Detector:', 'Found' if os.path.exists('models/plate_detector/best.pt') else 'Missing'); print('Plate OCR Templates:', 'Found' if os.path.exists('models/plate_ocr/model_manifest.json') else 'Needs training')"

echo.
echo ==============================================================================
echo                   SETUP COMPLETED SUCCESSFULLY!
echo ==============================================================================
echo To start the application, simply run:
echo     run.bat
echo Or run backend and frontend separately:
echo     run_backend.bat
echo     run_frontend.bat
echo.
pause
