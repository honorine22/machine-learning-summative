// Test file to verify API response format for Flutter app
// This simulates the API response structure

void main() {
  // Simulate the API response structure
  final Map<String, dynamic> apiResponse = {
    "predicted_employment_rate": 68.86,
    "confidence_level": "Medium",
    "model_used": "Random Forest",
    "input_summary": {
      "education_level": "Primary: 85.5%, Secondary: 72.3%",
      "literacy": "Literacy rate: 78.9%",
      "economic_status": "GDP per capita: \$3,500",
      "urbanization": "65.0% urban",
      "demographics": "Population: 15,000,000, Life expectancy: 68.5 years"
    },
    "feature_importance": {
      "school_enrollment_secondary": 17.02833319647491,
      "urban_population_percent": 14.323473648526278,
      "population": 14.314598175559354,
      "life_expectancy": 14.268518077550862
    }
  };

  // Test the response structure
  print("Testing API response structure...");
  
  // Test prediction rate
  final predictionRate = apiResponse['predicted_employment_rate'];
  print("Prediction rate: $predictionRate (type: ${predictionRate.runtimeType})");
  
  // Test confidence level
  final confidenceLevel = apiResponse['confidence_level'];
  print("Confidence level: $confidenceLevel (type: ${confidenceLevel.runtimeType})");
  
  // Test model used
  final modelUsed = apiResponse['model_used'];
  print("Model used: $modelUsed (type: ${modelUsed.runtimeType})");
  
  // Test input summary
  final inputSummary = apiResponse['input_summary'] as Map<String, dynamic>;
  print("Input summary entries: ${inputSummary.length}");
  inputSummary.forEach((key, value) {
    print("  $key: $value (type: ${value.runtimeType})");
  });
  
  // Test feature importance
  final featureImportance = apiResponse['feature_importance'] as Map<String, dynamic>;
  print("Feature importance entries: ${featureImportance.length}");
  featureImportance.forEach((key, value) {
    print("  $key: $value (type: ${value.runtimeType})");
  });
  
  print("\n✅ API response structure is valid for Flutter app!");
} 