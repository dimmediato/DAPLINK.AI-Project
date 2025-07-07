SELECT year 
FROM productivity_2022_2025_all 
WHERE year IS NOT NULL 
GROUP BY year
ORDER BY year;