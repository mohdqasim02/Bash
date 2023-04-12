#! /bin/bash

NUM1=$2
NUM2=$3
NUM3=$1

max_of_two.sh $NUM3 $(max_of_two.sh $NUM1 $NUM2); 

