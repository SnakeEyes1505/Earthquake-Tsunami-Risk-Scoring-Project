-- Q1: Tsunami prediction & risk factors
-- Tsunami rate by magnitude_class and depth_class
SELECT
  magnitude_class,
  depth_class,
  COUNT(*)                           AS events,
  SUM(tsunami)                       AS tsunami_events,
  ROUND(AVG(tsunami), 3)             AS tsunami_rate,           
  ROUND(AVG(magnitude), 2)           AS avg_magnitude,
  ROUND(AVG(depth), 1)               AS avg_depth,
  ROUND(AVG(tsunami_risk_score), 3)  AS avg_risk_score  
FROM `tsunami-risk-assessment.tsunami.v_earthquake_processed`
GROUP BY magnitude_class, depth_class
ORDER BY magnitude_class, depth_class;
