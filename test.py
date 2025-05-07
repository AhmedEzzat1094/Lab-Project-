import requests
import json
import time
import sys

class HeartDiseaseAPIClient:
    def __init__(self, base_url="http://localhost:5000"):
        self.base_url = base_url
        self.token = None
        self.headers = {"Content-Type": "application/json"}
    
    def register(self, username, email, password):
        """Register a new user"""
        print(f"Attempting to register user at {self.base_url}/register")
        endpoint = f"{self.base_url}/register"
        data = {
            "username": username,
            "email": email,
            "password": password
        }
        try:
            response = requests.post(endpoint, json=data, headers=self.headers)
            return response.json(), response.status_code
        except requests.exceptions.ConnectionError:
            print(f"ERROR: Could not connect to server at {self.base_url}")
            print("Make sure the Flask server is running and the port is correct")
            return {"error": "Connection failed"}, 500

    def login(self, username, password):
        """Login and get access token"""
        endpoint = f"{self.base_url}/login"
        data = {
            "username": username,
            "password": password
        }
        response = requests.post(endpoint, json=data, headers=self.headers)
        result = response.json()
        
        if response.status_code == 200 and "access_token" in result:
            self.token = result["access_token"]
            self.headers["Authorization"] = f"Bearer {self.token}"
        
        return result, response.status_code

    def get_profile(self):
        """Get user profile"""
        endpoint = f"{self.base_url}/profile"
        response = requests.get(endpoint, headers=self.headers)
        return response.json(), response.status_code

    def get_history(self):
        """Get prediction history"""
        endpoint = f"{self.base_url}/history"
        response = requests.get(endpoint, headers=self.headers)
        return response.json(), response.status_code

    def make_prediction(self, data):
        """Make a heart disease prediction"""
        endpoint = f"{self.base_url}/predict"
        response = requests.post(endpoint, json=data, headers=self.headers)
        return response.json(), response.status_code

def sample_prediction_data():
    """Generate sample prediction data"""
    return {
        "age": 65,
        "sex": 1,  # 1 for male, 0 for female
        "chest_pain_type": 3,
        "bp": 145,
        "cholesterol": 233,
        "fbs_over_120": 1,
        "ekg_results": 2,
        "max_hr": 150,
        "exercise_angina": 0,
        "st_depression": 2.3,
        "slope_of_st": 3,
        "number_of_vessels_fluro": 0,
        "thallium": 6
    }

def run_full_test():
    """Run a full test of all API endpoints"""
    client = HeartDiseaseAPIClient()
    
    # Step 1: Register a new user
    username = f"testuser_{int(time.time())}"
    email = f"{username}@example.com"
    password = "TestPass123"
    
    print("\n1. TESTING USER REGISTRATION")
    print(f"Registering user: {username}")
    print(f"Email: {email}")
    print(f"Password: {password}")
    
    result, status = client.register(username, email, password)
    print(f"Status: {status}")
    print(f"Response: {json.dumps(result, indent=2)}")
    
    if status != 201:
        print("Registration failed. Let's try logging in anyway in case the user already exists.")
    
    # Step 2: Login
    print("\n2. TESTING LOGIN")
    result, status = client.login(username, password)
    print(f"Status: {status}")
    print(f"Response: {json.dumps(result, indent=2)}")
    
    if status != 200:
        print("Login failed. Let's create a user manually and try again.")
        # Try with a hardcoded test user
        username = "testuser"
        password = "TestPassword123"
        print(f"Trying with hardcoded user: {username}")
        result, status = client.login(username, password)
        print(f"Status: {status}")
        print(f"Response: {json.dumps(result, indent=2)}")
        
    if status != 200:
        print("All login attempts failed. Stopping tests.")
        return
    
    # Step 3: Get Profile
    print("\n3. TESTING PROFILE RETRIEVAL")
    result, status = client.get_profile()
    print(f"Status: {status}")
    print(f"Response: {json.dumps(result, indent=2)}")
    
    # Step 4: Make a prediction
    print("\n4. TESTING PREDICTION")
    data = sample_prediction_data()
    print(f"Prediction data: {json.dumps(data, indent=2)}")
    result, status = client.make_prediction(data)
    print(f"Status: {status}")
    print(f"Response: {json.dumps(result, indent=2)}")
    
    # Step 5: Get prediction history
    print("\n5. TESTING HISTORY RETRIEVAL")
    result, status = client.get_history()
    print(f"Status: {status}")
    print(f"Response: {json.dumps(result, indent=2)}")
    
    print("\nAll tests completed!")

if __name__ == "__main__":
    run_full_test()