-- This query looks at each teams' average and max distances
-- players traveled from their hometowns.

WITH school_locations AS (
    SELECT 'Texas' as team, 30.2849 as lat, -97.7341 as lon
    UNION SELECT 'Michigan', 42.2808, -83.7430
    UNION SELECT 'Alabama', 33.2098, -87.5692
    UNION SELECT 'Washington', 47.6553, -122.3035
)
SELECT
    p.team,
    COUNT(*) as total_players,
    CAST(AVG(
        3959 * 2 * asin(
            sqrt(
                pow(sin(radians(s.lat - p.latitude) / 2), 2) +
                cos(radians(p.latitude)) * cos(radians(s.lat)) *
                pow(sin(radians(s.lon - p.longitude) / 2), 2)
            )
        )
    ) AS NUMERIC(10,1)) as avg_distance,
    CAST(MAX(
        3959 * 2 * asin(
            sqrt(
                pow(sin(radians(s.lat - p.latitude) / 2), 2) +
                cos(radians(p.latitude)) * cos(radians(s.lat)) *
                pow(sin(radians(s.lon - p.longitude) / 2), 2)
            )
        )
    ) AS NUMERIC(10,1)) as max_distance
FROM players p
JOIN school_locations s ON p.team = s.team
GROUP BY p.team
ORDER BY avg_distance DESC;