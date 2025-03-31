PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


if [ $# -gt 0 ]
then
  ELEMENT=$($PSQL "select atomic_number,name,symbol,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id from properties inner join elements using(atomic_number) where name='$1' or symbol='$1' or atomic_number::TEXT='$1'")
  if [[ -z $ELEMENT ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$ELEMENT" | sed 's/|/ /g' | while read ATOMIC NAME SYMBOL MASS MELT BOIL TYPE_ID
    do
     TYPE=$($PSQL "select type from types where type_id=$TYPE_ID")
     echo "The element with atomic number $ATOMIC is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  fi
else
  echo "Please provide an element as an argument."
fi

