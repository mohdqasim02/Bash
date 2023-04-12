#! /bin/bash

#This command takes a 'DIRECTORY/FILE' and a 'NAME' and create a backup of given 'DIRECTORY/FILE' named as given 'NAME' with timestamp 
# in a hidden directory '.backup' in your Home directory.

LOCATION_TO_ARCHIVE=$1
NAME=$2
DESTINATION="/Users/mohdqasim/.backup"

if [ ! -d $LOCATION_TO_ARCHIVE ];then
  echo "$LOCATION_TO_ARCHIVE DIRECTORY NOT FOUND"
  exit
fi

if [ ! -d $DESTINATION ];then
  mkdir $DESTINATION
  echo "$DESTINATION DIRECTORY IS CREATED"
fi

TIMESTAMP=$(date "+%d%m%Y_%H%M")
FILE_NAME=$DESTINATION/$NAME\_$TIMESTAMP.tar.gz

tar -cvzf $FILE_NAME -C $LOCATION_TO_ARCHIVE . 
