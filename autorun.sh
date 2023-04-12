#! /bin/bash

function test() {
  local PREVIOUS_MODIFIED_TIME="$(date -r $1)";
  while [ 1 ] 
  do
    local CURRENT_MODIFIED_TIME="$(date -r $1)";

    if [ "$PREVIOUS_MODIFIED_TIME" != "$CURRENT_MODIFIED_TIME" ];
    then 
      clear;
      node $1;
    fi
    PREVIOUS_MODIFIED_TIME=$CURRENT_MODIFIED_TIME;
    sleep 2;
  done
}

test $1;
