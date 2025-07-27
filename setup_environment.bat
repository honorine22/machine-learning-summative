@echo off

REM Employment Rate Predictor - Environment Setup Script for Windows
REM This script sets up the Python environment for the API

echo 🚀 Setting up Employment Rate Predictor Environment...

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python is not installed. Please install Python 3.9 or higher.
    pause
    exit /b 1
)

REM Navigate to API directory
cd summative\API

echo 📁 Current directory: %CD%

REM Create virtual environment
echo 🐍 Creating virtual environment...
python -m venv venv

REM Activate virtual environment
echo 🔧 Activating virtual environment...
call venv\Scripts\activate.bat

REM Upgrade pip
echo ⬆️  Upgrading pip...
python -m pip install --upgrade pip

REM Install dependencies
echo 📦 Installing dependencies...
pip install -r requirements.txt

echo ✅ Environment setup complete!
echo.
echo 🎯 To activate the environment in the future:
echo    cd summative\API
echo    venv\Scripts\activate.bat
echo.
echo 🚀 To run the API:
echo    uvicorn prediction:app --reload --host 0.0.0.0 --port 8000
echo.
echo 🌐 API will be available at: http://localhost:8000
echo 📚 API documentation at: http://localhost:8000/docs
echo.
pause 