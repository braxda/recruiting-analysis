-- Shows statistical outliers in player weights compared to their position

WITH position_stats AS (
    SELECT
        position,
        CAST(AVG(CAST(weight AS FLOAT)) AS NUMERIC(10,1)) as avg_weight,
        STDDEV(CAST(weight AS FLOAT)) as stddev_weight
    FROM players
    GROUP BY position
)
SELECT
    r.team,
    r.name,
    r.position,
    r.height,
    r.weight,
    ps.avg_weight as position_avg_weight,
    r.stars,
    CAST((r.weight - ps.avg_weight) / ps.stddev_weight AS NUMERIC(10,2)) as weight_zscore
FROM players r
JOIN position_stats ps ON r.position = ps.position
WHERE ABS((r.weight - ps.avg_weight) / ps.stddev_weight) > 2
ORDER BY ABS((r.weight - ps.avg_weight) / ps.stddev_weight) DESC;