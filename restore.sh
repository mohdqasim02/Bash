#! /bin/bash

# This command takes a 'BACKED_UP FILE/DIRECTORY' and a 'PATH' as an argument
# and gives the extracted files in the given 'PATH', If not given any arguments 
# it will show all the files that are previously backed up
# PATH should be an absolute path
# BACKED_UP FILE_NAME should be full name

FILE_TO_EXTRACT=$1
RESTORE_PATH=$2
BACKUP_DIRECTORY="/Users/mohdqasim/.backup"

if [ ! $FILE_TO_EXTRACT ];then
  echo "  --> PREVIOUSLY BACKED UP FILES <--  "
  ls -l $BACKUP_DIRECTORY
  exit
fi

if [ ! -e $BACKUP_DIRECTORY/$FILE_TO_EXTRACT ];then
  echo "restore: $FILE_TO_EXTRACT : FILE NOT FOUND"
  echo "  --> PREVIOUSLY BACKED UP FILES <--  "
  ls -l $BACKUP_DIRECTORY
  exit
fi

if [ ! $RESTORE_PATH ];then
  echo "restore : PLEASE PROVIDE A PATH TO EXTRACT THE FILES"
  exit
fi

if [ ! -d $RESTORE_PATH ];then
  echo "restore: $RESTORE_PATH : NO SUCH DIRECTORY FOUND"
  exit
fi

tar -xvzf $BACKUP_DIRECTORY/$FILE_TO_EXTRACT -C $RESTORE_PATH  
