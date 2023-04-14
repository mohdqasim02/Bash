#! /bin/bash

function test() {
  local FILE_RUNNER=$1;
  local FILE_TO_EXECUTE=$2;
  local PREVIOUS_MODIFIED_TIME="$(stat -f "%m" ./*/* | tr -d "\n")";
  while [ 1 ] 
  do
    local CURRENT_MODIFIED_TIME="$(stat -f "%m" ./*/* | tr -d "\n")";

    if [ "$PREVIOUS_MODIFIED_TIME" != "$CURRENT_MODIFIED_TIME" ];
    then 
      clear;
      $FILE_RUNNER $FILE_TO_EXECUTE;
    fi
    PREVIOUS_MODIFIED_TIME=$CURRENT_MODIFIED_TIME;
    sleep 2;
  done
}

test $1 $2;
