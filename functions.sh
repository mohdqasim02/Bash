#! /bin/bash

function greeting() {
  local NAME=$1
  echo "HELLO $NAME"
  return 0
}

NAME="SIMBA"
greeting $NAME
greeting "MUFAASA"
echo $NAME
