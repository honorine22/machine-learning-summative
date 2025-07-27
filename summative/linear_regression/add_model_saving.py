import joblib
import numpy as np

def save_model_from_notebook():
    """
    This function should be run after the notebook cells to save the best model.
    It assumes the variables from the notebook are available.
    """
    
    # Load the dataset
    import pandas as pd
    from sklearn.model_selection import train_test_split
    from sklearn.linear_model import LinearRegression
    from sklearn.preprocessing import StandardScaler
    
    # Load data
    df = pd.read_csv('comprehensive_african_employment_data.csv')
    
    # Select features
    feature_columns = ['GDP_per_capita', 'Life_expectancy', 'Population', 
                      'Urban_population_percent', 'School_enrollment_primary', 
                      'School_enrollment_secondary', 'Literacy_rate']
    
    X = df[feature_columns]
    y = df['Employment_rate']
    
    # Split and scale data
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    
    # Train model
    lr_model = LinearRegression()
    lr_model.fit(X_train_scaled, y_train)
    
    # Calculate metrics
    from sklearn.metrics import mean_squared_error, r2_score
    lr_train_pred = lr_model.predict(X_train_scaled)
    lr_test_pred = lr_model.predict(X_test_scaled)
    lr_train_r2 = r2_score(y_train, lr_train_pred)
    lr_test_r2 = r2_score(y_test, lr_test_pred)
    lr_train_rmse = np.sqrt(mean_squared_error(y_train, lr_train_pred))
    lr_test_rmse = np.sqrt(mean_squared_error(y_test, lr_test_pred))
    
    # Save the best model with all necessary components
    best_model_data = {
        'model': lr_model,  # Linear Regression performed best
        'scaler': scaler,
        'feature_columns': feature_columns,
        'model_name': 'Linear Regression',
        'metrics': {
            'train_r2': lr_train_r2,
            'test_r2': lr_test_r2,
            'train_rmse': lr_train_rmse,
            'test_rmse': lr_test_rmse
        }
    }
    
    joblib.dump(best_model_data, 'best_model_from_notebook.pkl')
    print("✅ Best model saved as 'best_model_from_notebook.pkl'")
    
    # Test the saved model
    loaded_model_data = joblib.load('best_model_from_notebook.pkl')
    loaded_model = loaded_model_data['model']
    loaded_scaler = loaded_model_data['scaler']
    
    # Test prediction with saved model
    sample_data = np.array([[
        5000,    # GDP per capita
        65,      # Life expectancy
        50000000, # Population
        45,      # Urban population %
        85,      # Primary enrollment %
        60,      # Secondary enrollment %
        70       # Literacy rate %
    ]])
    
    test_prediction = loaded_model.predict(loaded_scaler.transform(sample_data))[0]
    print(f"📊 Test prediction with saved model: {test_prediction:.2f}%")
    print("✅ Model saving and loading successful!")
    
    return best_model_data

if __name__ == "__main__":
    save_model_from_notebook() 