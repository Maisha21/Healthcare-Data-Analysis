-- Data Cleaning

-- 1.Remove Duplicate 

-- View data from the staging table before cleaning.
SELECT * FROM healthcare_staging; 

-- Copy data from raw table to staging table for cleaning. This keeps the raw data untouched.
INSERT healthcare_staging
SELECT * FROM healthcare_dataset;

-- Add a unique identifier column (`Patient ID`) to the staging table for easier duplicate handling.
ALTER TABLE healthcare_staging
ADD COLUMN `Patient ID` INT AUTO_INCREMENT PRIMARY KEY;

-- Temporarily disable safe update mode to allow DELETE queries without WHERE clauses on keys.
SET SQL_SAFE_UPDATES = 0; -- Disable Safe Update Mode Temporarily

-- Remove duplicate records by keeping only the first occurrence (using MIN(`Patient ID`)).
DELETE FROM healthcare_staging
WHERE `Patient ID` NOT IN (
    SELECT PatientID
    FROM (
        SELECT MIN(`Patient ID`) AS PatientID
        FROM healthcare_staging
        GROUP BY 
            Name, Age, Gender, `Blood Type`, `Medical Condition`, `Date of Admission`, Doctor, Hospital, `Insurance Provider`, 
            `Billing Amount`, `Room Number`, `Admission Type`, `Discharge Date`, Medication, `Test Results`) AS Subquery);

-- Re-enable safe update mode after running DELETE operations.
SET SQL_SAFE_UPDATES = 1; 

-- Verify no duplicates remain by checking for duplicate groups in the data.
SELECT Name, Age, Gender, COUNT(*) AS DuplicateCount
FROM healthcare_staging
GROUP BY 
    Name, Age, Gender, `Blood Type`, `Medical Condition`, `Date of Admission`, Doctor, Hospital, `Insurance Provider`, `Billing Amount`, 
    `Room Number`, `Admission Type`, `Discharge Date`, Medication, `Test Results`
HAVING COUNT(*) > 1;

-- 2. Standardize Data

-- View the structure of the table to identify columns for cleaning.
DESCRIBE healthcare_staging; -- Identify all the column

-- Remove leading and trailing spaces from all columns to ensure data consistency.
UPDATE healthcare_staging 
SET 
	`Name` = TRIM(`Name`), -- Using the TRIM() function to remove leading and trailing spaces for each column.
    Age = TRIM(Age),
    Gender = TRIM(Gender),
    `Blood Type` = TRIM(`Blood Type`),
    `Medical Condition` = TRIM(`Medical Condition`),
    `Date of Admission` = TRIM(`Date of Admission`),
    Doctor =TRIM(Doctor),
    Hospital = TRIM(Hospital),
    `Insurance Provider` = TRIM(`Insurance Provider`),
    `Billing Amount` = TRIM( `Billing Amount`),
    `Room Number` = TRIM(`Room Number`),
    `Admission Type` = TRIM(`Admission Type`),
    `Discharge Date` = TRIM(`Discharge Date`),
    Medication = TRIM(Medication),
    `Test Results` = TRIM(`Test Results`),
    `Patient ID` = TRIM(`Patient ID`);
    
    -- Standardize the Name column to proper case format.
UPDATE healthcare_staging
SET Name = CONCAT(
    UPPER(LEFT(SUBSTRING_INDEX(Name, ' ', 1), 1)), 
    LOWER(SUBSTRING(SUBSTRING_INDEX(Name, ' ', 1), 2)),
    ' ',
    UPPER(LEFT(SUBSTRING_INDEX(Name, ' ', -1), 1)),
    LOWER(SUBSTRING(SUBSTRING_INDEX(Name, ' ', -1), 2))
)
WHERE Name LIKE '% %';
SELECT * FROM healthcare_staging;

-- Ensure Gender values are consistent by mapping different representations to standard values.
UPDATE healthcare_staging
SET Gender = CASE
WHEN Gender = 'male' THEN 'Male'
WHEN Gender = 'M' THEN 'Male'
WHEN Gender = 'female' THEN 'Female'
WHEN Gender = 'F' THEN 'Female'
ELSE Gender
END;
SELECT * FROM healthcare_staging;

-- Check for NULL values in each column to identify missing data.
SELECT 
    SUM(CASE WHEN Name IS NULL THEN 1 ELSE 0 END) AS Name_Null_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
    SUM(CASE WHEN `Blood Type` IS NULL THEN 1 ELSE 0 END) AS BloodType_Null_Count,
    SUM(CASE WHEN `Medical Condition` IS NULL THEN 1 ELSE 0 END) AS MedicalCondition_Null_Count,
    SUM(CASE WHEN `Date Of Admission` IS NULL THEN 1 ELSE 0 END) AS DateOfAdmission_Null_Count,
    SUM(CASE WHEN Doctor IS NULL THEN 1 ELSE 0 END) AS Doctor_Null_Count,
    SUM(CASE WHEN Hospital IS NULL THEN 1 ELSE 0 END) AS Hospital_Null_Count,
    SUM(CASE WHEN `Insurance Provider` IS NULL THEN 1 ELSE 0 END) AS InsuranceProvider_Null_Count,
    SUM(CASE WHEN `Billing Amount` IS NULL THEN 1 ELSE 0 END) AS BillingAmount_Null_Count,
    SUM(CASE WHEN `Room Number` IS NULL THEN 1 ELSE 0 END) AS RoomNumber_Null_Count,
    SUM(CASE WHEN `Admission Type` IS NULL THEN 1 ELSE 0 END) AS AdmissionType_Null_Count,
    SUM(CASE WHEN `Discharge Date` IS NULL THEN 1 ELSE 0 END) AS DischargeDate_Null_Count,
    SUM(CASE WHEN Medication IS NULL THEN 1 ELSE 0 END) AS Medication_Null_Count,
    SUM(CASE WHEN `Test Results` IS NULL THEN 1 ELSE 0 END) AS TestResults_Null_Count
FROM healthcare_staging;

-- 3. Data Type Formatting

-- View the table structure to identify necessary data type adjustments.
DESCRIBE healthcare_staging;

-- Change columns to appropriate data types for consistency and accuracy.
ALTER TABLE healthcare_staging
MODIFY COLUMN `Date of Admission` DATE;

ALTER TABLE healthcare_staging
MODIFY COLUMN `Discharge Date` DATE;

ALTER TABLE healthcare_staging
MODIFY COLUMN `Gender` ENUM('Male','Female') DEFAULT 'Male';

ALTER TABLE healthcare_staging
MODIFY COLUMN `Admission Type` ENUM('Emergency', 'Elective', 'Urgent');

ALTER TABLE healthcare_staging
MODIFY COLUMN `Billing Amount` Decimal(10,2);

ALTER TABLE healthcare_staging
MODIFY COLUMN `Test Results` ENUM('Normal', 'Abnormal', 'Inconclusive');

-- Update text-based columns to appropriate lengths and formats.
ALTER TABLE healthcare_staging
MODIFY COLUMN `Name` VARCHAR(255),
MODIFY COLUMN `Doctor` VARCHAR(255),
MODIFY COLUMN `Hospital` VARCHAR(255),
MODIFY COLUMN `Medical Condition` VARCHAR(255),
MODIFY COLUMN `Medication` VARCHAR(255);






    

