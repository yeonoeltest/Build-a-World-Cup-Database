#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo  "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo  "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo  "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo  "$($PSQL "SELECT AVG(total_goals) AS average_goals
                FROM (
                    SELECT (winner_goals + opponent_goals) AS total_goals
                    FROM games
                ) AS total_goals_table;")
              "

echo -e "\nMost goals scored in a single game by one team:"
echo  "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo  "$($PSQL "SELECT COUNT(*) FROM games where winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo  "$($PSQL "SELECT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE games.year=2018 AND games.winner_goals  >  games.opponent_goals AND games.round ILIKE 'fin
al'")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo  "$($PSQL "SELECT  name FROM teams INNER JOIN games ON teams.team_id = games.winner_id  OR teams.team_id = games.opponent_id WHERE games.year=2014 AND games.round LIKE 'Eighth-Final';")"

echo -e "\nList of unique winning team names in the whole data set:"
echo  "$($PSQL "SELECT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id GROUP BY teams.name ORDER BY teams.name ASC")"

echo -e "\nYear and team name of all the champions:"
echo  "$($PSQL "SELECT games.year, teams.name  FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE games.round ILIKE 'final' ORDER BY name;")"

echo -e "\nList of teams that start with 'Co':"
echo  "$($PSQL "SELECT * FROM teams WHERE name LIKE 'Co%' ORDER BY name")"

