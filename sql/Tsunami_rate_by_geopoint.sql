--Tsunami rate by geopoint
SELECT
  ST_GEOGPOINT(longitude, latitude)          AS geopoint,
  COUNT(*)                                   AS total_quakes,
  SUM(tsunami)                               AS tsunami_events,
  ROUND(SUM(tsunami)/COUNT(*), 3)            AS tsunami_rate,
  ROUND(AVG(magnitude),2)                    AS avg_mag,
  ROUND(AVG(depth),2)                        AS avg_depth
FROM `tsunami-risk-assessment.tsunami.v_earthquake_processed`
GROUP BY latitude, longitude
ORDER BY tsunami_events DESC
