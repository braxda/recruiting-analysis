--Accidentally imported the incorrect csv. Will add a temp table to import the missing column and join the data

CREATE TABLE player_data (
  id INTEGER,
  name VARCHAR(100),
  stars NUMERIC,
  school VARCHAR(100),
  height INTEGER,
  weight INTEGER,
  year INTEGER,
  position VARCHAR(50),
  hometown VARCHAR(100),
  state VARCHAR(50),
  country VARCHAR(50)
);

-- import stars data into temp table
COPY player_data
FROM '/your/pathfile/here/roster_data - hardcoded_stars.csv'
DELIMITER ','
CSV HEADER;

-- Add stars column to original table
ALTER TABLE players
ADD COLUMN stars NUMERIC;

-- Join star table with original table on id
UPDATE players
SET stars = pd.stars
FROM player_data pd
WHERE players.id = pd.id;

--Delete temp table
DROP TABLE player_data;