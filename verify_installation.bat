@echo off
chcp 65001 >nul
set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8

echo ==============================================================================
echo        AI TRAFFIC VISION - INSTALLATION AND TEST VERIFICATION SUITE
echo ==============================================================================
echo.

call .venv\Scripts\activate.bat

echo [1/4] Checking Python and Hardware Environment...
python -c "import torch, sys; print('Python Version:', sys.version); print('PyTorch Version:', torch.__version__); print('CUDA Available:', torch.cuda.is_available()); print('Device Name:', torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'CPU (Standard)')"

echo.
echo [2/4] Checking Pretrained Models and Manifests...
python -c "import os; print('Vehicle Detector (YOLOv8):', 'READY' if os.path.exists('models/vehicle_detector/yolov8n.pt') else 'NOT FOUND'); print('Iranian Plate Detector (best.pt):', 'READY' if os.path.exists('models/plate_detector/best.pt') else 'NOT FOUND'); print('Plate OCR Model:', 'READY' if os.path.exists('models/plate_ocr/model_manifest.json') else 'NEEDS TRAINING')"

echo.
echo [3/4] Checking Database and Directory Structures...
python -c "from src.ai_traffic_vision.core.database import init_db, get_session_factory, Camera; init_db(); db = get_session_factory()(); print('Database Tables:', 'OK (Cameras:', db.query(Camera).count(), ')'); db.close()"

echo.
echo [4/4] Executing Automated PyTest Suite (Acceptance Criteria)...
pytest
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Some automated tests failed. Please inspect the log above.
    pause
    exit /b 1
)

echo.
echo ==============================================================================
echo               ALL SYSTEM CHECKS AND UNIT TESTS PASSED!
echo ==============================================================================
echo The application is verified and ready to run locally on Windows 11.
echo Run 'run.bat' to start the application.
echo.
pause
