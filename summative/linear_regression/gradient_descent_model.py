import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_squared_error, r2_score
import joblib

class GradientDescentLinearRegression:
    def __init__(self, learning_rate=0.01, max_iterations=1000, tolerance=1e-6):
        self.learning_rate = learning_rate
        self.max_iterations = max_iterations
        self.tolerance = tolerance
        self.weights = None
        self.bias = None
        self.train_losses = []
        self.test_losses = []
        
    def fit(self, X_train, y_train, X_test, y_test):
        """
        Train the model using gradient descent
        """
        n_samples, n_features = X_train.shape
        
        # Initialize parameters
        self.weights = np.zeros(n_features)
        self.bias = 0
        
        print(f"🚀 Starting Gradient Descent Training...")
        print(f"📊 Training samples: {n_samples}")
        print(f"🔧 Features: {n_features}")
        print(f"📈 Learning rate: {self.learning_rate}")
        print(f"🔄 Max iterations: {self.max_iterations}")
        
        for iteration in range(self.max_iterations):
            # Forward pass
            y_pred_train = self._predict(X_train)
            y_pred_test = self._predict(X_test)
            
            # Calculate losses
            train_loss = mean_squared_error(y_train, y_pred_train)
            test_loss = mean_squared_error(y_test, y_pred_test)
            
            self.train_losses.append(train_loss)
            self.test_losses.append(test_loss)
            
            # Calculate gradients
            dw = (2/n_samples) * np.dot(X_train.T, (y_pred_train - y_train))
            db = (2/n_samples) * np.sum(y_pred_train - y_train)
            
            # Update parameters
            self.weights -= self.learning_rate * dw
            self.bias -= self.learning_rate * db
            
            # Print progress every 100 iterations
            if iteration % 100 == 0:
                train_r2 = r2_score(y_train, y_pred_train)
                test_r2 = r2_score(y_test, y_pred_test)
                print(f"Iteration {iteration}: Train Loss={train_loss:.4f}, Test Loss={test_loss:.4f}, Train R²={train_r2:.4f}, Test R²={test_r2:.4f}")
            
            # Early stopping
            if iteration > 0 and abs(self.train_losses[-1] - self.train_losses[-2]) < self.tolerance:
                print(f"✅ Early stopping at iteration {iteration}")
                break
        
        print(f"✅ Training completed in {len(self.train_losses)} iterations!")
        
    def _predict(self, X):
        """Make predictions"""
        return np.dot(X, self.weights) + self.bias
    
    def predict(self, X):
        """Public predict method"""
        return self._predict(X)
    
    def plot_loss_curves(self):
        """Plot training and test loss curves"""
        plt.figure(figsize=(12, 5))
        
        # Training and test loss
        plt.subplot(1, 2, 1)
        plt.plot(self.train_losses, label='Training Loss', color='blue', linewidth=2)
        plt.plot(self.test_losses, label='Test Loss', color='red', linewidth=2)
        plt.xlabel('Iteration')
        plt.ylabel('Mean Squared Error')
        plt.title('Gradient Descent: Loss Curves')
        plt.legend()
        plt.grid(True, alpha=0.3)
        
        # Loss difference
        plt.subplot(1, 2, 2)
        loss_diff = np.array(self.train_losses) - np.array(self.test_losses)
        plt.plot(loss_diff, color='green', linewidth=2)
        plt.xlabel('Iteration')
        plt.ylabel('Train Loss - Test Loss')
        plt.title('Loss Difference (Train - Test)')
        plt.grid(True, alpha=0.3)
        
        plt.tight_layout()
        plt.show()
        
        print(f"📊 Final Training Loss: {self.train_losses[-1]:.4f}")
        print(f"📊 Final Test Loss: {self.test_losses[-1]:.4f}")
        print(f"📊 Loss Difference: {loss_diff[-1]:.4f}")
    
    def plot_predictions(self, X_train, y_train, X_test, y_test):
        """Plot actual vs predicted values"""
        y_pred_train = self.predict(X_train)
        y_pred_test = self.predict(X_test)
        
        plt.figure(figsize=(15, 5))
        
        # Training data
        plt.subplot(1, 3, 1)
        plt.scatter(y_train, y_pred_train, alpha=0.6, color='blue')
        plt.plot([y_train.min(), y_train.max()], [y_train.min(), y_train.max()], 'r--', lw=2)
        plt.xlabel('Actual Employment Rate (%)')
        plt.ylabel('Predicted Employment Rate (%)')
        plt.title('Gradient Descent: Training Data')
        plt.grid(True, alpha=0.3)
        
        # Test data
        plt.subplot(1, 3, 2)
        plt.scatter(y_test, y_pred_test, alpha=0.6, color='green')
        plt.plot([y_test.min(), y_test.max()], [y_test.min(), y_test.max()], 'r--', lw=2)
        plt.xlabel('Actual Employment Rate (%)')
        plt.ylabel('Predicted Employment Rate (%)')
        plt.title('Gradient Descent: Test Data')
        plt.grid(True, alpha=0.3)
        
        # Residuals
        plt.subplot(1, 3, 3)
        residuals = y_test - y_pred_test
        plt.scatter(y_pred_test, residuals, alpha=0.6, color='orange')
        plt.axhline(y=0, color='r', linestyle='--')
        plt.xlabel('Predicted Employment Rate (%)')
        plt.ylabel('Residuals')
        plt.title('Residual Plot')
        plt.grid(True, alpha=0.3)
        
        plt.tight_layout()
        plt.show()
        
        # Calculate metrics
        train_r2 = r2_score(y_train, y_pred_train)
        test_r2 = r2_score(y_test, y_pred_test)
        train_rmse = np.sqrt(mean_squared_error(y_train, y_pred_train))
        test_rmse = np.sqrt(mean_squared_error(y_test, y_pred_test))
        
        print(f"📊 Gradient Descent Model Performance:")
        print(f"   Training R²: {train_r2:.4f}")
        print(f"   Test R²: {test_r2:.4f}")
        print(f"   Training RMSE: {train_rmse:.4f}")
        print(f"   Test RMSE: {test_rmse:.4f}")
        
        return {
            'train_r2': train_r2,
            'test_r2': test_r2,
            'train_rmse': train_rmse,
            'test_rmse': test_rmse
        }

def train_gradient_descent_model():
    """Main function to train gradient descent model"""
    # Load data
    df = pd.read_csv('comprehensive_african_employment_data.csv')
    
    # Select features
    feature_columns = ['GDP_per_capita', 'Life_expectancy', 'Population', 
                      'Urban_population_percent', 'School_enrollment_primary', 
                      'School_enrollment_secondary', 'Literacy_rate']
    
    X = df[feature_columns]
    y = df['Employment_rate']
    
    # Split data
    from sklearn.model_selection import train_test_split
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    # Scale features
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    
    # Train gradient descent model
    gd_model = GradientDescentLinearRegression(learning_rate=0.01, max_iterations=1000)
    gd_model.fit(X_train_scaled, y_train, X_test_scaled, y_test)
    
    # Plot results
    gd_model.plot_loss_curves()
    metrics = gd_model.plot_predictions(X_train_scaled, y_train, X_test_scaled, y_test)
    
    # Save model and scaler
    model_data = {
        'model': gd_model,
        'scaler': scaler,
        'feature_columns': feature_columns,
        'metrics': metrics
    }
    
    joblib.dump(model_data, 'gradient_descent_model.pkl')
    print("✅ Gradient descent model saved as 'gradient_descent_model.pkl'")
    
    return gd_model, scaler, metrics

if __name__ == "__main__":
    train_gradient_descent_model() 