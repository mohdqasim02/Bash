#! /bin/bash

function generate_random_number() {
  jot -r 1 -$1 $1 | tr "-" "_"
}

function calc_square(){
  dc -e "$1 $1 * p"
}

function calc_distance() {
  local X_CORD_SQ=$(calc_square "$1")
  local Y_CORD_SQ=$(calc_square "$2")
  dc -e "$X_CORD_SQ $Y_CORD_SQ + p"
}

function locate_cordinates() {
  local X=$1
  local Y=$2
  local RADIUS=$3

  local RADIUS_SQ=$(calc_square "$RADIUS")
  local DISTANCE=$(calc_distance "$X" "$Y")

  [ "$DISTANCE" -gt "$RADIUS_SQ" ]
}

function calc_pi() {
  local RADIUS=$1
  local RANDOM_POINTS_INSIDE_CIRCLE=0

  for POINTS in {1..100}
  do
    local X_CORD=$(generate_random_number $RADIUS)
    local Y_CORD=$(generate_random_number $RADIUS)
    locate_cordinates "$X_CORD" "$Y_CORD" "$RADIUS"
    RANDOM_POINTS_INSIDE_CIRCLE=$(dc -e "$? $RANDOM_POINTS_INSIDE_CIRCLE + p")
  done 
  dc -e "$RANDOM_POINTS_INSIDE_CIRCLE 40000 * p" 
}

calc_pi "$1"
