#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat insert_data.sh | while IFS=',' read YEAR,ROUND,WINNER,OPPONENT,WINNER_GOALS,OPPONENT_GOALS
do
  if [[ $YEAR != 'YEAR']]
  then
    TEAMS_ID1 = $($PSQL "SELECT team_id WHERE nom = $WINNER") 
    if [[ -z $TEAM_ID1  ]]
    then
      INSERT_TEAM_RESULT = $($PSQL "INSERT INTO teams(nom) VALUES($WINNER)")
      if [[ INSERT_TEAM_RESULT = 'INSERT 1 0' ]]
      then
          echo "Inserted into teams, $TEAMS_ID1"
      fi
    fi

    TEAMS_ID2 = $($PSQL "SELECT team_id WHERE nom = $OPPONENT") 
    if [[ -z $TEAM_ID2  ]]
    then
      INSERT_TEAM_RESULT = $($PSQL "INSERT INTO teams(nom) VALUES($OPPONENT)")
      if [[ INSERT_TEAM_RESULT = 'INSERT 1 0' ]]
      then
          echo "Inserted into teams, $TEAMS_ID2"
      fi
    fi
  fi

done 




cat insert_data.sh | while IFS=',' read YEAR,ROUND,WINNER,OPPONENT,WINNER_GOALS,OPPONENT_GOALS
do
  if [[ $YEAR != 'YEAR']]
  then
    GOALD_ID = $($PSQL "SELECT game_id WHERE round = $ROUND AND year = $YEAR") 
    if [[ -z $GOALD_ID  ]]
    then
      INSERT_TEAM_RESULT = $($PSQL "INSERT INTO teams(round, year, winner_goald, opponent_goald) VALUES('$ROUND', $YEAR, $WINNER_GOALS, $OPPONENT_GOALS)")
      if [[ INSERT_TEAM_RESULT = 'INSERT 1 0' ]]
      then
          echo "Inserted into games, $GOALD_ID"
      fi
    fi

  fi
done 


