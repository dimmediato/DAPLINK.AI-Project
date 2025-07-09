SELECT 'All' as provider_name
UNION ALL
SELECT DISTINCT provider_name 
FROM productivity_2022_2025_all 
WHERE provider_name IS NOT NULL
ORDER BY provider_name;