# Heart Disease Prediction API

An API service that uses machine learning to predict heart disease risk based on medical data.

## Features

- User registration and authentication
- Heart disease risk prediction using a trained machine learning model
- History tracking of past predictions
- User profile management
- JWT-based authentication for secure API access

## Prerequisites

- Python 3.7+
- pip (Python package manager)
- Virtual environment (recommended)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/heart-disease-prediction-api.git
   cd heart-disease-prediction-api
   ```

2. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   
   # On Windows
   venv\Scripts\activate
   
   # On macOS/Linux
   source venv/bin/activate
   ```

3. Install required dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Create a `.env` file in the project root with the following variables:
   ```
   DATABASE_URI=sqlite:///heart_app.db
   JWT_SECRET_KEY=your-secure-secret-key
   FLASK_APP=app.py
   FLASK_DEBUG=False
   ```

5. Ensure the model file is in the correct location:
   ```
   models/heart_disease_model.pkl
   ```

## Running the Application

Start the Flask server:
```bash
flask run
```

By default, the server will run on `http://127.0.0.1:5000/`.

## API Endpoints

### Authentication

#### Register a new user
```
POST /register
```
Request body:
```json
{
  "username": "testuser",
  "email": "test@example.com",
  "password": "securepassword"
}
```

#### Login
```
POST /login
```
Request body:
```json
{
  "username": "testuser",
  "password": "securepassword"
}
```
Response:
```json
{
  "message": "Login successful",
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5...",
  "user_id": 1,
  "username": "testuser"
}
```

#### Token Refresh
```
POST /refresh
```
*Requires a valid refresh token in the Authorization header*

### Heart Disease Prediction

#### Make a prediction
```
POST /predict
```
*Requires authentication*

Request body:
```json
{
  "age": 63,
  "sex": 1,
  "chest_pain_type": 3,
  "bp": 145,
  "cholesterol": 233,
  "fbs_over_120": 1,
  "ekg_results": 0,
  "max_hr": 150,
  "exercise_angina": 0,
  "st_depression": 2.3,
  "slope_of_st": 0,
  "number_of_vessels_fluro": 0,
  "thallium": 1
}
```
Response:
```json
{
  "prediction": 1,
  "probability": 0.85,
  "message": "Prediction successful"
}
```

#### Get prediction history
```
GET /history
```
*Requires authentication*

Response:
```json
{
  "history": [
    {
      "id": 1,
      "age": 63,
      "sex": 1,
      "chest_pain_type": 3,
      "bp": 145,
      "cholesterol": 233,
      "fbs_over_120": 1,
      "ekg_results": 0,
      "max_hr": 150,
      "exercise_angina": 0,
      "st_depression": 2.3,
      "slope_of_st": 0,
      "number_of_vessels_fluro": 0,
      "thallium": 1,
      "prediction_result": 1,
      "prediction_date": "2025-05-07T14:30:45.123456"
    }
  ]
}
```

### User Profile

#### Get user profile
```
GET /profile
```
*Requires authentication*

Response:
```json
{
  "username": "testuser",
  "email": "test@example.com",
  "created_at": "2025-05-07T12:00:00.123456"
}
```

## Input Parameters for Prediction

| Parameter | Description | Type | Range/Values |
|-----------|-------------|------|-------------|
| age | Age of the patient | Integer | Adult age (typically 18+) |
| sex | Gender of the patient | Integer | 0 = female, 1 = male |
| chest_pain_type | Type of chest pain | Integer | 1 = typical angina, 2 = atypical angina, 3 = non-anginal pain, 4 = asymptomatic |
| bp | Resting blood pressure (in mm Hg) | Integer | Typically 90-200 |
| cholesterol | Serum cholesterol in mg/dl | Integer | Typically 100-600 |
| fbs_over_120 | Fasting blood sugar > 120 mg/dl | Integer | 0 = false, 1 = true |
| ekg_results | Resting electrocardiographic results | Integer | 0 = normal, 1 = having ST-T wave abnormality, 2 = showing left ventricular hypertrophy |
| max_hr | Maximum heart rate achieved | Integer | Typically 60-220 |
| exercise_angina | Exercise induced angina | Integer | 0 = no, 1 = yes |
| st_depression | ST depression induced by exercise relative to rest | Float | Typically 0-6.2 |
| slope_of_st | Slope of the peak exercise ST segment | Integer | 1 = upsloping, 2 = flat, 3 = downsloping |
| number_of_vessels_fluro | Number of major vessels colored by fluoroscopy | Integer | 0-3 |
| thallium | Thallium stress test result | Integer | 3 = normal, 6 = fixed defect, 7 = reversible defect |

## Authentication

The API uses JWT (JSON Web Token) authentication. After successful login, include the access token in subsequent requests:

```
Authorization: Bearer your_access_token_here
```

## Security Considerations

- The API uses bcrypt for password hashing
- All routes requiring authentication are protected with JWT
- Email validation is performed during registration
- Password strength requirements (minimum 8 characters)

## Error Handling

The API returns appropriate HTTP status codes and error messages in JSON format:

```json
{
  "error": "Error message here"
}
```

## Requirements

See `requirements.txt` for the complete list of dependencies.

## License

[MIT License](LICENSE)

## Contact

For questions or support, please contact [your-email@example.com](mailto:your-email@example.com).