#!/usr/bin/env python3
"""
Test script for the Employment Rate Prediction API
"""

import requests
import json
import time

def test_api():
    base_url = "http://localhost:8000"
    
    print("🧪 Testing Employment Rate Prediction API...")
    
    # Test 1: Health check
    print("\n1️⃣ Testing health endpoint...")
    try:
        response = requests.get(f"{base_url}/health", timeout=5)
        if response.status_code == 200:
            print("✅ Health check passed!")
            print(f"   Response: {response.json()}")
        else:
            print(f"❌ Health check failed with status {response.status_code}")
            return False
    except requests.exceptions.RequestException as e:
        print(f"❌ Health check failed: {e}")
        return False
    
    # Test 2: Sample prediction
    print("\n2️⃣ Testing sample prediction...")
    try:
        response = requests.get(f"{base_url}/sample-prediction", timeout=10)
        if response.status_code == 200:
            print("✅ Sample prediction passed!")
            result = response.json()
            print(f"   Predicted employment rate: {result['predicted_employment_rate']}%")
            print(f"   Confidence: {result['confidence_level']}")
            print(f"   Model used: {result['model_used']}")
        else:
            print(f"❌ Sample prediction failed with status {response.status_code}")
            return False
    except requests.exceptions.RequestException as e:
        print(f"❌ Sample prediction failed: {e}")
        return False
    
    # Test 3: Custom prediction
    print("\n3️⃣ Testing custom prediction...")
    test_data = {
        "school_enrollment_primary": 85.5,
        "school_enrollment_secondary": 72.3,
        "literacy_rate": 78.9,
        "urban_population_percent": 65.0,
        "gdp_per_capita": 3500.0,
        "population": 15000000.0,
        "life_expectancy": 68.5
    }
    
    try:
        response = requests.post(
            f"{base_url}/predict",
            json=test_data,
            headers={"Content-Type": "application/json"},
            timeout=10
        )
        if response.status_code == 200:
            print("✅ Custom prediction passed!")
            result = response.json()
            print(f"   Predicted employment rate: {result['predicted_employment_rate']}%")
            print(f"   Confidence: {result['confidence_level']}")
            print(f"   Model used: {result['model_used']}")
        else:
            print(f"❌ Custom prediction failed with status {response.status_code}")
            print(f"   Response: {response.text}")
            return False
    except requests.exceptions.RequestException as e:
        print(f"❌ Custom prediction failed: {e}")
        return False
    
    print("\n🎉 All tests passed! API is working correctly.")
    return True

if __name__ == "__main__":
    # Wait a bit for the server to start
    print("⏳ Waiting for API to start...")
    time.sleep(2)
    
    success = test_api()
    if not success:
        print("\n❌ API tests failed. Please check if the server is running.")
        print("   Start the server with: uvicorn prediction:app --reload --host 0.0.0.0 --port 8000") 