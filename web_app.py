import joblib
import streamlit as st
import pandas as pd

model = joblib.load("outcome_predictor_r.pkl")

st.title("🎓 Student Outcome Prediction App")
st.markdown("Please enter the following inputs:")

st.divider()

age = st.number_input("Age at enrollment", min_value=17, max_value=70, step=1)
grade_1st = st.number_input("Curricular units 1st sem (grade)", min_value=0.0, max_value=20.0, step=1.0)
scholarship = st.selectbox("Scholarship holder", options=[0, 1], format_func=lambda x: "Yes" if x == 1 else "No")
tuition_paid = st.selectbox("Tuition fees up to date", options=[0, 1], format_func=lambda x: "Yes" if x == 1 else "No")
debtor = st.selectbox("Debtor", options=[0, 1], format_func=lambda x: "Yes" if x == 1 else "No")
grade_2nd = st.number_input("Curricular units 2nd sem (grade)", min_value=0.0, max_value=20.0, step=1.0)
unemployment = st.number_input("Unemployment rate", min_value=0.0, max_value=100.0, step=0.1)
inflation = st.number_input("Inflation rate",step=0.1)
gdp = st.number_input("GDP", step=0.5)

# Predict button
if st.button("Predict Outcome"):
    input_df = pd.DataFrame([[
        age, grade_1st, scholarship, tuition_paid, debtor,
        grade_2nd, unemployment, inflation, gdp
    ]], columns=[
        "Age at enrollment",
        "Curricular units 1st sem (grade)",
        "Scholarship holder",
        "Tuition fees up to date",
        "Debtor",
        "Curricular units 2nd sem (grade)",
        "Unemployment rate",
        "Inflation rate",
        "GDP"
    ])
    
    prediction = model.predict(input_df)[0]

    outcome_map = {
        0: ("Dropout", "red"),
        1: ("Graduate", "green")
    }

    label, color = outcome_map.get(prediction, ("Unknown", "black"))

    st.markdown(f"""
        <div style='font-size: 24px; font-weight: bold; color: {color};'>
            🎯 Predicted Outcome: {label}
        </div>
    """, unsafe_allow_html=True)
