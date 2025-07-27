#!/bin/bash

# Employment Rate Predictor - Environment Setup Script
# This script sets up the Python environment for the API

echo "🚀 Setting up Employment Rate Predictor Environment..."

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3.9 or higher."
    exit 1
fi

# Get Python version
PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
echo "🐍 Python version detected: $PYTHON_VERSION"

# Check if Python 3.13 and provide warning
if [[ "$PYTHON_VERSION" == "3.13" ]]; then
    echo "⚠️  Python 3.13 detected. Some packages may have compatibility issues."
    echo "💡 Consider using Python 3.11 or 3.12 for better compatibility."
    echo ""
    read -p "Do you want to continue with Python 3.13? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Setup cancelled. Please install Python 3.11 or 3.12."
        exit 1
    fi
fi

# Navigate to API directory
cd summative/API

echo "📁 Current directory: $(pwd)"

# Remove existing venv if it exists
if [ -d "venv" ]; then
    echo "🗑️  Removing existing virtual environment..."
    rm -rf venv
fi

# Create virtual environment
echo "🐍 Creating virtual environment..."
python3 -m venv venv

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
echo "⬆️  Upgrading pip..."
pip install --upgrade pip

# Install setuptools and wheel first
echo "🔧 Installing build tools..."
pip install --upgrade setuptools wheel

# Try to install dependencies with fallback
echo "📦 Installing dependencies..."

# First try with the main requirements file
if pip install -r requirements.txt; then
    echo "✅ Dependencies installed successfully!"
else
    echo "⚠️  Installation failed with main requirements. Trying Python 3.13 compatible versions..."
    
    # Try with Python 3.13 specific requirements
    if [ -f "requirements_python313.txt" ]; then
        if pip install -r requirements_python313.txt; then
            echo "✅ Dependencies installed successfully with Python 3.13 compatible versions!"
        else
            echo "❌ Installation failed. Trying individual packages..."
            
            # Install packages one by one with latest versions
            pip install fastapi uvicorn pydantic joblib numpy pandas scikit-learn python-multipart
        fi
    else
        echo "❌ Python 3.13 requirements file not found. Installing latest versions..."
        pip install fastapi uvicorn pydantic joblib numpy pandas scikit-learn python-multipart
    fi
fi

echo "✅ Environment setup complete!"
echo ""
echo "🎯 To activate the environment in the future:"
echo "   cd summative/API"
echo "   source venv/bin/activate"
echo ""
echo "🚀 To run the API:"
echo "   uvicorn prediction:app --reload --host 0.0.0.0 --port 8000"
echo ""
echo "🌐 API will be available at: http://localhost:8000"
echo "📚 API documentation at: http://localhost:8000/docs"
echo ""
echo "🔧 If you encounter issues, try:"
echo "   pip install --upgrade pip setuptools wheel"
echo "   pip install -r requirements.txt --no-cache-dir" 