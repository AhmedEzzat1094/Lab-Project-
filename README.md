# ❤️ Heart Disease Risk Checker App

A simple Flutter application that allows users to input symptoms and checks if they may be at risk for heart disease. The app sends the data to a backend API for analysis and returns a clear result to the user.

---

## 🏥 Overview

This Flutter app is designed to help users get a quick risk assessment based on common heart disease symptoms. Users fill out a form with their symptoms, and the app sends the data to a machine learning model via an API. Based on the response:

- If **no risk is detected**, a popup shows: ✅ **No risk detected**
- If **risk is detected**, a popup shows: ⚠️ **Risk detected**

---

## 🚀 Features

- Easy-to-use symptom input form  
- Real-time communication with a backend API  
- Clear result through a popup message  
- Clean and responsive UI  
- Works on Android and iOS

---

## 🔧 How It Works

1. User opens the app and enters their symptoms.  
2. Symptoms are validated and sent to a RESTful API.  
3. The API returns whether the user is at risk.  
4. The app displays a popup with the result.

---

## 📷 Screenshots

![App Demo](![Record_2025-05-08-21-06-18_aeeeeffb1c0cc2b30fd2f6e289ce37ba](https://github.com/user-attachments/assets/e8b6eb02-5767-4710-9828-9fd98290f685)
)

---

## 🛠️ Technologies Used

- **Flutter** (Frontend)  
- **Dart**  
- **REST API** for prediction  

---

## 📦 How to Run the App

1. Clone this repository:
   ```
   git clone https://github.com/AhmedEzzat1094/Lab-Project-.git
   ```
2. Switch to flutter branch:
   ```
   git switch flutter
   ```
3. Navigate to the project folder:
   ```
   cd heart-disease-checker
   ```
4. Install dependencies:
   ```
   flutter pub get
   ```
5. Run the app:
   ```
   flutter run
   ```

---

## 📡 API Information

Ensure the API is up and running. The app sends a POST request with symptom data like:

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

And receives a response like:

```json
{
  "prediction": 1,
  "probability": 0.82,
  "message": "Prediction successful",
  "input_data": { ... }
}
```

---

## 🧠 Disclaimer

This app is for **educational purposes only** and should not be used as a substitute for professional medical advice.
