--Show where each team recruits players from

WITH player_locations AS (
  SELECT
    team,
    state,
    COUNT(*) as player_count,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY team) as percentage
  FROM players
  GROUP BY team, state
)
SELECT
  team,
  state,
  player_count,
  ROUND(percentage, 2) as pct_of_roster
FROM player_locations
ORDER BY team, player_count DESC;

--The above query is returning some players whose state is NULL
--Add cases to integrate international players

WITH player_locations AS (
  SELECT
    team,
    CASE
        WHEN country = 'USA' THEN state
        ELSE country
    END as location,
    COUNT(*) as player_count,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY team) as percentage
  FROM players
  GROUP BY team, location
)
SELECT
  team,
  location,
  player_count,
  ROUND(percentage, 2) as pct_of_roster
FROM player_locations
ORDER BY team, player_count DESC;

--Notice that we still had one player with NULL as their location
--Added missing data below

UPDATE players
SET hometown = 'Vestavia Hills',
state = 'AL',
country = 'USA',
latitude = 33.448799,
longitude = -86.787949
WHERE name = 'Sam Willoughby';