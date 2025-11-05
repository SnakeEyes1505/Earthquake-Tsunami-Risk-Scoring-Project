CREATE OR REPLACE TABLE `tsunami-risk-assessment.tsunami.v_earthquake_cleaned` AS
SELECT 
  DISTINCT *,
  PARSE_DATE('%Y-%m', CONCAT(CAST(Year AS STRING), '-', LPAD(CAST(Month AS STRING), 2, '0'))) AS event_date
FROM `tsunami-risk-assessment.tsunami.earthquake_data_tsunami`
WHERE 
  magnitude BETWEEN 6.5 AND 9.1
  AND depth BETWEEN 2.7 AND 670.8;
