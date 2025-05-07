# data_analysis.py
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
import joblib
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

def load_and_clean_data():
    # Load dataset
    df = pd.read_csv('data/Heart_Disease_Prediction.csv')
    
    # Rename columns to be more API-friendly
    df.columns = df.columns.str.replace(' ', '_').str.lower()
    
    # Convert target to binary (0 for Absence, 1 for Presence)
    df['heart_disease'] = df['heart_disease'].map({'Absence': 0, 'Presence': 1})
    
    # Check for missing values
    print("Missing values per column:")
    print(df.isnull().sum())
    
    # Handle any missing values (this dataset appears complete)
    numerical_cols = df.select_dtypes(include=['int64', 'float64']).columns
    df[numerical_cols] = df[numerical_cols].fillna(df[numerical_cols].median())
    
    # Check for duplicates
    print(f"\nNumber of duplicates: {df.duplicated().sum()}")
    df = df.drop_duplicates()
    
    return df

def train_model(df):
    # Split data into features and target
    X = df.drop('heart_disease', axis=1)
    y = df['heart_disease']
    
    # Split into train and test sets
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )
    
    # Train logistic regression model
    model = LogisticRegression(max_iter=1000)
    model.fit(X_train, y_train)
    
    # Evaluate model
    y_pred = model.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)
    print(f"\nModel Accuracy: {accuracy:.2f}")
    
    # Save the model
    os.makedirs('models', exist_ok=True)
    joblib.dump(model, 'models/heart_disease_model.pkl')
    
    return model

if __name__ == '__main__':
    df = load_and_clean_data()
    train_model(df)