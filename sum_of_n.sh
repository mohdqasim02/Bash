#! /bin/bash

NUM1=$1
if [ $NUM1 -eq 0 ];then
  echo 0
  exit
fi

SUM=$(dc -e "$NUM1 $(./sum_of_n.sh $(dc -e "$NUM1 1 - p")) + p")
echo $SUM
exit
