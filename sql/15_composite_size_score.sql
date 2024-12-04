-- This query will calculate the composite size score of each player
-- using the height and weight z score to show under and oversized outliers

WITH position_stats AS (
    SELECT
        position,
        AVG(CAST(weight AS FLOAT)) as avg_weight,
        STDDEV(CAST(weight AS FLOAT)) as stddev_weight,
        AVG(CAST(height AS FLOAT)) as avg_height,
        STDDEV(CAST(height AS FLOAT)) as stddev_height
    FROM players
    WHERE weight > 0 AND height > 0
    GROUP BY position
),
player_scores AS (
    SELECT
        p.team,
        p.name,
        p.position,
        p.height,
        p.weight,
        p.stars,
        CAST((p.weight - ps.avg_weight) / ps.stddev_weight AS NUMERIC(10,2)) as weight_zscore,
        CAST((p.height - ps.avg_height) / ps.stddev_height AS NUMERIC(10,2)) as height_zscore,
        CAST(SQRT(
            POWER((p.weight - ps.avg_weight) / ps.stddev_weight, 2) +
            POWER((p.height - ps.avg_height) / ps.stddev_height, 2)
        ) AS NUMERIC(10,2)) as composite_size_score
    FROM players p
    JOIN position_stats ps ON p.position = ps.position
)
SELECT
    *,
    CASE
        WHEN weight_zscore < -1 AND height_zscore < -1 THEN 'Significantly Undersized'
        WHEN weight_zscore < 0 AND height_zscore < 0 THEN 'Slightly Undersized'
        WHEN weight_zscore > 1 AND height_zscore > 1 THEN 'Significantly Oversized'
        WHEN weight_zscore > 0 AND height_zscore > 0 THEN 'Slightly Oversized'
        ELSE 'Mixed Size'
    END as size_category
FROM player_scores
WHERE ABS(composite_size_score) > 1
ORDER BY composite_size_score DESC;