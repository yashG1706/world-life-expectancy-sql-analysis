# World Life Expectancy Project (Data Cleaning)


SELECT * FROM world_life_expectancy
;


# identifying Duplicates


SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country,Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country,Year)
HAVING COUNT(CONCAT(Country,Year)) > 1
;


# Identifying row_id of duplicates

SELECT *
FROM (
      SELECT Row_ID,
      CONCAT (country, year),
      ROW_NUMBER() OVER (PARTITION BY CONCAT(country, year) ORDER BY CONCAT(country,year)) AS Row_Num
      FROM world_life_expectancy
      ) AS Row_table
WHERE Row_Num > 1 
;


# Deleting the Duplicates

DELETE FROM world_life_expectancy
WHERE
     Row_ID IN (
     SELECT Row_ID
FROM (
       SELECT Row_ID,
      CONCAT (country, year),
      ROW_NUMBER() OVER (PARTITION BY CONCAT(country, year) ORDER BY CONCAT(country,year)) AS Row_Num
      FROM world_life_expectancy
      ) AS Row_table
WHERE Row_Num > 1
) 
;


# Identifying Blank Space (Status column)


SELECT *
FROM world_life_expectancy
WHERE status = ''
;

SELECT DISTINCT(status)
FROM world_life_expectancy
WHERE status <> ''
;

SELECT DISTINCT (country)
FROM world_life_expectancy
WHERE status = 'Developing'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.country = t2.country
SET t1.status = 'Developing'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developing'
;


SELECT*
FROM world_life_expectancy
WHERE country = 'United States of America'
;


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.country = t2.country
SET t1.status = 'Developed'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developed'
;


# Identifying Blank Space (life expectancy column)

SELECT*
FROM world_life_expectancy
WHERE `life expectancy` = ''
;

# Getting the average for blank space of life expectancy column

SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
;

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy`+t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
    ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
    ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy`+t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;


SELECT * FROM world_life_expectancy
;




# Exploratory Data Analysis(EDA)


SELECT country, MIN(`life expectancy`), MAX(`life expectancy`)
FROM world_life_expectancy
GROUP BY country
ORDER BY country DESC
;


# Removing Zero from table

SELECT country, MIN(`life expectancy`), MAX(`life expectancy`)
FROM world_life_expectancy
GROUP BY country
HAVING MIN(`life expectancy`) <>0
AND    MAX(`life expectancy`) <>0
ORDER BY country ASC
;   



# Highest Life Expectancy Rate

SELECT country,
MIN(`life expectancy`),
MAX(`life expectancy`),
ROUND(MAX(`life expectancy`) - MIN(`life expectancy`),1) AS Life_Increase_15_years
FROM world_life_expectancy
GROUP BY country
HAVING MIN(`life expectancy`) <>0
AND    MAX(`life expectancy`) <>0
ORDER BY Life_Increase_15_years DESC
;


# Lowest Life Expectancy

SELECT country,
MIN(`life expectancy`),
MAX(`life expectancy`),
ROUND(MAX(`life expectancy`) - MIN(`life expectancy`),1) AS Life_Increase_15_years
FROM world_life_expectancy
GROUP BY country
HAVING MIN(`life expectancy`) <>0
AND    MAX(`life expectancy`) <>0
ORDER BY Life_Increase_15_years ASC
;


# Average Life Expectancy

SELECT year,
       country,
       ROUND(AVG(`life expectancy`),2) AS Average_Life_Expectancy
FROM world_life_expectancy
WHERE `life expectancy` <>0
AND   `life expectancy` <>0
GROUP BY year,country
ORDER BY year,country
;  



# Getting AVG GDP, AVG Life expectancy

SELECT country,
       ROUND(AVG(`life expectancy`),1 ) AS Life_Exp,
	   ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY country
;


# Correlation

SELECT country,
       ROUND(AVG(`life expectancy`),1 ) AS Life_Exp,
	   ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY country
HAVING life_Exp > 0
AND GDP > 0
ORDER BY GDP ASC
;


SELECT country,
       ROUND(AVG(`life expectancy`),1 ) AS Life_Exp,
	   ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY country
HAVING life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;



SELECT SUM(CASE WHEN GDP >=1500 THEN 1 ELSE 0 END) High_GDP_Count
FROM world_life_expectancy
;


SELECT SUM(CASE WHEN GDP >=1500 THEN 1 ELSE 0 END) High_GDP_Count,
       AVG(CASE WHEN GDP >=1500 THEN `life expectancy` ELSE NULL END) High_GDP_life_expectancy,
       
       SUM(CASE WHEN GDP <=1500 THEN 1 ELSE 0 END) Low_GDP_Count,
       AVG(CASE WHEN GDP <=1500 THEN `life expectancy` ELSE NULL END) Low_GDP_life_expectancy
       
FROM world_life_expectancy
;



# CORRELATION between status and life expectancy

SELECT status,
ROUND (AVG(`life expectancy`),1)
FROM world_life_expectancy
GROUP BY status
;


SELECT status, COUNT(DISTINCT country),
               ROUND (AVG(`life expectancy`),1)
FROM world_life_expectancy
GROUP BY status
;


# CORRELATION between BMI and life expectancy

SELECT country, ROUND(AVG(`life expectancy`),1) AS life_exp,
                ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY country
HAVING life_exp > 0
AND BMI > 0
ORDER BY BMI ASC
;


SELECT country, ROUND(AVG(`life expectancy`),1) AS life_exp,
                ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY country
HAVING life_exp > 0
AND BMI > 0
ORDER BY BMI DESC
;



SELECT country, year, `life expectancy`, `Adult Mortality`,
       SUM(`Adult Mortality`) OVER(PARTITION BY country ORDER BY year) AS Rolling_table
FROM world_life_expectancy
;


SELECT country, year, `life expectancy`, `Adult Mortality`,
       SUM(`Adult Mortality`) OVER(PARTITION BY country ORDER BY year) AS Rolling_table
FROM world_life_expectancy
WHERE country like '%United states%'
;