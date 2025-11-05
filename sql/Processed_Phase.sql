CREATE OR REPLACE VIEW `tsunami-risk-assessment.tsunami.v_earthquake_processed` AS
SELECT
  *,
  CASE
    WHEN magnitude >= 8 THEN 'Severe'
    WHEN magnitude >= 7 THEN 'Strong'
    ELSE 'Moderate'
  END AS magnitude_class,
  CASE
    WHEN depth < 70 THEN 'Shallow'
    WHEN depth BETWEEN 70 AND 300 THEN 'Intermediate'
    ELSE 'Deep'
  END AS depth_class,
  (0.4*magnitude + 0.2*mmi + 0.2*cdi + 0.2*(sig/1000)) AS earthquake_severity_index,
  (0.5*magnitude + 0.3*(1/(depth + 1)) + 0.2*(sig/1000)) AS tsunami_risk_score,
  (magnitude - 6.5)/(9.1 - 6.5) AS norm_magnitude,
  (depth - 2.7)/(670.8 - 2.7) AS norm_depth,

  CONCAT('Q', CAST(DIV(EXTRACT(MONTH FROM event_date)-1,3)+1 AS STRING)) AS quarter

FROM `tsunami-risk-assessment.tsunami.v_earthquake_cleaned`;
