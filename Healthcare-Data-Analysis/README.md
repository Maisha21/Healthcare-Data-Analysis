# Healthcare Data Analysis Project

## Overview
This project involves analyzing a healthcare dataset to uncover meaningful insights into patient demographics, medical trends, and hospital performance. The dataset was sourced from Kaggle ([Healthcare Dataset](https://www.kaggle.com/datasets/prasad22/healthcare-dataset)) and cleaned and analyzed using SQL.

### Key Components
1. Clean raw data for analysis.
2. Define analysis objectives.
3. Insights and Recommendations

### Tools and Technologies
- SQL for data cleaning and analysis.
- Visual Studio Code.
- Git and GitHub for version control.

## Data Cleaning

The data cleaning process ensured the dataset was ready for analysis. Key steps included:

- **Removing duplicates**: Ensured unique patient records by retaining the first occurrence based on all columns.
- **Standardizing data**: Formatted text fields, corrected inconsistent gender representations, and handled leading/trailing spaces.
- **Data type formatting**: Adjusted data types for accuracy, e.g., converting dates to `DATE` format and setting constraints for      categorical values like Gender and Admission Type.

## Analysis Objectives

The analysis addressed the following objectives:
1. **Most Common Medical Conditions**:
   - Explored by age group and gender.
2. **Hospitals and Doctors with the Highest Patient Volume**:
   - Identified top-performing hospitals and doctors by patient count.
3. **Average Billing Amount**:
   - Compared billing amounts across admission types and hospitals.
4. **Seasonal Trends in Admissions**:
   - Examined patterns in hospital admissions by season and month.
5. **Impact of Insurance Providers**:
   - Analyzed patient demographics and billing trends by insurance provider.

## Findings and Insights

### 1. Medical Conditions by Demographics
- **Age Group Trends**: Seniors have a higher prevalence of chronic conditions like hypertension and diabetes.
- **Gender Differences**: Certain conditions, such as anemia, are more common among females.

### 2. Top Hospitals and Doctors
- The top 10 hospitals and doctors by patient volume were identified, highlighting facilities with high patient trust and satisfaction.

### 3. Billing Insights
- **Admission Type**: Emergency admissions had the highest average billing amount.
- **Hospitals**: Some hospitals showed significantly higher average billing amounts, potentially reflecting specialized care or inefficiencies.

### 4. Seasonal Admission Patterns
- **Seasonal Trends**: Winter saw the highest admissions, possibly due to flu season.
- **Monthly Patterns**: Admissions peaked in January and December.

### 5. Insurance Provider Analysis
- Providers with higher patient counts generally had lower average billing amounts, indicating potential negotiated rates.
- Gender distribution among providers revealed a near-equal split, with slight variations.

## Recommendations

1. **Optimizing Resource Allocation**:
   - Plan resources during peak admission months and seasons to improve patient care.
2. **Cost Efficiency**:
   - Investigate billing practices at hospitals with high average billing to identify areas for cost optimization.
3. **Preventive Care**:
   - Tailor preventive programs for seniors and specific gender-related conditions to reduce future admissions.
4. **Insurance Collaboration**:
   - Work with insurance providers to understand demographic trends and optimize billing policies.

## Conclusion

This project demonstrates how data cleaning and analysis can uncover actionable insights in the healthcare sector. These insights can drive better decision-making, from resource allocation to patient care strategies.