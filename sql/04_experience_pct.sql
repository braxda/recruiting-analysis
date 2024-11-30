-- Adjust previous query to show percentage of each each year for each team
SELECT team, COUNT(*) as total_players,
ROUND(COUNT(CASE WHEN year = 1 THEN 1 END) * 100 / COUNT(*), 1) as freshman_pct,
ROUND(COUNT(CASE WHEN year = 2 THEN 1 END) * 100 / COUNT(*), 1) as sophomore_pct,
ROUND(COUNT(CASE WHEN year = 3 THEN 1 END) * 100 / COUNT(*), 1) as junior_pct,
ROUND(COUNT(CASE WHEN year = 4 THEN 1 END) * 100 / COUNT(*), 1) as senior_pct,
ROUND(AVG(year), 2) as avg_experience
FROM players
GROUP BY team
ORDER BY avg_experience DESC;
