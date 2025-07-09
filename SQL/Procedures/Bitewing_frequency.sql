SELECT 
  provider,
  bitewing_type,
  frequency,
  total_amount
FROM (
  SELECT 
    provider,
    -- Clean and categorize bitewing types
    CASE 
      WHEN LOWER(service) LIKE '%bitewing 1%' OR LOWER(service) LIKE '%bitewings 1%' THEN 'One Film'
      WHEN LOWER(service) LIKE '%bitewing 2%' OR LOWER(service) LIKE '%bitewings 2%' THEN 'Two Films'
      WHEN LOWER(service) LIKE '%bitewing 3%' OR LOWER(service) LIKE '%bitewings 3%' THEN 'Three Films'
      WHEN LOWER(service) LIKE '%bitewing 4%' OR LOWER(service) LIKE '%bitewings 4%' THEN 'Four Films'
      WHEN LOWER(service) LIKE '%bitewing%' AND LOWER(service) NOT LIKE '%bitewing [1-4]%' AND LOWER(service) NOT LIKE '%bitewings [1-4]%' THEN 'Bitewings (General)'
      ELSE 'Other'
    END AS bitewing_type,
    SUM(number) as frequency,
    SUM(amount) as total_amount
  FROM procedures_2022_2025_all
  WHERE 
    LOWER(service) LIKE '%bitewing%'
    AND
    -- Dynamic year filtering
    CASE 
      WHEN {{ procedureDropdown3.value }} = 'Total' THEN TRUE
      ELSE year::text = {{ procedureDropdown3.value }}
    END
    AND
    -- Dynamic bitewing film filtering
    CASE 
      WHEN {{ filmDropdown.value }} = 'Total' THEN TRUE
      ELSE 
        CASE 
          WHEN LOWER(service) LIKE '%bitewing 1%' OR LOWER(service) LIKE '%bitewings 1%' THEN 'One Film'
          WHEN LOWER(service) LIKE '%bitewing 2%' OR LOWER(service) LIKE '%bitewings 2%' THEN 'Two Films'
          WHEN LOWER(service) LIKE '%bitewing 3%' OR LOWER(service) LIKE '%bitewings 3%' THEN 'Three Films'
          WHEN LOWER(service) LIKE '%bitewing 4%' OR LOWER(service) LIKE '%bitewings 4%' THEN 'Four Films'
          WHEN LOWER(service) LIKE '%bitewing%' AND LOWER(service) NOT LIKE '%bitewing [1-4]%' AND LOWER(service) NOT LIKE '%bitewings [1-4]%' THEN 'Bitewings (General)'
          ELSE 'Other'
        END = {{ filmDropdown.value }}
    END
  GROUP BY 
    provider, 
    bitewing_type
) AS subquery
ORDER BY 
      --Ordering for films to prevent sporadic placement
  provider, 
  CASE bitewing_type
    WHEN 'One Film' THEN 1
    WHEN 'Two Films' THEN 2
    WHEN 'Three Films' THEN 3
    WHEN 'Four Films' THEN 4
    WHEN 'Bitewings (General)' THEN 5
    WHEN 'Other' THEN 6
    ELSE 7
  END