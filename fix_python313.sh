#!/bin/bash

# Fix script for Python 3.13 compatibility issues

echo "🔧 Fixing Python 3.13 compatibility issues..."

# Navigate to API directory
cd summative/API

# Activate virtual environment if it exists
if [ -d "venv" ]; then
    echo "🔧 Activating virtual environment..."
    source venv/bin/activate
else
    echo "❌ Virtual environment not found. Please run setup_environment.sh first."
    exit 1
fi

echo "⬆️  Upgrading pip and build tools..."
pip install --upgrade pip setuptools wheel

echo "🧹 Clearing pip cache..."
pip cache purge

echo "📦 Installing packages with latest versions..."
pip install --upgrade fastapi uvicorn pydantic joblib numpy pandas scikit-learn python-multipart

echo "✅ Fix completed!"
echo ""
echo "🚀 Try running the API now:"
echo "   uvicorn prediction:app --reload --host 0.0.0.0 --port 8000" 