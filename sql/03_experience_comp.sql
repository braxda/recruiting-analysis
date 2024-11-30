--See how player experience is distributed amongst teams and which teams have the most experience

SELECT team, COUNT(*) as total_players,
COUNT(CASE WHEN year = 1 THEN 1 END) as freshmen,
COUNT(CASE WHEN year = 2 THEN 1 END) as sophomores,
COUNT(CASE WHEN year = 3 THEN 1 END) as juniors,
COUNT(CASE WHEN year = 4 THEN 1 END) as seniors,
ROUND(AVG(year), 2) as avg_experience
FROM players
GROUP BY team
ORDER BY avg_experience DESC;