-- Tsunami rate by year
SELECT
  Year,
  COUNT(*)                               AS total_events,
  SUM(tsunami)                           AS tsunami_events,
  ROUND(AVG(tsunami),3)                  AS tsunami_rate,
  ROUND(AVG(magnitude),2)                AS avg_mag,
  ROUND(AVG(depth), 1)                   AS avg_depth
FROM `tsunami-risk-assessment.tsunami.v_earthquake_processed`
GROUP BY Year
ORDER BY Year;
