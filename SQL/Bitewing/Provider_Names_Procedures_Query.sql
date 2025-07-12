SELECT 'All' as provider
UNION ALL
SELECT DISTINCT provider
FROM procedures_2022_2025_all 
WHERE provider IS NOT NULL
ORDER BY provider;