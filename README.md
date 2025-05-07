# Heart Disease Prediction System

## Project Overview

A comprehensive system that predicts heart disease risk using machine learning, with:
- AI/ML backend for predictions
- Data analysis capabilities
- REST API for communication
- Flutter mobile application




## Features

### Core Functionality
- Heart disease risk prediction using machine learning
- Patient health data collection and storage
- Prediction history tracking
- Multi-user role system (Admin, Doctors, Patients)

### Technical Components
- **AI/ML**: Logistic Regression model trained on heart disease dataset
- **Backend**: Flask REST API with JWT authentication
- **Database**: SQLite/PostgreSQL for data persistence
- **Mobile App**: Flutter cross-platform application

## System Requirements

### Functional Requirements
- User authentication and authorization
- Health data input forms
- Risk prediction with confidence scores
- Prediction history dashboard
- Admin management interface

### Non-Functional Requirements
- Accuracy: >85% prediction accuracy
- Performance: <2s response time for predictions
- Security: HIPAA-compliant data handling
- Usability: Intuitive UI for medical professionals

## Installation

### Backend Setup
1. Clone the repository
2. Create virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # Linux/Mac
   venv\Scripts\activate     # Windows
   ```
3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
4. Configure environment variables in `.env` file
5. Run the application:
   ```bash
   flask run
   ```

### Flutter App Setup
1. Ensure Flutter SDK is installed
2. Navigate to `flutter_app` directory
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## API Documentation

### Authentication
- `POST /register` - User registration
- `POST /login` - User login (returns JWT token)

### Predictions
- `POST /predict` - Submit health data and get prediction
- `GET /history` - Retrieve prediction history

### Admin
- `GET /users` - List all users (admin only)
- `DELETE /users/<id>` - Delete user (admin only)

## Development Methodology

We follow **Agile** principles with:
- 2-week sprints
- Daily standups
- Continuous integration
- Regular stakeholder feedback

## Project Structure

```
heart-disease-prediction/
├── api/                  # Flask backend
│   ├── app.py            # Main application
│   ├── models/           # ML models
│   └── requirements.txt  # Python dependencies
│
├── flutter_app/          # Mobile application
│   ├── lib/              # Dart source code
│   └── pubspec.yaml      # Flutter dependencies
│
├── docs/                 # Documentation
└── README.md             # This file
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
