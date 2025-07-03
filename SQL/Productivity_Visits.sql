SELECT
  provider_name,
  SUM(patients_seen) AS total_patients_seen,
  ROUND(AVG(avg_visit_fee::numeric), 2) AS avg_visit_fee,
  SUM(production) AS total_production
FROM productivity_2022_2025_all
GROUP BY provider_name
ORDER BY provider_name;