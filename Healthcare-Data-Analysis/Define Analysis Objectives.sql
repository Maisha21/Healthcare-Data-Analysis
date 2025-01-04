-- Step 1: Define Analysis Objectives

-- 1. Most Common Medical Conditions by Age Group or Gender
-- By Group

-- -- Select the derived column 'Age_Group' which categorizes the age into different groups: 'Child', 'Young Adult', 'Adult', and 'Senior'.
SELECT 
CASE 
WHEN Age BETWEEN 0 AND 18 THEN 'Child'
WHEN Age BETWEEN 19 AND 35 THEN 'Young Adult'
WHEN Age BETWEEN 36 AND 60 THEN 'Adult'
ELSE 'Senior'
END AS Age_Group, 
`Medical Condition`, -- Select the column 'Medical Condition' as is.
COUNT(*) AS Condition_Count  -- Count the number of records for each 'Age_Group' and 'Medical Condition' combination.
FROM healthcare_staging -- Specify the source table to retrieve the data from.
GROUP BY Age_Group, `Medical Condition` -- Group the results by 'Age_Group' and 'Medical Condition' to calculate the count for each group.
ORDER BY Age_Group, `Condition_Count` DESC; -- Order the results by 'Age_Group' (to maintain logical age group sequence) 
											-- and then by 'Condition_Count' in descending order to show the most frequent conditions first within each group.
                                            
-- By Gender
-- Select the columns and calculate the count of occurrences for each gender and medical condition.
SELECT 
Gender, `Medical Condition`, -- Select the column
COUNT(*) AS Condition_Count -- Count the number of occurrences for each 'Gender' and 'Medical Condition' combination.
FROM healthcare_staging
GROUP BY Gender, `Medical Condition` -- Group the results by 'Gender' and 'Medical Condition' to aggregate the data for these categories.
ORDER BY Gender, Condition_Count DESC; -- Sort the results first by 'Gender' (alphabetically or as defined by database collation) 
                                       -- and then by 'Condition_Count' in descending order to display the most frequent conditions first for each gender.

-- 2. Hospitals or Doctors with the Highest Patient Volume

-- By Hospital:

SELECT Hospital, 
COUNT(*) AS Total_Patients -- Count the total number of patients for each hospital.
FROM healthcare_staging
GROUP BY Hospital
ORDER BY Total_Patients DESC
LIMIT 10; -- Top 10 Hospital 

-- By Doctor

SELECT 
Doctor, 
COUNT(*) AS Total_Patients
FROM healthcare_staging
GROUP BY Doctor
ORDER BY Total_Patients DESC
LIMIT 10; -- TOP 10 Doctors

-- 3. Average Billing Amount by Admission Type or Hospital

-- By Admission Type

SELECT 
`Admission Type`, -- Select the column 'Admission Type' to group data by the type of hospital admission.
AVG(`Billing Amount`) AS Avg_Billing_Amount, -- Calculate the average billing amount for each admission type.
COUNT(*) AS Total_Admission -- Count the total number of admissions for each admission type.
FROM healthcare_staging
GROUP BY `Admission Type` -- Group the results by 'Admission Type' to calculate aggregate values for each type
ORDER BY Avg_Billing_Amount DESC;

-- By Hospital 

SELECT 
Hospital, -- Select the hospital names and calculate the average billing amount and total number of admissions for each hospital
AVG(`Billing Amount`) As Avg_Billing_Amount, -- Calculate the average of the 'Billing Amount' for each hospital
COUNT(*) AS Total_Admission -- Count the total number of admissions for each hospital
FROM healthcare_staging
GROUP BY Hospital
ORDER BY Avg_Billing_Amount DESC; -- Sort the results by the average billing amount in descending order 
								  -- to display hospitals with the highest average billing amount at the top

-- 4. Patterns in Admission Dates (Seasonal Trends)

-- Admissions by Season:

SELECT  -- Classify admissions by season based on the month of admission and calculate total admissions for each season

CASE     -- Use a CASE statement to determine the season based on the month of the 'Date of Admission'
WHEN MONTH (`Date of Admission`) IN (12, 1, 2) THEN 'Winter'
WHEN MONTH (`Date of Admission`) IN (3, 4, 5) THEN 'Spring'
WHEN MONTH (`Date of Admission`) IN (6, 7, 8) THEN 'Summer'
ELSE 'Fall'
END AS Season,
COUNT(*) AS Total_Admission -- Count the total number of admissions for each season
FROM healthcare_staging
GROUP BY Season
ORDER BY Total_Admission DESC; -- Sort the results in descending order of total admissions 
                               -- to display the season with the highest number of admissions first
-- Admissions by Month:

SELECT 
MONTH (`Date of Admission`) AS Month, -- Retrieve the total number of admissions for each month 
COUNT(*) AS Total_Admission -- Count the total number of admissions for each month
FROM healthcare_staging
GROUP BY Month 
ORDER BY Month ASC; -- Sort the results in ascending order of 'Month' 
                    -- to display the data in chronological order (January to December)
                    
-- 5. Impact of Insurance Providers on Patient Demographics and Billing

-- Patient Demographics by Insurance Provider:

SELECT -- Retrieve the total number of patients grouped by insurance provider and gender
`Insurance Provider`,
Gender, 
COUNT(*) AS Patient_Count -- Count the total number of patients for each combination of insurance provider and gender
FROM healthcare_staging
-- Group the results by both 'Insurance Provider' and 'Gender'
-- This ensures that the patient count is calculated for each combination of insurance provider and gender
GROUP BY `Insurance Provider`, Gender
-- Sort the results first alphabetically by 'Insurance Provider'
-- Then sort by 'Patient_Count' in descending order to prioritize combinations with the most patients
ORDER BY `Insurance Provider`, Patient_Count DESC;

-- Billing Amount by Insurance Provider:

SELECT -- Select the Insurance Provider, Average Billing Amount, and Total Patient Count
`Insurance Provider`,
AVG(`Billing Amount`) AS Avg_Billing_Amount, -- Calculates the average billing amount for each insurance provider
COUNT(*) AS Total_Patients -- Counts the total number of patients associated with each insurance provider
FROM healthcare_staging
GROUP BY `Insurance Provider` -- Groups the data by each unique insurance provider
ORDER BY Avg_Billing_Amount DESC; -- Orders the results by average billing amount in descending order




