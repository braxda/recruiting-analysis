-- Add onto prior query to see how blue chip talent is distributed
-- between upper and underclassmen amongst playoff teams.

WITH experience_levels AS (
    SELECT
        team,
        CASE
            WHEN year >= 3 THEN 'Upperclassman'
            ELSE 'Underclassman'
        END as experience_level,
        CASE
            WHEN stars >= 4 THEN 'Blue Chip'
            ELSE 'Other'
        END as talent_level,
        COUNT(*) as player_count
    FROM players
    GROUP BY team,
        CASE
            WHEN year >= 3 THEN 'Upperclassman'
            ELSE 'Underclassman'
        END,
        CASE
            WHEN stars >= 4 THEN 'Blue Chip'
            ELSE 'Other'
        END
)
SELECT
    team,
    experience_level,
    talent_level,
    player_count,
    ROUND(100.0 * player_count / SUM(player_count) OVER (PARTITION BY team), 1) as percentage
FROM experience_levels
ORDER BY team, percentage DESC;