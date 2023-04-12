#! /bin/bash

function calc_square(){
  dc -e "$1 $1 * p"
}

function get_coords(){
  seq -s " " -$1 $1 | tr "-" "_"
}

function calc_distance() {
  local X_CORD_SQ=$(calc_square "$1")
  local Y_CORD_SQ=$(calc_square "$2")
  dc -e "$X_CORD_SQ $Y_CORD_SQ + v p"
}

function is_inside_circle() {
  local X=$1
  local Y=$2
  local RADIUS=$3

  local DISTANCE=$(calc_distance "$X" "$Y")
  [ "$DISTANCE" -gt "$RADIUS" ]
}

function print_cols() {
  local ROW=$1
  local CORDINATES=$2

  for COL in $CORDINATES
  do
    is_inside_circle "$ROW" "$COL" "$RADIUS" 
    if [ $? -eq 1 ]
    then
      echo -n ".."
    else
      echo -n "  "
    fi
  done
}

function print_circle(){
  local RADIUS=$1
  local RADIUS_SQ=$(calc_square "$RADIUS")
  local CORDINATES=$(get_coords "$RADIUS")

  for ROW in $CORDINATES
  do
    echo -n -e "\t"
    print_cols "$ROW" "$CORDINATES"
    echo
  done
}

function main (){
  echo
  print_circle "$1"
  echo
}

main $1
