#CREATE DATABASE roselle_db;
#USE roselle_db;
#CREATE TABLE roselle_provider_productivity (
  #year INT,
 # provider_name VARCHAR(255),
  #service_role VARCHAR(100),
  #patients_seen INT,
  #avg_visit_fee DECIMAL(10,2),
  #production DECIMAL(12,2),
  #collection DECIMAL(12,2),
  #adjustments DECIMAL(12,2)
#);
SELECT
  provider_name,
  service_role,
  year,
  SUM(patients_seen) AS total_patients_seen,
  ROUND(AVG(avg_visit_fee), 2) AS avg_visit_fee,
  FORMAT(SUM(production), 0) AS total_production
FROM roselle_provider_productivity
GROUP BY provider_name, service_role, year
ORDER BY provider_name, service_role, year;