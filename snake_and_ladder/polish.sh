#! /bin/bash

function roll_dice() {
  jot -w 0 -r 1 1 6
}

function ladder() {
  local CUR_POS=$1
  local LADDERS="12:17 18:22 "
  NEW_POS=$(echo "$LADDERS" | grep -ow "$CUR_POS:\d\d" | cut -d":" -f2)
  if [ ! $NEW_POS ];then
    echo "$CUR_POS"
    return 1
  fi
  echo $NEW_POS
}

function snake() {
  local CUR_POS=$1
  local SNAKES="20:10 29:04"
  NEW_POS=$(echo "$SNAKES" | grep -ow "$CUR_POS:\d\d" | cut -d":" -f2)
  if [ ! $NEW_POS ];then
    echo "$CUR_POS"
    return 1
  fi
  echo $NEW_POS
}

function plain(){
  local CURR_POSITION=$1
  local NEXT_POSITION=0 
  local STEPS=$2  

  if [ $CURR_POSITION -eq 0 -a $STEPS -ne 6 ];then
    echo "0"
    return
  fi

  NEXT_POSITION=$(dc -e "$CURR_POSITION $STEPS + p")

  if [ $NEXT_POSITION -gt "30" ];then
    NEXT_POSITION=$CURR_POSITION
  fi

  echo "$NEXT_POSITION"
}

function move() {
  local PLAYER_NAME=$1
  local PLAYER_POS=$2

  read -p "$PLAYER_NAME's turn.. press ENTER to roll the dice:" 
  local DICE=$(roll_dice)
  echo "dice_rolled : $DICE"

  PLAYER_POS=$(plain $PLAYER_POS $DICE)
  echo "$PLAYER_NAME : $PLAYER_POS"

  PLAYER_POS=$(snake $PLAYER_POS)
  if [ $? -eq 0 ];then
    echo "THERE WAS A SNAKE" 
    echo "$PLAYER_NAME : $PLAYER_POS"
  fi

  PLAYER_POS=$(ladder $PLAYER_POS)
  if [ $? -eq 0 ];then
    echo "YOU GOT A LADDER" 
    echo "$PLAYER_NAME : $PLAYER_POS"
  fi

  return $PLAYER_POS
}

function announce_winner() {
  local PLAYER=$1
  local POSITION=$2
  if [ "$POSITION" -eq "30" ];then
    echo "yeah.. $PLAYER won the game"
    return 1
  fi
}

function game_loop() {

  local PLAYER1=$1
  local PLAYER2=$2
  local PLAYER1_POSITION=0
  local PLAYER2_POSITION=0

  while [ 1 ]
  do
    move $PLAYER1 $PLAYER1_POSITION
    PLAYER1_POSITION=$?
    announce_winner "$PLAYER1" "$PLAYER1_POSITION"
    if [ $? -eq 1 ];then
      return
    fi

    move $PLAYER2 $PLAYER2_POSITION
    PLAYER2_POSITION=$?
    announce_winner $PLAYER2 $PLAYER2_POSITION
    if [ $? -eq 1 ];then
      return
    fi

    read -p "press enter to clear the screen"
    clear
    ./board.sh
  done
}

function main() {
  read -p "Enter First Player Name: " PLAYER1
  read -p "Enter Second Player Name: " PLAYER2
  game_loop $PLAYER1 $PLAYER2
  echo "GAME OVER"
}

./board.sh
main
