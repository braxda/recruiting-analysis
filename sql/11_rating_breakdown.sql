-- Ran this query to see if there were any apparent differences in physical
-- characteristics of players based on their star rating and year in school.

SELECT
    stars,
    COUNT(*) as total_players,
    ROUND(AVG(weight), 1) as avg_weight,
    ROUND(AVG(height), 1) as avg_height,
    ROUND(AVG(CASE WHEN year = 4 THEN weight END), 1) as senior_avg_weight,
    ROUND(AVG(CASE WHEN year = 1 THEN weight END), 1) as freshman_avg_weight
FROM players
GROUP BY stars
ORDER BY stars DESC;
