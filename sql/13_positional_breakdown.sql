-- This query will breakdown each team's position group by
-- experience level to see where teams are strong and where
-- teams may need to supplement

SELECT
    team,
    year,
    position,
    COUNT(*) as players,
    CAST(AVG(CAST(stars as float)) AS NUMERIC(10,2)) as avg_stars,
    COUNT(CASE WHEN stars >= 4 THEN 1 END) as blue_chips
FROM players
WHERE position NOT IN ('LS', 'P', 'PK')
GROUP BY team, year, position
HAVING COUNT(*) >= 2
ORDER BY team, position, year;