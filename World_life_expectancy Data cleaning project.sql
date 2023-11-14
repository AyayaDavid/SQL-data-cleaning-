# World Life Expectancy Project (Data Cleaning)

SELECT * FROM world_life_expectancy.world_life_expectancy;

SELECT *
FROM world_life_expectancy.world_life_expectancy
WHERE Status  IS NULL
;


#retrieves distinct "Status" values from the "world_life_expectancy" table
SELECT DISTINCT(Status)
FROM world_life_expectancy.world_life_expectancy 
WHERE Status <> ''

;

#Select distinct (unique) countries where the "Status" is 'Developing
SELECT DISTINCT(Country)
FROM world_life_expectancy.world_life_expectancy 
WHERE Status = 'Developing';






# Update the "Status" to 'Developing' for rows in the same table
# where "Status" is blank ('') and there's a corresponding row with a "Status" of 'Developing'
 
UPDATE world_life_expectancy.world_life_expectancy  t1
JOIN world_life_expectancy.world_life_expectancy  t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'
;

SELECT * 
FROM world_life_expectancy.world_life_expectancy 
WHERE Country = 'United States of America'
;

# Update the "Status" to 'Developing' for rows in the same table
# where "Status" is blank ('') and there's a corresponding row with a "Status" of 'Developed'

UPDATE world_life_expectancy.world_life_expectancy  t1
JOIN world_life_expectancy.world_life_expectancy  t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;



-- Select columns Country, Year, and Life expectancy from the table
SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy.world_life_expectancy
-- Commented out WHERE clause, which was presumably used for filtering

-- Select specific columns from three instances of the same table (t1, t2, and t3)
SELECT t1.Country, t1.Year, t1.`Life expectancy`, 
       t2.Country, t2.Year, t2.`Life expectancy`, 
       t3.Country, t3.Year, t3.`Life expectancy`,
       -- Calculate the rounded average of Life expectancy from t2 and t3
       ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2, 1)
FROM world_life_expectancy.world_life_expectancy t1
-- Perform a JOIN with the same table (t2) based on the "Country" and "Year" columns
JOIN world_life_expectancy.world_life_expectancy t2
  ON t1.Country = t2.Country 
  AND t1.Year = t2.Year - 1
-- Perform another JOIN with the same table (t3) based on the "Country" and "Year" columns
JOIN world_life_expectancy.world_life_expectancy t3
  ON t1.Country = t3.Country 
  AND t1.Year = t3.Year + 1
-- Filter the results to include only rows where "Life expectancy" in t1 is blank
WHERE t1.`Life expectancy` = '';




-- Update the "Life expectancy" column in the table
UPDATE world_life_expectancy.world_life_expectancy t1

-- Perform a JOIN with the same table (t2) based on the "Country" and "Year" columns
JOIN world_life_expectancy.world_life_expectancy t2
  ON t1.Country = t2.Country 
  AND t1.Year = t2.Year - 1

-- Perform another JOIN with the same table (t3) based on the "Country" and "Year" columns
JOIN world_life_expectancy.world_life_expectancy t3
  ON t1.Country = t3.Country 
  AND t1.Year = t3.Year + 1

-- Set the "Life expectancy" in the first table (t1) to the rounded average of t2 and t3
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2, 1)

-- Apply the update only to rows where "Life expectancy" in t1 is blank
WHERE t1.`Life expectancy` = '';
















#Identify duplicate in the country columns 

SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy.world_life_expectancy 
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1 ;



#Identify duplicate by ROw_ID in the country columns 

SELECT *
FROM(
     SELECT Row_ID,
     CONCAT(Country, Year),
     ROW_NUMBER() OVER( PARTITION BY CONCAT (Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
     FROM world_life_expectancy.world_life_expectancy
     ) AS Row_table
WHERE ROW_Num > 1
;






# Delete the duplicate by row id

DELETE FROM world_life_expectancy.world_life_expectancy
WHERE
	Row_ID IN (
    SELECT Row_ID
FROM (
	 SELECT Row_ID,
     CONCAT(Country, Year),
     ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
     FROM world_life_expectancy.world_life_expectancy
     ) AS Row_table
WHERE Row_Num > 1
)
;             













