SELECT 
  code,
  year::text AS year,
  SUM(
    CASE 
      WHEN {{ MetricDropdown.value }} = 'Amount' THEN amount
      WHEN {{ MetricDropdown.value }} = 'Frequency' THEN number
      ELSE amount
    END
  ) AS metric_value
FROM (
  SELECT 
    code,
    year,
    -- Clean and categorize bitewing types
    CASE 
      WHEN LOWER(service) LIKE '%bitewing 1%' OR LOWER(service) LIKE '%bitewings 1%' THEN 'One Film'
      WHEN LOWER(service) LIKE '%bitewing 2%' OR LOWER(service) LIKE '%bitewings 2%' THEN 'Two Films'
      WHEN LOWER(service) LIKE '%bitewing 3%' OR LOWER(service) LIKE '%bitewings 3%' THEN 'Three Films'
      WHEN LOWER(service) LIKE '%bitewing 4%' OR LOWER(service) LIKE '%bitewings 4%' THEN 'Four Films'
      WHEN LOWER(service) LIKE '%bitewing%' AND LOWER(service) NOT LIKE '%bitewing [1-4]%' AND LOWER(service) NOT LIKE '%bitewings [1-4]%' THEN 'Bitewings (General)'
      ELSE 'Other'
    END AS bitewing_type,
    amount,
    number
  FROM procedures_2022_2025_all
  WHERE 
    LOWER(service) LIKE '%bitewing%'
    AND (
      {{ BitewingFilmDropdown3.value }} = 'Total' OR
      CASE 
        WHEN LOWER(service) LIKE '%bitewing 1%' OR LOWER(service) LIKE '%bitewings 1%' THEN 'One Film'
        WHEN LOWER(service) LIKE '%bitewing 2%' OR LOWER(service) LIKE '%bitewings 2%' THEN 'Two Films'
        WHEN LOWER(service) LIKE '%bitewing 3%' OR LOWER(service) LIKE '%bitewings 3%' THEN 'Three Films'
        WHEN LOWER(service) LIKE '%bitewing 4%' OR LOWER(service) LIKE '%bitewings 4%' THEN 'Four Films'
        WHEN LOWER(service) LIKE '%bitewing%' AND LOWER(service) NOT LIKE '%bitewing [1-4]%' AND LOWER(service) NOT LIKE '%bitewings [1-4]%' THEN 'Bitewings (General)'
        ELSE 'Other'
      END = {{ BitewingFilmDropdown3.value }}
    )
) AS subquery
GROUP BY code, year
ORDER BY code, year;