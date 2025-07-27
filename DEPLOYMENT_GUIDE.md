# Deployment Guide

## 🚀 Render Deployment

### 1. API Deployment on Render

**Build Command:**
```bash
pip install -r requirements.txt
```

**Start Command:**
```bash
uvicorn prediction:app --host 0.0.0.0 --port $PORT
```

**Environment Variables:**
- `PORT`: Automatically set by Render
- `PYTHON_VERSION`: `3.9` or `3.10`

### 2. Flutter Web Deployment

**Build Command:**
```bash
flutter build web --release
```

**Start Command:**
```bash
cd build/web && python -m http.server $PORT
```

## 🐍 Python Environment Setup

### Option 1: Using venv (Recommended)

```bash
# Navigate to API directory
cd summative/API

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On macOS/Linux:
source venv/bin/activate
# On Windows:
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run the API locally
uvicorn prediction:app --reload --host 0.0.0.0 --port 8000
```

### Option 2: Using conda

```bash
# Create conda environment
conda create -n employment-predictor python=3.9

# Activate environment
conda activate employment-predictor

# Install dependencies
pip install -r requirements.txt

# Run the API
uvicorn prediction:app --reload --host 0.0.0.0 --port 8000
```

### Option 3: Using pipenv

```bash
# Install pipenv if not installed
pip install pipenv

# Create environment and install dependencies
pipenv install

# Activate environment
pipenv shell

# Run the API
uvicorn prediction:app --reload --host 0.0.0.0 --port 8000
```

## 📱 Flutter Development Setup

### Prerequisites
- Flutter SDK installed
- Android Studio / VS Code with Flutter extensions
- Android emulator or physical device

### Setup Commands

```bash
# Navigate to Flutter app directory
cd summative/FlutterApp

# Get dependencies
flutter pub get

# Run on Android emulator
flutter run

# Run on iOS simulator (macOS only)
flutter run -d ios

# Build for web
flutter build web

# Build for Android APK
flutter build apk --release
```

## 🔧 API Configuration

### Update API URL in Flutter App

After deploying your API to Render, update the URL in `summative/FlutterApp/lib/main.dart`:

```dart
// Replace this line in the _submit() method:
final response = await http.post(
  Uri.parse('https://your-app-name.onrender.com/predict'), // Update this URL
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode(data),
);
```

### Environment Variables for Production

Create a `.env` file in the API directory:

```env
PORT=8000
MODEL_PATH=best_model_random_forest.pkl
SCALER_PATH=feature_scaler.pkl
DEBUG=False
```

## 🧪 Testing the API

### Local Testing

```bash
# Start the API
uvicorn prediction:app --reload --host 0.0.0.0 --port 8000

# Test with curl
curl -X POST "http://localhost:8000/predict" \
  -H "Content-Type: application/json" \
  -d '{
    "school_enrollment_primary": 85.5,
    "school_enrollment_secondary": 72.3,
    "literacy_rate": 78.9,
    "urban_population_percent": 65.0,
    "gdp_per_capita": 3500.0,
    "population": 15000000.0,
    "life_expectancy": 68.5
  }'
```

### Health Check

```bash
curl http://localhost:8000/health
```

## 📊 Model Files

Ensure these files are in your API directory:
- `best_model_random_forest.pkl` (or other model files)
- `feature_scaler.pkl` (optional)

## 🚨 Troubleshooting

### Common Issues

1. **Port already in use:**
   ```bash
   # Find process using port 8000
   lsof -i :8000
   # Kill the process
   kill -9 <PID>
   ```

2. **Flutter dependencies issues:**
   ```bash
   flutter clean
   flutter pub get
   ```

3. **Python package conflicts:**
   ```bash
   pip uninstall -r requirements.txt
   pip install -r requirements.txt
   ```

4. **CORS issues:**
   - The API already includes CORS middleware
   - Ensure the Flutter app URL is correct

### Render Deployment Tips

1. **Build timeout:** Increase build timeout in Render settings
2. **Memory issues:** Upgrade to a higher tier if needed
3. **Cold starts:** Use Render's "Always On" feature for better performance

## 📱 Mobile App Testing

### Android
```bash
flutter run -d android
```

### iOS
```bash
flutter run -d ios
```

### Web
```bash
flutter run -d chrome
```

## 🔄 Continuous Deployment

### GitHub Actions (Optional)

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Render

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Deploy to Render
      env:
        RENDER_TOKEN: ${{ secrets.RENDER_TOKEN }}
        RENDER_SERVICE_ID: ${{ secrets.RENDER_SERVICE_ID }}
      run: |
        curl -X POST "https://api.render.com/v1/services/$RENDER_SERVICE_ID/deploys" \
          -H "Authorization: Bearer $RENDER_TOKEN" \
          -H "Content-Type: application/json"
```

## 📈 Performance Monitoring

### API Monitoring
- Use Render's built-in monitoring
- Check logs in Render dashboard
- Monitor response times and error rates

### Flutter App Monitoring
- Use Firebase Analytics (optional)
- Monitor app crashes and performance
- Track user engagement metrics 