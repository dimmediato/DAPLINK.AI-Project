SELECT
  provider_name,
  SUM(collection) AS total_collection,
  SUM(adjustments) AS total_adjustments
FROM productivity_2022_2025_all
GROUP BY provider_name
ORDER BY provider_name;