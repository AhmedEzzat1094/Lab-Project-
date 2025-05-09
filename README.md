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

(Add screenshots here if available)

---

## 🛠️ Technologies Used

- **Flutter** (Frontend)  
- **Dart**  
- **REST API** for prediction  
- **Provider / Bloc** (optional, for state management)

---

## 📦 How to Run the App

1. Clone this repository:
   ```
   git clone https://github.com/your-username/heart-disease-checker.git
   ```
2. Navigate to the project folder:
   ```
   cd heart-disease-checker
   ```
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Run the app:
   ```
   flutter run
   ```

---

## 📡 API Information

Ensure the API is up and running. The app sends a POST request with symptom data like:

```json
{
  "age": 45,
  "chest_pain": 1,
  "blood_pressure": 130
}
```

And receives a response:

```json
{
  "risk": true  // or false
}
```

---

## 📬 Contact

For any questions or suggestions, feel free to reach out via GitHub Issues or email at `your.email@example.com`.

---

## 🧠 Disclaimer

This app is for **educational purposes only** and should not be used as a substitute for professional medical advice.