create table
  teams (team_id SERIAL PRIMARY KEY NOT NULL, name VARCHAR(255) UNIQUE NOT NULL);

create table
  games (
    game_id SERIAL PRIMARY KEY NOT NULL,
    year INT NOT NULL,
    round VARCHAR(255) NOT NULL,
    winner_id INT REFERENCES teams (team_id) NOT NULL,
    opponent_id INT REFERENCES teams (team_id) NOT NULL, 
    winner_goals INT NOT NULL,
    opponent_goals INT NOT NULL
  );