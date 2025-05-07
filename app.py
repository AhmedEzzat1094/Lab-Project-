import os
import pickle
from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
import logging
import logging.handlers
import pandas as pd

# Load environment variables
load_dotenv()

# Initialize Flask app
app = Flask(__name__)

# Configure CORS
CORS(app)

# Configure logging
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
handler = logging.handlers.RotatingFileHandler('app.log', maxBytes=1000000, backupCount=5)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)

# Load the trained model using pickle
try:
    model_path = os.getenv('MODEL_PATH', 'heart_disease_model.pkl')
    with open(model_path, 'rb') as model_file:
        model = pickle.load(model_file)
    logger.info("Model loaded successfully")
except Exception as e:
    logger.error(f"Failed to load model: {e}")
    raise

# Helper functions
def validate_input_data(data):
    """Validate prediction input data"""
    required_fields = [
        'age', 'sex', 'chest_pain_type', 'bp', 'cholesterol',
        'fbs_over_120', 'ekg_results', 'max_hr', 'exercise_angina',
        'st_depression', 'slope_of_st', 'number_of_vessels_fluro', 'thallium'
    ]
    
    # Check for missing required fields
    missing_fields = [field for field in required_fields if field not in data]
    if missing_fields:
        return False, f"Missing required fields: {', '.join(missing_fields)}"
    
    # Validate field ranges and types
    try:
        if not (0 < data['age'] <= 120):
            return False, "Invalid age value"
        if data['sex'] not in [0, 1]:
            return False, "Invalid sex value"
        if data['chest_pain_type'] not in [1, 2, 3, 4]:
            return False, "Invalid chest pain type"
        if not (80 <= data['bp'] <= 200):
            return False, "Invalid blood pressure value"
        if not (100 <= data['cholesterol'] <= 600):
            return False, "Invalid cholesterol value"
        if data['fbs_over_120'] not in [0, 1]:
            return False, "Invalid fbs_over_120 value"
        if data['ekg_results'] not in [0, 1, 2]:
            return False, "Invalid EKG results"
        if not (60 <= data['max_hr'] <= 220):
            return False, "Invalid max heart rate"
        if data['exercise_angina'] not in [0, 1]:
            return False, "Invalid exercise angina value"
        if not (0 <= data['st_depression'] <= 6.2):
            return False, "Invalid ST depression value"
        if data['slope_of_st'] not in [1, 2, 3]:
            return False, "Invalid slope of ST value"
        if data['number_of_vessels_fluro'] not in [0, 1, 2, 3]:
            return False, "Invalid number of vessels"
        if data['thallium'] not in [3, 6, 7]:
            return False, "Invalid thallium value"
    except (TypeError, ValueError):
        return False, "Invalid data type for one or more fields"
    
    return True, ""

def create_error_response(message, status_code, details=None):
    """Standardize error responses"""
    response = {"error": message}
    if details:
        response["details"] = details
    return jsonify(response), status_code

# API Routes
@app.route('/health', methods=['GET'])
def health():
    try:
        test_input = pd.DataFrame([[0] * 13], columns=[
            'age', 'sex', 'chest_pain_type', 'bp', 'cholesterol',
            'fbs_over_120', 'ekg_results', 'max_hr', 'exercise_angina',
            'st_depression', 'slope_of_st', 'number_of_vessels_fluro', 'thallium'
        ])
        model.predict(test_input)
        return jsonify({"status": "healthy", "model": "loaded"}), 200
    except Exception as e:
        logger.error(f"Health check failed: {str(e)}")
        return create_error_response("Model unavailable", 503)

@app.route('/predict', methods=['POST'])
def predict():
    logger.info("Received a prediction request")
    
    try:
        data = request.get_json()
        logger.debug(f"Request JSON data: {data}")

        if data is None:
            logger.warning("No JSON received or incorrect content type")
            return create_error_response("Invalid or missing JSON", 400)

        # Validate input
        is_valid, message = validate_input_data(data)
        if not is_valid:
            logger.warning(f"Input validation failed: {message}")
            return create_error_response(message, 400)

        # Convert to DataFrame for prediction
        try:
            input_data = pd.DataFrame([[ 
                data['age'], data['sex'], data['chest_pain_type'], data['bp'],
                data['cholesterol'], data['fbs_over_120'], data['ekg_results'],
                data['max_hr'], data['exercise_angina'], data['st_depression'],
                data['slope_of_st'], data['number_of_vessels_fluro'], data['thallium']
            ]], columns=[
                'age', 'sex', 'chest_pain_type', 'bp', 'cholesterol',
                'fbs_over_120', 'ekg_results', 'max_hr', 'exercise_angina',
                'st_depression', 'slope_of_st', 'number_of_vessels_fluro', 'thallium'
            ])
        except KeyError as ke:
            logger.error(f"Missing expected key in JSON: {ke}")
            return create_error_response(f"Missing input field: {str(ke)}", 400)

        logger.debug(f"Prepared input DataFrame for prediction: {input_data}")

        # Make prediction
        prediction = model.predict(input_data)[0]
        probability = model.predict_proba(input_data)[0][1]
        logger.debug(f"Prediction result: {prediction}, Probability: {probability}")

        return jsonify({
            "prediction": int(prediction),
            "probability": float(probability),
            "message": "Prediction successful",
            "input_data": data  # Include input data in response for reference
        }), 200

    except Exception as e:
        logger.exception("Unhandled exception during prediction")
        return create_error_response("Prediction failed", 500, str(e))

# Error handlers
@app.errorhandler(404)
def not_found(error):
    return create_error_response("Resource not found", 404)

@app.errorhandler(500)
def internal_error(error):
    logger.error(f"Internal server error: {str(error)}")
    return create_error_response("Internal server error", 500)

if __name__ == '__main__':
    print('Minimal Heart Disease Prediction API')
    port = int(os.getenv('PORT', 5000))
    debug_mode = os.getenv('FLASK_DEBUG', 'False') == 'True'
    print(f'Running on port {port}, debug mode: {debug_mode}')
    app.run(
        host='0.0.0.0',
        port=port,
        debug=debug_mode
    )
