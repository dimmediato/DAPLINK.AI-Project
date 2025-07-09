SELECT
  provider_name,
  year::text AS year,
  SUM(collection) AS metric_value
FROM productivity_2022_2025_all
WHERE 
  CASE 
    WHEN {{ providerDropdown.value }} = 'All' THEN TRUE
    ELSE provider_name = {{ providerDropdown.value }}
  END
GROUP BY provider_name, year
ORDER BY provider_name, year;