# 🎯 African Employment Rate Prediction

## 📋 Mission and Problem
This project addresses African economic development by predicting employment rates using UNICEF socioeconomic data. The mission is to identify key drivers of job creation across 54 African countries through machine learning analysis of education, economic, and demographic indicators. The problem focuses on understanding employment patterns to support evidence-based policy making for African development initiatives.

## 🚀 Public API Endpoint

**API Documentation (Swagger UI)**: [https://machine-learning-summative-3fgi.onrender.com/docs](https://machine-learning-summative-3fgi.onrender.com/docs)

**Prediction Endpoint**: `POST https://machine-learning-summative-3fgi.onrender.com/predict`

**Health Check**: `GET https://machine-learning-summative-3fgi.onrender.com/`

### Example API Request
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

## 🎬 YouTube Video Demo

**YouTube Video Demo**: https://youtu.be/VRkPaGIHqjs


<div align="center">
  <a href="https://www.youtube.com/watch?v=VRkPaGIHqjs">
    <img src="https://img.youtube.com/vi/VRkPaGIHqjs/maxresdefault.jpg" alt="Project Demo" width="600" height="400">
  </a>
  <br>
  <em>🎥 Click to watch the full project demonstration</em>
</div>


## 📱 Mobile App Instructions

### Prerequisites
- Flutter SDK (3.0 or higher)
- Android Studio / VS Code
- Android emulator or physical device

### Running the Mobile App

1. **Navigate to Flutter App Directory**
   ```bash
   cd linear_regression_model/summative/FlutterApp
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the App**
   ```bash
   flutter run
   ```

### App Features
- Multi-step form with 7 input fields
- Input validation with range constraints
- Sample data button for testing
- Real-time prediction display
- Error handling and loading states

### Input Fields Required
1. **Primary School Enrollment (%)** - 0-100
2. **Secondary School Enrollment (%)** - 0-100
3. **Adult Literacy Rate (%)** - 0-100
4. **Urban Population (%)** - 0-100
5. **GDP per Capita (USD)** - 100-100,000
6. **Total Population** - 100,000-2,000,000,000
7. **Life Expectancy (years)** - 30-90

---

**Project Status**: ✅ Complete and Ready for Submission  
**API Status**: ✅ Deployed and Publicly Accessible  
**Mobile App**: ✅ Functional and Connected to API 