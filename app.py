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
from email_validator import validate_email, EmailNotValidError
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
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
model_path = os.path.join(os.path.dirname(__file__), 'models', 'heart_disease_model.pkl')
model = joblib.load(model_path)


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
    try:
        prediction = model.predict(input_data)[0]
        probability = model.predict_proba(input_data)[0][1]
    except Exception as e:
        return jsonify({"error": "Model prediction failed", "details": str(e)}), 500

    
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
@app.route('/history', methods=['GET'])
@jwt_required()
def get_history():
    current_user_id = get_jwt_identity()

    history = PredictionHistory.query.filter_by(user_id=current_user_id).order_by(
        PredictionHistory.prediction_date.desc()
    ).all()

    history_data = [{
        'id': pred.id,
        'age': pred.age,
        'sex': pred.sex,
        'chest_pain_type': pred.chest_pain_type,
        'bp': pred.bp,
        'cholesterol': pred.cholesterol,
        'fbs_over_120': pred.fbs_over_120,
        'ekg_results': pred.ekg_results,
        'max_hr': pred.max_hr,
        'exercise_angina': pred.exercise_angina,
        'st_depression': pred.st_depression,
        'slope_of_st': pred.slope_of_st,
        'number_of_vessels_fluro': pred.number_of_vessels_fluro,
        'thallium': pred.thallium,
        'prediction_result': pred.prediction_result,
        'prediction_date': pred.prediction_date.isoformat()
    } for pred in history]

    return jsonify({"history": history_data}), 200


@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    
    # Validate input
    if not data or not data.get('username') or not data.get('password'):
        return jsonify({"error": "Missing username or password"}), 400
    
    # Find user
    user = User.query.filter_by(username=data['username']).first()
    if not user or not bcrypt.check_password_hash(user.password, data['password']):
        return jsonify({"error": "Invalid username or password"}), 401
    
    # Create access token
    access_token = create_access_token(identity=user.id)
    
    return jsonify({
        "message": "Login successful",
        "access_token": access_token,
        "user_id": user.id,
        "username": user.username
    }), 200


@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    
    # Validate input
    if not data or not data.get('username') or not data.get('email') or not data.get('password'):
        return jsonify({"error": "Missing required fields"}), 400
    
    # Validate email format
    try:
        email = validate_email(data['email']).email
    except EmailNotValidError:
        return jsonify({"error": "Invalid email format"}), 400
    
    # Validate password strength
    if len(data['password']) < 8:
        return jsonify({"error": "Password must be at least 8 characters"}), 400
    
    # Validate input
    if not data or not data.get('username') or not data.get('email') or not data.get('password'):
        return jsonify({"error": "Missing required fields"}), 400
    
    # Check if user exists
    if User.query.filter_by(username=data['username']).first():
        return jsonify({"error": "Username already exists"}), 400
    if User.query.filter_by(email=data['email']).first():
        return jsonify({"error": "Email already exists"}), 400
    
    # Hash password
    hashed_password = bcrypt.generate_password_hash(data['password']).decode('utf-8')
    
    # Create new user
    new_user = User(
        username=data['username'],
        email=data['email'],
        password=hashed_password
    )
    
    db.session.add(new_user)
    db.session.commit()
    
    return jsonify({"message": "User created successfully"}), 201


@app.errorhandler(404)
def not_found(error):
    return jsonify({"error": "Resource not found"}), 404

@app.errorhandler(500)
def internal_error(error):
    db.session.rollback()
    return jsonify({"error": "Internal server error"}), 500

# Add to your existing code
@app.route('/profile', methods=['GET'])
@jwt_required()
def get_profile():
    current_user_id = get_jwt_identity()
    user = User.query.get(current_user_id)
    
    if not user:
        return jsonify({"error": "User not found"}), 404
    
    return jsonify({
        "username": user.username,
        "email": user.email,
        "created_at": user.created_at.isoformat()
    }), 200

@app.route('/refresh', methods=['POST'])
@jwt_required(refresh=True)
def refresh():
    current_user_id = get_jwt_identity()
    new_token = create_access_token(identity=current_user_id)
    return jsonify({"access_token": new_token}), 200


if __name__ == '__main__':
    app.run(debug=os.getenv('FLASK_DEBUG', 'False') == 'True')