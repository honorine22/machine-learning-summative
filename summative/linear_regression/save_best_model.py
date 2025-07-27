import pandas as pd
import numpy as np
import joblib
from sklearn.ensemble import RandomForestRegressor
from sklearn.linear_model import LinearRegression
from sklearn.tree import DecisionTreeRegressor
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, r2_score
import matplotlib.pyplot as plt
import seaborn as sns

def train_and_compare_models():
    """Train all models and save the best performing one"""
    
    # Load data
    df = pd.read_csv('comprehensive_african_employment_data.csv')
    
    # Select features
    feature_columns = ['GDP_per_capita', 'Life_expectancy', 'Population', 
                      'Urban_population_percent', 'School_enrollment_primary', 
                      'School_enrollment_secondary', 'Literacy_rate']
    
    X = df[feature_columns]
    y = df['Employment_rate']
    
    # Split data
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    # Scale features
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    
    # Train models
    models = {
        'Linear Regression': LinearRegression(),
        'Random Forest': RandomForestRegressor(n_estimators=100, random_state=42),
        'Decision Tree': DecisionTreeRegressor(random_state=42)
    }
    
    results = {}
    
    print("🚀 Training and comparing models...")
    
    for name, model in models.items():
        print(f"\n📊 Training {name}...")
        
        # Train model
        model.fit(X_train_scaled, y_train)
        
        # Make predictions
        y_pred_train = model.predict(X_train_scaled)
        y_pred_test = model.predict(X_test_scaled)
        
        # Calculate metrics
        train_r2 = r2_score(y_train, y_pred_train)
        test_r2 = r2_score(y_test, y_pred_test)
        train_rmse = np.sqrt(mean_squared_error(y_train, y_pred_train))
        test_rmse = np.sqrt(mean_squared_error(y_test, y_pred_test))
        
        results[name] = {
            'model': model,
            'train_r2': train_r2,
            'test_r2': test_r2,
            'train_rmse': train_rmse,
            'test_rmse': test_rmse,
            'y_pred_train': y_pred_train,
            'y_pred_test': y_pred_test
        }
        
        print(f"   Training R²: {train_r2:.4f}")
        print(f"   Test R²: {test_r2:.4f}")
        print(f"   Test RMSE: {test_rmse:.4f}")
    
    # Find best model (highest test R²)
    best_model_name = max(results.keys(), key=lambda x: results[x]['test_r2'])
    best_model = results[best_model_name]['model']
    
    print(f"\n🏆 Best Model: {best_model_name}")
    print(f"   Test R²: {results[best_model_name]['test_r2']:.4f}")
    print(f"   Test RMSE: {results[best_model_name]['test_rmse']:.4f}")
    
    # Save best model
    model_data = {
        'model': best_model,
        'scaler': scaler,
        'feature_columns': feature_columns,
        'model_name': best_model_name,
        'metrics': {
            'train_r2': results[best_model_name]['train_r2'],
            'test_r2': results[best_model_name]['test_r2'],
            'train_rmse': results[best_model_name]['train_rmse'],
            'test_rmse': results[best_model_name]['test_rmse']
        }
    }
    
    joblib.dump(model_data, 'best_model.pkl')
    print(f"✅ Best model saved as 'best_model.pkl'")
    
    # Save all models for comparison
    all_models_data = {
        'models': results,
        'scaler': scaler,
        'feature_columns': feature_columns,
        'best_model_name': best_model_name
    }
    
    joblib.dump(all_models_data, 'all_models.pkl')
    print("✅ All models saved as 'all_models.pkl'")
    
    # Create comparison plots
    create_comparison_plots(results, X_train_scaled, y_train, X_test_scaled, y_test)
    
    return best_model_name, model_data

def create_comparison_plots(results, X_train, y_train, X_test, y_test):
    """Create comprehensive comparison plots"""
    
    # Model performance comparison
    fig, axes = plt.subplots(2, 3, figsize=(18, 12))
    fig.suptitle('Model Performance Comparison', fontsize=16, fontweight='bold')
    
    # R² Score comparison
    model_names = list(results.keys())
    test_r2_scores = [results[name]['test_r2'] for name in model_names]
    
    axes[0, 0].bar(model_names, test_r2_scores, color=['skyblue', 'lightgreen', 'orange'])
    axes[0, 0].set_title('Test R² Score Comparison')
    axes[0, 0].set_ylabel('R² Score')
    axes[0, 0].tick_params(axis='x', rotation=45)
    
    # RMSE comparison
    test_rmse_scores = [results[name]['test_rmse'] for name in model_names]
    axes[0, 1].bar(model_names, test_rmse_scores, color=['skyblue', 'lightgreen', 'orange'])
    axes[0, 1].set_title('Test RMSE Comparison')
    axes[0, 1].set_ylabel('RMSE')
    axes[0, 1].tick_params(axis='x', rotation=45)
    
    # Training vs Test R²
    train_r2_scores = [results[name]['train_r2'] for name in model_names]
    x = np.arange(len(model_names))
    width = 0.35
    
    axes[0, 2].bar(x - width/2, train_r2_scores, width, label='Training R²', color='skyblue')
    axes[0, 2].bar(x + width/2, test_r2_scores, width, label='Test R²', color='lightcoral')
    axes[0, 2].set_title('Training vs Test R²')
    axes[0, 2].set_ylabel('R² Score')
    axes[0, 2].set_xticks(x)
    axes[0, 2].set_xticklabels(model_names, rotation=45)
    axes[0, 2].legend()
    
    # Actual vs Predicted plots for each model
    for i, (name, result) in enumerate(results.items()):
        row = 1
        col = i
        
        axes[row, col].scatter(y_test, result['y_pred_test'], alpha=0.6, color='green')
        axes[row, col].plot([y_test.min(), y_test.max()], [y_test.min(), y_test.max()], 'r--', lw=2)
        axes[row, col].set_xlabel('Actual Employment Rate (%)')
        axes[row, col].set_ylabel('Predicted Employment Rate (%)')
        axes[row, col].set_title(f'{name}: Test Data')
        axes[row, col].grid(True, alpha=0.3)
    
    plt.tight_layout()
    plt.savefig('model_comparison.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    print("📊 Model comparison plots saved as 'model_comparison.png'")

def create_prediction_script():
    """Create a prediction script for the best model"""
    
    script_content = '''import joblib
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
    print(f"\\n📊 Predicted Employment Rate: {predicted_employment:.2f}%")

if __name__ == "__main__":
    main()
'''
    
    with open('prediction_script.py', 'w') as f:
        f.write(script_content)
    
    print("✅ Prediction script created as 'prediction_script.py'")

if __name__ == "__main__":
    # Train and save best model
    best_model_name, model_data = train_and_compare_models()
    
    # Create prediction script
    create_prediction_script()
    
    print(f"\\n🎉 All components created successfully!")
    print(f"🏆 Best model: {best_model_name}")
    print(f"📁 Files created:")
    print(f"   - best_model.pkl (best performing model)")
    print(f"   - all_models.pkl (all models for comparison)")
    print(f"   - prediction_script.py (prediction script)")
    print(f"   - model_comparison.png (comparison plots)") 