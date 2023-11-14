#US Household Income Data Cleaning

SELECT *
 FROM us_householdincome.us_household_income;


SELECT * 
FROM us_householdincome.us_household_income_statistics;


#change the row name 
ALTER TABLE us_householdincome.us_household_income_statistics RENAME COLUMN `ï»¿id` TO  `ID`;


SELECT COUNT(ID)
 FROM us_householdincome.us_household_income;


SELECT ID, COUNT(ID)
FROM us_householdincome.us_household_income_statistics;


-- Select IDs and the count of occurrences where ID appears more than once

SELECT ID, COUNT(ID)
FROM us_householdincome.us_household_income
GROUP BY ID
HAVING COUNT(ID) > 1;







-- Select all columns from rows in us_householdincome.us_household_income  where the ID appears more than once, along with row numbers
SELECT *
FROM (
    -- Select row_ID, ID, and assign row numbers within each partition of IDs
    SELECT row_ID,
           ID, 
           ROW_NUMBER() OVER (PARTITION BY ID ORDER BY ID) as row_num
    FROM us_householdincome.us_household_income
) AS duplicates
-- Filter to include only rows where the row number is greater than 1 (indicating duplicates)
WHERE row_num > 1;









-- DELETE  ID appears more than once IN us_household_income


DELETE FROM us_householdincome.us_household_income
WHERE row_id IN (
    SELECT row_id
	FROM (
    -- Select row_ID, ID, and assign row numbers within each partition of IDs
	SELECT row_ID,
	ID, 
	ROW_NUMBER() OVER (PARTITION BY ID ORDER BY ID) as row_num
    FROM us_householdincome.us_household_income
    ) AS duplicates
-- Filter to include only rows where the row number is greater than 1 (indicating duplicates)
   WHERE row_num > 1)
   ;










-- Select the distinct State_Name values and count the occurrences of each state
SELECT 
  -- State_Name column represents the names of states
  State_Name,
  
  -- COUNT(State_Name) calculates the number of occurrences for each state
  COUNT(State_Name) AS State_Count
  
-- From the "us_household_income" table in the "us_householdincome" schema or database
FROM us_householdincome.us_household_income

-- Group the results by the "State_Name" column
GROUP BY State_Name;









-- Select distinct State_Name values from the "us_household_income" table
SELECT 
  -- DISTINCT ensures that only unique State_Name values are included in the result
  DISTINCT State_Name
  
-- From the "us_household_income" table in the "us_householdincome" schema or database
FROM us_householdincome.us_household_income

-- Order the results by the first column (1-indexed), which is State_Name in this case
ORDER BY 1;






-- Update the "State_Name" column in the "us_household_income" table
UPDATE us_householdincome.us_household_income

-- Set the value of "State_Name" to 'Georgia' where it currently equals 'georia'
SET State_Name = 'Georgia'

-- Only update rows where the current value of "State_Name" is 'georia'
WHERE State_Name = 'georia';









UPDATE us_householdincome.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';






-- Select all columns from the "us_household_income" table
SELECT *
  
-- From the "us_household_income" table in the "us_householdincome" schema or database
FROM us_householdincome.us_household_income

-- Filter the results to include only rows where "County" is 'Autauga County'
WHERE County = 'Autauga County'

-- Order the results by the first column (1-indexed)
ORDER BY 1;









-- Update the "Place" column in the "us_household_income" table
UPDATE us_householdincome.us_household_income

-- Set the value of "Place" to 'AutaugaVille' where conditions are met
SET Place = 'AutaugaVille'

-- Update rows where "County" is 'Autauga County' and "City" is 'Vinemont'
WHERE County = 'Autauga County'
  AND City = 'Vinemont';








-- Select distinct "Type" values and count occurrences of each type
SELECT 
  -- Type column represents the different types
  Type, 
  
  -- COUNT(Type) calculates the number of occurrences for each type
  COUNT(Type) AS Type_Count

-- From the "us_household_income" table in the "us_householdincome" schema or database
FROM us_householdincome.us_household_income

-- Group the results by the "Type" column
GROUP BY Type;






-- Update the "Type" column in the "us_household_income" table
UPDATE us_householdincome.us_household_income

-- Set the value of "Type" to 'Borough' where it currently equals 'Boroughs'
SET Type = 'Borough'

-- Only update rows where the current value of "Type" is 'Boroughs'
WHERE Type = 'Boroughs';






-- Select columns ALand and AWater from the "us_household_income" table
SELECT 
  -- ALand column represents the land area
  ALand,
  
  -- AWater column represents the water area
  AWater
  
-- From the "us_household_income" table in the "us_householdincome" schema or database
FROM us_householdincome.us_household_income

-- Filter the results to include only rows where AWater is 0, an empty string, or NULL
WHERE AWater = 0 OR AWater = '' OR AWater IS NULL;







-- Select columns ALand and AWater from the "us_household_income" table
SELECT 
  -- ALand column represents the land area
  ALand,
  
  -- AWater column represents the water area
  AWater
  
-- From the "us_household_income" table in the "us_householdincome" schema or database
FROM us_householdincome.us_household_income

-- Filter the results to include only rows where ALand is 0, an empty string, or NULL
WHERE ALand = 0 OR ALand = '' OR ALand IS NULL;



























