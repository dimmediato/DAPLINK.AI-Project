SELECT
  year,
  provider_name,
  SUM(production) AS total_production
FROM productivity_2022_2025_all
GROUP BY year, provider_name
ORDER BY year, provider_name;