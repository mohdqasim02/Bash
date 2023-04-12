#! /bin/bash

function cell_1() {
  echo -n " \\"
}

function cell_2() {
  echo -n "/ "
}

function cell_3() {
  echo -n "\\ "
}

function cell_4() {
  echo -n " /"
}

function compliment() {
  echo $1 | tr "12" "34"
} 

function generate_pattern() {
  jot -r 8 1 2 | tr "\n" " "
}

function tile() {
  local PATTERN=$(generate_pattern)
  for ROW in 1 2
  do
    echo -n -e "\t"
    for COL in $PATTERN
    do
      cell_$COL
    done
    echo
    PATTERN=$(compliment "$PATTERN")
  done
}

function main() {
  echo
  for ROWS_OF_TILE in {1..5}
  do
    tile
  done
  echo
}

main


