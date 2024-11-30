-- Look at the basic positional breakdown for each team

SELECT team, COUNT(*) as total_players,
COUNT(CASE WHEN position IN ('G', 'OL', 'QB', 'RB', 'TE', 'WR')THEN 1 END) as offensive_players,
COUNT(CASE WHEN position IN ('CB', 'DB', 'DE', 'DL', 'DT', 'EDGE', 'LB', 'S' )THEN 1 END) as defensive_players,
COUNT(CASE WHEN position IN ('LS', 'P', 'PK')THEN 1 END) as special_teams_players
FROM players
GROUP BY team
ORDER BY team;