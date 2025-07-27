import joblib
import numpy as np

def load_model():
    """Load the best trained model"""
    model_data = joblib.load('best_model.pkl')
    return model_data

def predict_employment_rate(features):
    """
    Predict employment rate using the best model
    
    Parameters:
    features (dict): Dictionary containing the following features:
        - gdp_per_capita: GDP per capita in USD
        - life_expectancy: Life expectancy in years
        - population: Total population
        - urban_population_percent: Urban population percentage
        - school_enrollment_primary: Primary school enrollment percentage
        - school_enrollment_secondary: Secondary school enrollment percentage
        - literacy_rate: Literacy rate percentage
    
    Returns:
    float: Predicted employment rate percentage
    """
    # Load model
    model_data = load_model()
    model = model_data['model']
    scaler = model_data['scaler']
    feature_columns = model_data['feature_columns']
    
    # Prepare features
    feature_values = [
        features['gdp_per_capita'],
        features['life_expectancy'],
        features['population'],
        features['urban_population_percent'],
        features['school_enrollment_primary'],
        features['school_enrollment_secondary'],
        features['literacy_rate']
    ]
    
    # Convert to numpy array and reshape
    X = np.array(feature_values).reshape(1, -1)
    
    # Scale features
    X_scaled = scaler.transform(X)
    
    # Make prediction
    prediction = model.predict(X_scaled)[0]
    
    return prediction

def main():
    """Example usage of the prediction function"""
    
    # Example features for a sample country
    sample_features = {
        'gdp_per_capita': 5000,
        'life_expectancy': 65,
        'population': 50000000,
        'urban_population_percent': 45,
        'school_enrollment_primary': 85,
        'school_enrollment_secondary': 60,
        'literacy_rate': 70
    }
    
    # Make prediction
    predicted_employment = predict_employment_rate(sample_features)
    
    print("🎯 Employment Rate Prediction")
    print("=" * 40)
    print("Sample Features:")
    for key, value in sample_features.items():
        print(f"  {key}: {value}")
    print(f"\n📊 Predicted Employment Rate: {predicted_employment:.2f}%")

if __name__ == "__main__":
    main() 