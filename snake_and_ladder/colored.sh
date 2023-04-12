#! /bin/zsh

function roll_dice() {
  jot -w 0 -r 1 1 6
}

function echo_red() {
  echo -n -e "\t\e[1;31m$1\e[0m"
}

function echo_green() {
  echo -n -e "\t\e[1;32m$1\e[0m"
}

function echo_red_hl() {
  echo -n -e "\t\e[1;41m$1\e[0m"
}

function echo_green_hl() {
  echo -n -e "\t\e[1;42m$1\e[0m"
}

function show_player2_pos() {
  echo -n -e "\t\e[5;44m$1\e[0m"
}

function show_player2() {
  echo -n -e "\t\e[1;44m$1\e[0m"
}

function show_player1() {
  echo -n -e "\t\e[1;43m$1\e[0m"
}

function show_player1_pos() {
  echo -n -e "\t\e[5;43m$1\e[0m"
}

function display_instructions() {
  echo "\n\tThis is the board for snake_ladders game"
  echo "\tThe green color denotes a ladder"
  echo "\tThe red color denotes a snake"
  echo "\n\tYellow color is Player1"
  echo "\tBlue color is Player2\n"
}

function show_value() {
  local NUM=$1
  case $NUM in

    12)
      NUM="17"
      ;;

    18)
      NUM="22"
      ;;

    20)
      NUM="10"
      ;;

    29)
      NUM="25"
      ;;

    esac
    echo "$NUM"
  }

  function print_board() {
    local POS1=$1 
    local POS2=$2 

    display_instructions
    for CELL in {30..1}
    do
      local VALUE=$(show_value "$CELL")

      if [ $POS1 = $CELL ]
      then
        show_player1_pos "$VALUE"
      elif [ $POS2 = $CELL ]
      then
        show_player2_pos "$VALUE"
      elif [ $VALUE -lt $CELL ]
      then
        echo_red "-$VALUE"
      elif [ $VALUE -gt $CELL ]
      then
        echo_green "+$(dc -e "$VALUE $CELL - p")"
      else
        echo -n "\t$VALUE"
      fi

      if [ $(dc -e "$CELL 10 % p") -eq "1" ]
      then
        echo "\n"
      fi
    done
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
    local PLAYER_POS=$1
    local PLAYER_NAME=""

    if [ $TURN -eq 2 ];then
      PLAYER_NAME=$PLAYER1
      TURN=1
    else
      PLAYER_NAME=$PLAYER2
      TURN=2
    fi

    show_player$TURN "\t$PLAYER_NAME's turn.. press ENTER to roll the dice:\t"
    read 
    local DICE=$(roll_dice)
    show_player$TURN "\tdice_rolled : $DICE \t\n"

    PLAYER_POS=$(plain $PLAYER_POS $DICE)
    show_player$TURN "\t$PLAYER_NAME : $PLAYER_POS\t\n"

    PLAYER_POS=$(snake $PLAYER_POS)
    if [ $? -eq 0 ];then
      echo
      echo_red "THERE WAS A SNAKE\t\n" 
      echo_red_hl "\t$PLAYER_NAME : $PLAYER_POS\t\n"
    fi

    PLAYER_POS=$(ladder $PLAYER_POS)
    if [ $? -eq 0 ];then
      echo
      echo_green "YOU GOT A LADDER\t\n" 
      echo_green_hl "\t$PLAYER_NAME : $PLAYER_POS\t\n"
    fi
    return $PLAYER_POS
  }

  function announce_winner() {
    local POS_1=$1
    local POS_2=$2

    if [ "$POS_1" -eq "30" ];then
      echo_green_hl "\tyeah 🎉... $PLAYER1 won the game\t\n"
      return 1
    fi

    if [ "$POS_2" -eq "30" ];then
      echo_green_hl "\tyeah 🎉... $PLAYER2 won the game\t\n"
      return 1
    fi
  }

  function start_game() {
    local PLAYER1_POSITION=0
    local PLAYER2_POSITION=0
    TURN=2

    while [ 1 ]
    do
      move "$PLAYER1_POSITION"
      PLAYER1_POSITION=$?
      echo "\n"

      move "$PLAYER2_POSITION"
      PLAYER2_POSITION=$?

      echo "\n\tpress enter to clear the screen";read
      clear
      print_board "$PLAYER1_POSITION" "$PLAYER2_POSITION"

      announce_winner "$PLAYER1_POSITION" "$PLAYER2_POSITION"
      if [ $? -eq 1 ];then
        echo_green_hl "\tGAME OVER\t"
        return
      fi
    done
  }

  function main() {
    print_board "0" "0"
    echo -n "\tEnter First Player Name: "
    read PLAYER1
    echo -n "\tEnter Second Player Name: "
    read PLAYER2
    echo
    start_game "$PLAYER1" "$PLAYER2"
    echo "\n"
  }

  main
