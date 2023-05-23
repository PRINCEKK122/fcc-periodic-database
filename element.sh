#!/bin/bash
PSQL="psql --username=postgres --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  # query the database with argument provided
  BASE_QUERY="SELECT atomic_number, name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, types.type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id)"
  
  if [[ $1 =~ ^[0-9]+$ ]] # check if the argument starts with a number
  then 
    ELEMENT_RESULT=$($PSQL "$BASE_QUERY WHERE atomic_number = $1")
  else
    ELEMENT_RESULT=$($PSQL "$BASE_QUERY WHERE symbol = '$1' OR name = '$1'")
  fi
  
  # if found
  if [[ $ELEMENT_RESULT ]]
  then
    echo $ELEMENT_RESULT | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
    
  else
    # if not found
    echo "I could not find that element in the database."
  fi
fi
