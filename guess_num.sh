#! /bin/bash

function is_correct_guess() {
  local RANDOM_NUM=$1
  local USERS_NUM=$2
  return $([ $RANDOM_NUM -eq $USERS_NUM ])
}

function is_in_range(){
  local USERS_NUM=$1
  return $([ $USERS_NUM -ge 0 -a $USERS_NUM -le 100 ])
}

RANDOM_NUMBER=$(jot -r 1 0 100) 
MESSAGE="Guess a Number between 0 and 100: "
for CHANCES in 1 2 3 4 5
do

  read -p "$MESSAGE" USERS_NUM
  is_in_range $USERS_NUM
  if [ $? -ne 0 ];then
    echo "Your number was not in the given range....so you're eliminated"
    exit
  fi

  is_correct_guess $RANDOM_NUMBER $USERS_NUM
  if [ $? -eq 0 ];then
    echo "Cool.. You guessed it correctly"
    exit
  fi

  if [ $USERS_NUM -gt $RANDOM_NUMBER ];then
    MESSAGE="Your Number is greater than the number: "
  else
    MESSAGE="Your Number is lesser than the number: "
  fi

done

echo "you are dumb....The number was $RANDOM_NUMBER"
