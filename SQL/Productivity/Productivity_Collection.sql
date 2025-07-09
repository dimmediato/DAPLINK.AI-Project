SELECT
  provider_name,
  SUM(collection) AS total_collection,
  SUM(adjustments) AS total_adjustments
FROM productivity_2022_2025_all
WHERE 
  CASE 
    WHEN {{ yearDropdown2.value }} = 'Total' THEN TRUE
    ELSE year = {{ yearDropdown2.value }}
  END
GROUP BY provider_name
ORDER BY provider_name;