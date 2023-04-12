#! /bin/bash

function pick_random_city() {
  local CITY=$(cat ./cities.txt | sort -R | head -n1)
  echo "$CITY" 
}

function count_characters(){
  local CITY=$1
  echo "$CITY" | wc -c | tr -d "[:space:]" 
}

function make_upper_case(){
  local STRING=$1
  echo "$STRING" | tr "[:lower:]" "[:upper:]"
}

function decrease(){
  local NUM=$1
  dc -e "$NUM 1 - p"
}

function display_clue(){
  local CITY=$1
  echo -e "\n\t$CITY" | sed "s/\(.\)/\1 /g"
}

function unmask() {
  local CITY=$1
  local CHARACTERS=$2
  local CLUE=""
  echo -n "$CITY" | tr -C "$CHARACTERS" "_" 
}

function display_instructions(){
  local CITY=$1
  echo "You have to guess a city name"
  echo "You can guess only one character at a time"
  echo "$CITY" | sed "s/./_ /g"
}

function start_game(){
  local CITY=$1
  local ATTEMPTS=$2
  local EXIT_STATUS=1
  local GUESS=" "

  while [ $ATTEMPTS -gt 0 ]
  do

    echo -e "\nYou got $ATTEMPTS chances to guess the city"
    read -p "Enter a character: " CHARACTER

    GUESS=$(make_upper_case "$GUESS $CHARACTER")
    CLUE=$(unmask "$CITY" "$GUESS")
    ATTEMPTS=$(decrease $ATTEMPTS)
    display_clue "$CLUE"

    if [ "$CITY" = "$CLUE" ];then
      EXIT_STATUS=0
      break
    fi
  done

  return $EXIT_STATUS
}

function dislay_result(){
  local GAME_RESULT=$1
  local HAS_WON=0

  if [ $GAME_RESULT -eq $HAS_WON ];then
    echo -e "you guessed it correctly\n"
  else
    echo -e "you lost\nThe word was $CITY"
  fi
}

function main(){
  local CAN_CHEAT=$1
  local GAME_RESULT=1
  local CITY=$(pick_random_city)
  local NUM_OF_CHARS=$(count_characters "$CITY")
  if [ CAN_CHEAT ]; then
    echo $CITY
  fi
  display_instructions "$CITY" 
  start_game "$CITY" "$NUM_OF_CHARS"
  GAME_RESULT=$?
  dislay_result $GAME_RESULT
}

main $1
