-- Show physical attributes and star ranking by position group for each team
-- Order by star rating to see how teams prioritized positions

SELECT
  team,
  CASE
    WHEN position IN ('OL', 'G', 'T') THEN 'Offensive Line'
    WHEN position IN ('DL', 'DE', 'DT', 'EDGE') THEN 'Defensive Line'
    WHEN position IN ('DB', 'CB', 'S') THEN 'Defensive Backs'
    WHEN position IN ('PK', 'P', 'LS') THEN 'Special Teams'
    ELSE position
  END as position_group,
  COUNT(*) as players,
  ROUND(AVG(weight), 1) as avg_weight,
  ROUND(AVG(height), 1) as avg_height,
  ROUND(AVG(stars), 1) as avg_stars
FROM players
GROUP BY team,
  CASE
    WHEN position IN ('OL', 'G', 'T') THEN 'Offensive Line'
    WHEN position IN ('DL', 'DE', 'DT', 'EDGE') THEN 'Defensive Line'
    WHEN position IN ('DB', 'CB', 'S') THEN 'Defensive Backs'
    WHEN position IN ('PK', 'P', 'LS') THEN 'Special Teams'
    ELSE position
  END
ORDER BY team, avg_stars DESC;