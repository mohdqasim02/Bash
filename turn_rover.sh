#! /bin/bash
# echo "$1 $2" | sed -f /Users/mohdqasim/foo/Scripts/instructions.sed

DIRECTION=$1
INSTRUCTION=$2

if [ $INSTRUCTION -eq 0 ];then
  INSTRUCTION=1
  if [ $DIRECTION -eq 3 ];then
    DIRECTION=0
  fi
else
  INSTRUCTION=_1
  if [ $DIRECTION -eq 0 ];then
    DIRECTION=4
  fi
fi

dc -e "$DIRECTION $INSTRUCTION + p" 
