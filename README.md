# World Life Expectancy SQL Analysis

## Project Overview

Analyzed and cleaned global life expectancy data using MySQL to identify trends and relationships between life expectancy, GDP, BMI, mortality, and country development status.

## Objectives

* Clean and prepare the dataset for analysis
* Identify and remove duplicate records
* Handle missing values in key columns
* Analyze life expectancy trends across countries and years
* Explore relationships between life expectancy and GDP, BMI, and development status
* Apply SQL window functions to analyze mortality trends

## Tools & Technologies

* **MySQL**
* **SQL**
* **Data Cleaning**
* **Exploratory Data Analysis (EDA)**

## Data Cleaning

The project includes several data-cleaning steps:

* Identified duplicate records using `Country` and `Year`
* Used `ROW_NUMBER()` and window functions to identify duplicate rows
* Removed duplicate records from the dataset
* Identified and filled missing values in the `Status` column
* Identified missing values in the `Life Expectancy` column
* Estimated missing life expectancy values using the average of the surrounding years
* Checked for invalid or zero values before analysis

## Exploratory Data Analysis

The analysis explores:

* Minimum and maximum life expectancy by country
* Changes in life expectancy over the observed period
* Average life expectancy by country and year
* Average GDP and life expectancy by country
* Life expectancy differences between higher- and lower-GDP groups
* Life expectancy by development status
* Relationship between BMI and life expectancy
* Adult mortality trends over time

## SQL Techniques Used

The project demonstrates practical use of:

* `SELECT`
* `WHERE`
* `GROUP BY`
* `HAVING`
* `ORDER BY`
* `JOIN`
* `UPDATE`
* `DELETE`
* `CASE`
* Aggregate functions such as `AVG()`, `MIN()`, `MAX()`, and `SUM()`
* `CONCAT()`
* `ROW_NUMBER()`
* Window functions
* `PARTITION BY`
* `LIKE`

## Window Function Analysis

A rolling calculation was created using:

```sql
SUM(`Adult Mortality`) OVER(
    PARTITION BY country 
    ORDER BY year
) AS Rolling_table
```

This partitions the data by country and calculates a cumulative adult mortality value in year order, allowing mortality trends to be examined over time.

## Key Analysis Areas

### Life Expectancy

Compared minimum and maximum life expectancy across countries to identify changes over the observed period.

### GDP & Life Expectancy

Compared average GDP with average life expectancy and grouped records based on GDP levels to explore differences in life expectancy.

### Development Status

Compared average life expectancy between developed and developing countries.

### BMI & Life Expectancy

Compared average BMI and life expectancy across countries to explore potential patterns between the two variables.

### Adult Mortality

Used SQL window functions to calculate cumulative adult mortality by country and year.

## Skills Demonstrated

* SQL Data Cleaning
* Exploratory Data Analysis
* Data Transformation
* Analytical SQL
* Window Functions
* Data Quality Checks
* Trend Analysis
* Aggregation and Grouping
* Handling Missing Data
* Relational Data Analysis

## Future Improvements

* Build an interactive Power BI dashboard using the cleaned dataset
* Add visualizations for life expectancy, GDP, BMI, and mortality trends
* Perform statistical correlation analysis using Python
* Develop additional country-level insights

## Project Structure

```text
world-life-expectancy-sql-analysis/
│
├── README.md
│
└── world_life_expectancy_analysis.sql
```
