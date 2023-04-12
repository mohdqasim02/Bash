#! /bin/bash

# This command takes a 'BACKED_UP FILE/DIRECTORY' and a 'PATH' as an argument
# and gives the extracted files in the given 'PATH', If not given any arguments 
# it will show all the files that are previously backed up
# PATH should be an absolute path
# BACKED_UP FILE_NAME should be full name

ARCHIVE_NAME=$1
RESTORE_PATH=$2
BACKUP_DIRECTORY="/Users/mohdqasim/.backup"

if [ ! $ARCHIVE_NAME ];then
  echo "  --> PREVIOUSLY BACKED UP FILES <--  "
  ls -l $BACKUP_DIRECTORY
  exit
fi

MATCHED_FILES=$(ls -a /Users/mohdqasim/.backup/$ARCHIVE_NAME* | nl -w1 -s" ")
echo "$MATCHED_FILES"
OPTION=$(head -n1)
FILE_NAME=$(echo "$MATCHED_FILES" | grep "^$OPTION" |cut -f2 -d" " )

if [ ! -f $FILE_NAME ];then
  echo "restore: $FILE_NAME : FILE NOT FOUND"
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

echo "$FILE_NAME IS RESTORED IN $RESTORE_PATH"
tar -xvzf $FILE_NAME -C $RESTORE_PATH  

