-- See how blue chip (4 and 5 star) talent is distributed

WITH star_rankings AS (
  SELECT
    team,
    CASE
      WHEN stars >= 4 THEN 'Blue Chip'
      ELSE 'Other'
    END as recruit_tier,
    COUNT(*) as player_count
  FROM players
  WHERE stars IS NOT NULL
  GROUP BY
    team,
    CASE
      WHEN stars >= 4 THEN 'Blue Chip'
      ELSE 'Other'
    END
)
SELECT
  team,
  recruit_tier,
  player_count,
  ROUND(100.0 * player_count / SUM(player_count) OVER (PARTITION BY team), 1) as percentage
FROM star_rankings
ORDER BY team, recruit_tier;