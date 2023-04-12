#! /bin/bash

COMMAND=$1

for CURRENT_PATH in $(echo $PATH | tr ":" "\n")
do
  if [ -x $CURRENT_PATH/$COMMAND ];then
    echo "$CURRENT_PATH/$COMMAND"
    exit
  fi
  if [ -x $COMMAND ];then
    echo "$COMMAND"
    exit
  fi
done
echo "$COMMAND NOT FOUND"
