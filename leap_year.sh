#! /bin/bash

YEAR=$1
IS_LEAP=1
YEAR_REMAINDERED_BY_4=$(dc -e "$YEAR 4 % p")
YEAR_REMAINDERED_BY_100=$(dc -e "$YEAR 100 % p")
YEAR_REMAINDERED_BY_400=$(dc -e "$YEAR 400 % p")

if [ $YEAR_REMAINDERED_BY_4 -eq 0 ];then
  IS_LEAP=0
fi

if [ $YEAR_REMAINDERED_BY_100 -eq 0 ];then
  IS_LEAP=1
fi

if [ $YEAR_REMAINDERED_BY_400 -eq 0 ];then
  IS_LEAP=0
fi

echo "$IS_LEAP"

# dc -e "$YEAR 4 % s1 $YEAR 100 % s2 $YEAR 400 % s3 l3 l2 l1 f" | grep -c "^0" | sed -e "s/^2/Not a Leap year/g" -e "s/^0/Not a Leap year/g" -e "s/^1/leap year/g" -e "s/^3/leap year/g"
