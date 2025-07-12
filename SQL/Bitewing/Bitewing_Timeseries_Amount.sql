SELECT 
  CASE 
    WHEN code IN ('0270N', '00270') THEN '00270'
    ELSE code
  END AS code,
  year::text AS year,
  bitewing_type AS films_taken,
  SUM(amount) AS metric_value
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
    amount
  FROM procedures_2022_2025_all
  WHERE 
    LOWER(service) LIKE '%bitewing%'
    AND
    -- Dynamic film filtering with new dropdown
    CASE 
      WHEN {{ BitewingFilmDropdown3.value }} = 'Total' THEN TRUE
      ELSE 
        CASE 
          WHEN LOWER(service) LIKE '%bitewing 1%' OR LOWER(service) LIKE '%bitewings 1%' THEN 'One Film'
          WHEN LOWER(service) LIKE '%bitewing 2%' OR LOWER(service) LIKE '%bitewings 2%' THEN 'Two Films'
          WHEN LOWER(service) LIKE '%bitewing 3%' OR LOWER(service) LIKE '%bitewings 3%' THEN 'Three Films'
          WHEN LOWER(service) LIKE '%bitewing 4%' OR LOWER(service) LIKE '%bitewings 4%' THEN 'Four Films'
          WHEN LOWER(service) LIKE '%bitewing%' AND LOWER(service) NOT LIKE '%bitewing [1-4]%' AND LOWER(service) NOT LIKE '%bitewings [1-4]%' THEN 'Bitewings (General)'
          ELSE 'Other'
        END = {{ BitewingFilmDropdown3.value }}
    END
) AS subquery
GROUP BY 
  CASE 
    WHEN code IN ('0270N', '00270') THEN '00270'
    ELSE code
  END,
  year, 
  bitewing_type
ORDER BY 
  CASE 
    WHEN code IN ('0270N', '00270') THEN '00270'
    ELSE code
  END,
  year, 
  bitewing_type;