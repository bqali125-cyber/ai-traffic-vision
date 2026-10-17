@echo off
chcp 65001 >nul

echo Starting AI Traffic Vision Frontend (Vite Dev Server on http://localhost:5173)...
cd frontend
npm run dev
pause
