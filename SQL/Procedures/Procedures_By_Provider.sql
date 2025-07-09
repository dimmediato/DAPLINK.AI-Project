SELECT
  provider,
  SUM(number) AS total_number,
  SUM(amount) AS total_amount
FROM procedures_2022_2025_all
  WHERE 
  CASE 
    WHEN {{ procedureDropdown1.value }} = 'Total' THEN TRUE
    ELSE year = {{ procedureDropdown1.value }}
  END
GROUP BY provider
ORDER BY provider;