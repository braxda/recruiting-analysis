-- This query will look at the blue chip players who traveled
-- the furthest distances to play for their school

WITH school_locations AS (
    SELECT 'Texas' as team, 30.2849 as lat, -97.7341 as lon
    UNION SELECT 'Michigan', 42.2808, -83.7430
    UNION SELECT 'Alabama', 33.2098, -87.5692
    UNION SELECT 'Washington', 47.6553, -122.3035
)
SELECT
    p.team,
    p.name,
    p.hometown,
    p.state,
	p.country,
    p.stars,
    CAST(
        3959 * 2 * asin(
            sqrt(
                pow(sin(radians(s.lat - p.latitude) / 2), 2) +
                cos(radians(p.latitude)) * cos(radians(s.lat)) *
                pow(sin(radians(s.lon - p.longitude) / 2), 2)
            )
        ) AS NUMERIC(10,1)
    ) as distance_miles
FROM players p
JOIN school_locations s ON p.team = s.team
    AND p.stars >= 4
ORDER BY distance_miles DESC
LIMIT 10;