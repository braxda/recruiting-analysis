COPY players(id, name, team, height, weight, year, position, hometown, state, country, latitude, longitude, formatted_height)
FROM '/your/pathfile/here/roster_for_sql.csv'
DELIMITER ','
CSV HEADER;