#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
GAMES_CSV="games.csv"
$PSQL "CREATE TABLE temp (
year int,round VARCHAR(255),winner VARCHAR(255),opponent VARCHAR(255),winner_goals int,opponent_goals int
);"
$PSQL "\COPY temp FROM '$GAMES_CSV' DELIMITER ',' CSV HEADER;"
$PSQL "insert into teams (name) select distinct winner as name from temp union select DISTINCT opponent as name from temp;"
$PSQL "INSERT INTO games (year, round, winner_goals, opponent_goals, winner_id, opponent_id)
SELECT t1.year, t1.round, t1.winner_goals, t1.opponent_goals, winner_team.team_id AS winner_id, opponent_team.team_id AS opponent_id
FROM 
  temp t1
INNER JOIN
  teams winner_team ON t1.winner = winner_team.name
INNER JOIN
  teams opponent_team ON t1.opponent = opponent_team.name;"
$PSQL "DROP TABLE temp;"