-- Q4: Network quality vs tsunami rate (bucketed)
WITH buckets AS (
  SELECT
    -- Bucket by number of stations (nst)
    CASE
      WHEN nst IS NULL OR nst = 0 THEN 'nst=0'
      WHEN nst <= 50 THEN 'nst<=50'
      WHEN nst <= 150 THEN '51-150'
      ELSE '151+'
    END AS nst_bucket,
    -- Bucket by distance to nearest station (dmin, in degrees)
    CASE
      WHEN dmin < 1 THEN '<1°'
      WHEN dmin < 3 THEN '1-3°'
      WHEN dmin < 6 THEN '3-6°'
      ELSE '6°+'
    END AS dmin_bucket,
    tsunami
  FROM `tsunami-risk-assessment.tsunami.v_earthquake_processed`
)
SELECT
  nst_bucket,
  dmin_bucket,
  COUNT(*) AS n_events,
  SUM(tsunami) AS tsunami_events,
  ROUND(AVG(tsunami), 3) AS tsunami_rate        
FROM buckets
GROUP BY nst_bucket, dmin_bucket
ORDER BY nst_bucket, dmin_bucket;
