#! /bin/bash

function roll_dice() {
  jot -r 1 1 6
}

#function snake() {
#  local SNAKES="20:10 29:04"
#  NEW_POS=$(echo "$SNAKES" | grep -o "$1:\d\d" | cut -d":" -f2)
#  if [ ! NEW_POS ];then
#    echo "$NEW_POS"
#    return
#  fi
#  echo $NEW_POS
#}

function snake() {
  local POSITION=$1
  if [ $POSITION -eq "29" ];then
    echo "There was a snake at $POSITION (-25)"
    return 4
  fi

  if [ $POSITION -eq "20" ];then
    echo "There was a snake at $POSITION (-10)"
    return 10
  fi
  return $POSITION 
}

function ladder() {
  local POSITION=$1
  if [ $POSITION -eq "12" ];then
    echo "You climbed a Ladder at $POSITION (+5)"
    return 17
  fi

  if [ $POSITION -eq "18" ];then
    echo "You climbed a Ladder at $POSITION (+4)"
    return 22
  fi
  return $POSITION 
}

function move(){
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

function game_loop() {
  local PLAYER_POS=$1
  local DICE=$(roll_dice)
  echo "dice_rolled : $DICE"
  PLAYER_POS=$(move $PLAYER_POS $DICE)
  snake $PLAYER_POS
  PLAYER_POS=$?
  ladder $PLAYER_POS
  PLAYER_POS=$?
  return $PLAYER_POS
}

function main() {
  read -p "Enter First Player Name: " PLAYER1
  read -p "Enter Second Player Name: " PLAYER2
  local PLAYER1_POSITION=0
  local PLAYER2_POSITION=0

  while [ $PLAYER1_POSITION -lt 30 -a $PLAYER2_POSITION -lt 30 ]
  do
    read -p "$PLAYER1's turn.. press 0 to roll the dice:" PAUSE
    game_loop $PLAYER1_POSITION
    PLAYER1_POSITION=$?
    echo "$PLAYER1: $PLAYER1_POSITION"
    if [ $PLAYER1_POSITION -ge 30 ];then
      WINNER="$PLAYER1"
      break
    fi

    read -p "$PLAYER2's turn.. press 0 to roll the dice:" PAUSE
    game_loop $PLAYER2_POSITION
    PLAYER2_POSITION=$?
    echo "$PLAYER2: $PLAYER2_POSITION"
    if [ $PLAYER2_POSITION -ge 30 ];then
      WINNER="$PLAYER2"
      break
    fi
    read -p "$PLAYER1's turn.. press enter to roll the dice:" PAUSE
    clear
#    ./board.sh
  done

  echo "yeah.. $WINNER won the game"
}

#./board.sh
main
