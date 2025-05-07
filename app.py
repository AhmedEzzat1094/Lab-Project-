# app.py
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
import joblib
import pandas as pd
from datetime import datetime
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Initialize Flask app
app = Flask(__name__)

# Configure database
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URI', 'sqlite:///heart_app.db')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET_KEY', 'super-secret-key')

# Initialize extensions
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
jwt = JWTManager(app)

# Load the trained model
model = joblib.load('models/heart_disease_model.pkl')

# Database models (same as before)
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(120), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

class PredictionHistory(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    age = db.Column(db.Integer, nullable=False)
    sex = db.Column(db.Integer, nullable=False)
    chest_pain_type = db.Column(db.Integer, nullable=False)
    bp = db.Column(db.Integer, nullable=False)
    cholesterol = db.Column(db.Integer, nullable=False)
    fbs_over_120 = db.Column(db.Integer, nullable=False)
    ekg_results = db.Column(db.Integer, nullable=False)
    max_hr = db.Column(db.Integer, nullable=False)
    exercise_angina = db.Column(db.Integer, nullable=False)
    st_depression = db.Column(db.Float, nullable=False)
    slope_of_st = db.Column(db.Integer, nullable=False)
    number_of_vessels_fluro = db.Column(db.Integer, nullable=False)
    thallium = db.Column(db.Integer, nullable=False)
    prediction_result = db.Column(db.Integer, nullable=False)
    prediction_date = db.Column(db.DateTime, default=datetime.utcnow)
    
    user = db.relationship('User', backref=db.backref('predictions', lazy=True))

# Create database tables
with app.app_context():
    db.create_all()

# API Routes

@app.route('/predict', methods=['POST'])
@jwt_required()
def predict():
    current_user_id = get_jwt_identity()
    
    # Get input data
    data = request.get_json()
    
    # Validate input
    required_fields = [
        'age', 'sex', 'chest_pain_type', 'bp', 'cholesterol',
        'fbs_over_120', 'ekg_results', 'max_hr', 'exercise_angina',
        'st_depression', 'slope_of_st', 'number_of_vessels_fluro', 'thallium'
    ]
    
    if not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400
    
    # Convert to DataFrame for prediction
    input_data = pd.DataFrame([[
        data['age'], data['sex'], data['chest_pain_type'], data['bp'],
        data['cholesterol'], data['fbs_over_120'], data['ekg_results'],
        data['max_hr'], data['exercise_angina'], data['st_depression'],
        data['slope_of_st'], data['number_of_vessels_fluro'], data['thallium']
    ]], columns=required_fields)
    
    # Make prediction
    prediction = model.predict(input_data)[0]
    probability = model.predict_proba(input_data)[0][1]
    
    # Save prediction to history
    new_prediction = PredictionHistory(
        user_id=current_user_id,
        age=data['age'],
        sex=data['sex'],
        chest_pain_type=data['chest_pain_type'],
        bp=data['bp'],
        cholesterol=data['cholesterol'],
        fbs_over_120=data['fbs_over_120'],
        ekg_results=data['ekg_results'],
        max_hr=data['max_hr'],
        exercise_angina=data['exercise_angina'],
        st_depression=data['st_depression'],
        slope_of_st=data['slope_of_st'],
        number_of_vessels_fluro=data['number_of_vessels_fluro'],
        thallium=data['thallium'],
        prediction_result=int(prediction)
    )
    
    db.session.add(new_prediction)
    db.session.commit()
    
    return jsonify({
        "prediction": int(prediction),
        "probability": float(probability),
        "message": "Prediction successful"
    }), 200

# Other routes (register, login, history) remain the same as in the original code

if __name__ == '__main__':
    app.run(debug=os.getenv('FLASK_DEBUG', 'False') == 'True')