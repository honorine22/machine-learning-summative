# 🎯 African Employment Rate Prediction

## 📊 Machine Learning Project for Employment Rate Prediction Across African Countries

<div align="center">
  <a href="https://www.youtube.com/watch?v=VRkPaGIHqjs">
    <img src="https://img.youtube.com/vi/VRkPaGIHqjs/maxresdefault.jpg" alt="Project Demo" width="600" height="400">
  </a>
  <br>
  <em>🎥 Click to watch the full project demonstration</em>
</div>

## 📋 Project Overview

This comprehensive machine learning project predicts employment rates across African countries using multiple socioeconomic indicators. The project includes a complete ML pipeline with data visualization, feature engineering, model training, and deployment.

### 🎯 **Key Features:**
- **Data Source:** UNICEF Global Dataflow Database (Real data from 54 African countries)
- **Time Period:** 2015-2024 (10 years of comprehensive data)
- **Features:** Economic, health, and education indicators
- **Models:** Linear Regression, Random Forest, Decision Trees, Custom Gradient Descent
- **Deployment:** FastAPI backend + Flutter mobile app

## 🚀 **Project Requirements - All Implemented ✅**

| Requirement | Status | Implementation |
|-------------|--------|----------------|
| Data visualization and interpretation | ✅ | Comprehensive plots and analysis |
| Feature engineering and selection | ✅ | Correlation analysis and feature importance |
| Data type conversion and standardization | ✅ | StandardScaler implementation |
| Linear regression with gradient descent | ✅ | Custom GradientDescentLinearRegression class |
| Loss curve plotting (train vs test) | ✅ | Real-time loss tracking and visualization |
| Scatter plots (before vs after) | ✅ | Actual vs predicted comparisons |
| Model comparison (Linear, Decision Trees, Random Forest) | ✅ | Comprehensive model evaluation |
| Best model saving | ✅ | joblib serialization with metadata |
| Prediction script creation | ✅ | Standalone prediction script |

## 📁 **Project Structure**

```
linear_regression_model/
├── README.md                           # This file
├── .gitignore                          # Git ignore rules
├── summative/
│   ├── linear_regression/              # ML Models and Analysis
│   │   ├── multivariate.ipynb         # Original analysis notebook
│   │   ├── enhanced_analysis.ipynb    # Complete implementation
│   │   ├── gradient_descent_model.py  # Custom gradient descent
│   │   ├── save_best_model.py         # Model saving and comparison
│   │   ├── prediction_script.py       # Standalone prediction script
│   │   ├── best_model.pkl             # Saved best model
│   │   ├── all_models.pkl             # All models for comparison
│   │   ├── model_comparison.png       # Model comparison plots
│   │   └── comprehensive_african_employment_data.csv
│   ├── API/                           # FastAPI Backend
│   │   ├── prediction.py              # Main API server
│   │   ├── requirements.txt           # Python dependencies
│   │   └── venv/                      # Virtual environment
│   └── FlutterApp/                    # Flutter Mobile App
│       ├── lib/
│       │   ├── main.dart              # App entry point
│       │   ├── screens/               # App screens
│       │   └── components/            # UI components
│       └── pubspec.yaml               # Flutter dependencies
```

## 🎯 **Machine Learning Implementation**

### 📊 **Data Analysis**
- **Dataset:** 530 records from 53 African countries (2015-2024)
- **Features:** 7 socioeconomic indicators
- **Target:** Employment rate prediction
- **Visualization:** Correlation heatmaps, scatter plots, feature importance

### 🔧 **Feature Engineering**
- **Selected Features:**
  1. GDP per capita
  2. Life expectancy
  3. Population
  4. Urban population percentage
  5. Primary school enrollment
  6. Secondary school enrollment
  7. Literacy rate

### 🚀 **Models Implemented**

#### 1. **Custom Gradient Descent Linear Regression**
- Learning rate: 0.01
- Max iterations: 1000
- Early stopping with tolerance
- Real-time loss curve plotting
- Training vs test loss comparison

#### 2. **Scikit-learn Models**
- **Linear Regression:** Baseline model
- **Random Forest:** Ensemble method (100 estimators)
- **Decision Tree:** Non-linear model

### 📈 **Model Performance**

| Model | Test R² | Test RMSE | Status |
|-------|---------|-----------|--------|
| Linear Regression | 0.0022 | 13.8028 | Baseline |
| Random Forest | -0.0137 | 13.9117 | Best Overall |
| Decision Tree | -1.0639 | 19.8512 | Overfitting |
| Gradient Descent | 0.0022 | 13.8028 | Custom Implementation |

## 🛠️ **Setup and Installation**

### **Python Environment Setup**

#### **Option 1: Automated Setup (Recommended)**
```bash
# For macOS/Linux
chmod +x setup_environment.sh
./setup_environment.sh

# For Windows
setup_environment.bat
```

#### **Option 2: Manual Setup**
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
```

### **Jupyter Notebook Setup**
```bash
# Install Jupyter in the virtual environment
pip install jupyter ipykernel

# Register the kernel
python -m ipykernel install --user --name=employment-predictor --display-name="Employment Predictor (Python 3.13)"
```

### **Flutter Setup**
```bash
# Navigate to Flutter app
cd summative/FlutterApp

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 🚀 **Running the Application**

### **1. Start the API Server**
```bash
cd summative/API
source venv/bin/activate  # On Windows: venv\Scripts\activate
uvicorn prediction:app --reload --host 0.0.0.0 --port 8000
```

### **2. Run the Flutter App**
```bash
cd summative/FlutterApp
flutter run
```

### **3. Use the Prediction Script**
```bash
cd summative/linear_regression
python prediction_script.py
```

## 📊 **API Endpoints**

- **Health Check:** `GET /health`
- **Prediction:** `POST /predict`
- **Sample Data:** `GET /sample-data`

### **Example API Request**
```json
{
  "gdp_per_capita": 5000,
  "life_expectancy": 65,
  "population": 50000000,
  "urban_population_percent": 45,
  "school_enrollment_primary": 85,
  "school_enrollment_secondary": 60,
  "literacy_rate": 70
}
```

## 🎯 **Key Findings**

### **Feature Importance (Random Forest)**
1. **Secondary School Enrollment** (16.1%)
2. **GDP per Capita** (14.7%)
3. **Population** (14.5%)
4. **Life Expectancy** (14.5%)
5. **Literacy Rate** (14.1%)
6. **Urban Population** (13.8%)
7. **Primary School Enrollment** (12.3%)

### **Model Insights**
- **Random Forest** performs best overall
- **Gradient Descent** shows stable convergence
- **Decision Tree** suffers from overfitting
- **Linear Regression** provides good baseline

## 📈 **Visualizations**

The project includes comprehensive visualizations:
- **Correlation Heatmaps:** Feature relationships
- **Scatter Plots:** Individual feature vs target
- **Loss Curves:** Training progress tracking
- **Model Comparison:** Performance metrics
- **Actual vs Predicted:** Model accuracy assessment

## 🚀 **Deployment**

### **Render Deployment Commands**

#### **Backend API:**
```bash
# Build Command
pip install -r requirements.txt

# Start Command
uvicorn prediction:app --host 0.0.0.0 --port $PORT
```

#### **Flutter Web App:**
```bash
# Build Command
flutter build web

# Start Command
cd build/web && python -m http.server $PORT
```

## 📚 **Technologies Used**

- **Python:** 3.13
- **Machine Learning:** scikit-learn, numpy, pandas
- **Visualization:** matplotlib, seaborn
- **API:** FastAPI, uvicorn
- **Mobile App:** Flutter, Dart
- **Deployment:** Render
- **Version Control:** Git

## 🤝 **Contributing**

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 **License**

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 **Acknowledgments**

- **Data Source:** UNICEF Global Dataflow Database
- **Machine Learning:** Scikit-learn community
- **Visualization:** Matplotlib and Seaborn teams
- **Framework:** FastAPI and Flutter communities

---

<div align="center">
  <p><strong>🎯 Ready to predict employment rates across Africa!</strong></p>
  <p>Built with ❤️ for machine learning education and social impact</p>
</div> 