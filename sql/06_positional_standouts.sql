--This query will show you the highest rated player for each position for each team.
--Nice for seeing at which position each team had star players
SELECT p.name, p.position, p.team, p.stars
FROM players p
INNER JOIN (
  SELECT position, team, MAX(stars) AS max_stars
  FROM players
  GROUP BY position, team
) t ON p.position = t.position AND p.team = t.team AND p.stars = t.max_stars
ORDER BY p.stars DESC, p.team;