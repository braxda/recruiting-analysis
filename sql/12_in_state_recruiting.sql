-- This shows how well teams recruited players in and out-of-state
WITH home_state_players AS (
    SELECT
        team,
        CASE
            WHEN (team = 'Alabama' AND state = 'AL') OR
                 (team = 'Texas' AND state = 'TX') OR
                 (team = 'Michigan' AND state = 'MI') OR
                 (team = 'Washington' AND state = 'WA')
            THEN 'In-State'
            ELSE 'Out-of-State'
        END as recruitment_type,
        COUNT(*) as player_count,
        CAST(AVG(CAST(stars as float)) AS NUMERIC(10,2)) as avg_stars
    FROM players
    WHERE state IS NOT NULL
    GROUP BY team,
        CASE
            WHEN (team = 'Alabama' AND state = 'AL') OR
                 (team = 'Texas' AND state = 'TX') OR
                 (team = 'Michigan' AND state = 'MI') OR
                 (team = 'Washington' AND state = 'WA')
            THEN 'In-State'
            ELSE 'Out-of-State'
        END
)
SELECT
    team,
    recruitment_type,
    player_count,
    avg_stars,
    ROUND(100.0 * player_count / SUM(player_count) OVER (PARTITION BY team), 1) as percentage
FROM home_state_players
ORDER BY team, recruitment_type;

--Adjusted query to show how well each team recruited blue chip players
-- in and out-of-state
WITH home_state_players AS (
    SELECT
        team,
        CASE
            WHEN (team = 'Alabama' AND state = 'AL') OR
                 (team = 'Texas' AND state = 'TX') OR
                 (team = 'Michigan' AND state = 'MI') OR
                 (team = 'Washington' AND state = 'WA')
            THEN 'In-State'
            ELSE 'Out-of-State'
        END as recruitment_type,
        COUNT(*) as total_players,
        COUNT(CASE WHEN stars >= 4 THEN 1 END) as blue_chip_players,
        CAST(AVG(CAST(stars as float)) AS NUMERIC(10,2)) as avg_stars
    FROM players
    WHERE state IS NOT NULL
        AND stars IS NOT NULL
    GROUP BY team,
        CASE
            WHEN (team = 'Alabama' AND state = 'AL') OR
                 (team = 'Texas' AND state = 'TX') OR
                 (team = 'Michigan' AND state = 'MI') OR
                 (team = 'Washington' AND state = 'WA')
            THEN 'In-State'
            ELSE 'Out-of-State'
        END
)
SELECT
    team,
    recruitment_type,
    total_players,
    blue_chip_players,
    CAST(100.0 * blue_chip_players / total_players AS NUMERIC(10,1)) as blue_chip_percentage,
    avg_stars
FROM home_state_players
ORDER BY team, recruitment_type;