-- Q5: Risk score deciles & lift
-- Top deciles should have much higher tsunami_rate if the score is good.
WITH scored AS (
  SELECT
    tsunami,
    tsunami_risk_score,
    NTILE(10) OVER (ORDER BY tsunami_risk_score) AS risk_decile   
  FROM `tsunami-risk-assessment.tsunami.v_earthquake_processed`
),
overall AS (
  SELECT AVG(tsunami) AS base_rate 
  FROM scored
)
SELECT
  risk_decile,
  COUNT(*) AS n_events,
  ROUND(AVG(tsunami), 4) AS tsunami_rate,
  ROUND(AVG(tsunami) / (SELECT base_rate FROM overall), 2) AS lift_vs_overall,
  ROUND(AVG(tsunami_risk_score), 3) AS avg_risk_score
FROM scored
GROUP BY risk_decile
ORDER BY risk_decile DESC;
