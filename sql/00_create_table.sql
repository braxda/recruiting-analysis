CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    team VARCHAR(50) NOT NULL,
    height NUMERIC(4,1),
    weight NUMERIC(4,1),
    year NUMERIC(1),
    position VARCHAR(10),
    hometown VARCHAR(100),
    state VARCHAR(20),
    country VARCHAR(50),
    latitude NUMERIC(10,6),
    longitude NUMERIC(10,6),
    formatted_height VARCHAR(10),
);

COMMENT ON COLUMN players.year IS 'Year in college (1-4)';

CREATE INDEX idx_players_team ON players(team);
CREATE INDEX idx_players_position ON players(position);
CREATE INDEX idx_players_state ON players(state);