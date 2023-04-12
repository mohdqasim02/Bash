#! /bin/bash
 
MAX=$1
NUM=$2


if [ $NUM -gt $MAX ];then 
  MAX=$NUM
fi
echo "$MAX" 
