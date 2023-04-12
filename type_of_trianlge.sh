#! /bin/zsh

ANGLE_A=$1
ANGLE_B=$2
ANGLE_C=$3

SUM_OF_ANGLES=$(dc -e "$ANGLE_A $ANGLE_B $ANGLE_C + + p")
LARGEST_ANGLE=$(./max_of_three.sh $ANGLE_A $ANGLE_B $ANGLE_C)
NO_OF_UNIQ_ANGLES=$(echo "$ANGLE_A\n$ANGLE_B\n$ANGLE_C" | sort -nr | uniq -c | wc -l)

if [ $SUM_OF_ANGLES -ne 180 ];then
  echo "Not a Triangle"
  exit 
fi

if [ $LARGEST_ANGLE -eq 90 ];then
  echo "RIGHT"
  exit
fi

if [ $NO_OF_UNIQ_ANGLES -eq 1 ];then
  echo "EQUILATERAL"
  exit
fi

if [ $NO_OF_UNIQ_ANGLES -eq 2 ];then
  echo "ISOCELES"
  exit
fi

if [ $LARGEST_ANGLE -lt 90 ];then
  echo "ACUTE"
  exit
fi

if [ $NO_OF_UNIQ_ANGLES -eq 3 ];then
  echo "SCALENE"
  exit
fi
