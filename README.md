# 🫀 Heart Disease Prediction API

This is a minimal Flask API for predicting the risk of heart disease using a pre-trained machine learning model.

## 🚀 Features

- RESTful API for heart disease prediction
- Input validation and standardized error handling
- Health check endpoint
- CORS enabled
- Environment variable configuration via `.env` file
- Logging to `app.log`

## 🧠 Requirements

- Python 3.7+
- pip

## 📦 Setup

1. **Clone the repository:**

```bash
git clone https://github.com/AhmedEzzat1094/Lab-Project-.git
cd heart-disease-api
git switch simple-back
````

2. **Install dependencies:**

```bash
pip install -r requirements.txt
```

3. **Create a `.env` file:**

```env
PORT=5000
FLASK_DEBUG=True
MODEL_PATH=heart_disease_model.pkl
```

4. **Make sure your model is saved as `heart_disease_model.pkl` or update `MODEL_PATH` accordingly.**

## ▶️ Run the API

```bash
python app.py
```

API will start on `http://localhost:5000` by default.

## 🧪 API Endpoints

### Health Check

**GET** `/health`

Returns model status.

### Prediction

**POST** `/predict`

**Request Body (JSON):**

```json
{
  "age": 55,
  "sex": 1,
  "chest_pain_type": 2,
  "bp": 130,
  "cholesterol": 250,
  "fbs_over_120": 0,
  "ekg_results": 1,
  "max_hr": 150,
  "exercise_angina": 0,
  "st_depression": 1.2,
  "slope_of_st": 2,
  "number_of_vessels_fluro": 1,
  "thallium": 3
}
```

**Response:**

```json
{
  "prediction": 1,
  "probability": 0.82,
  "message": "Prediction successful",
  "input_data": { ... }
}
```


api link
https://racial-celine-dot98889-fd93329a.koyeb.app/
