#! /bin/bash

WORDS=$(cat /usr/share/dict/words | head -n200 )
SUM_OF_ALL_CHARACTERS=0

for CURRENT_WORD in $WORDS
do
  NO_OF_CHARACTERS=$(echo $CURRENT_WORD | wc -c)
  if [ $NO_OF_CHARACTERS -ge 6 ];then
    SUM_OF_ALL_CHARACTERS=$(dc -e "$SUM_OF_ALL_CHARACTERS $NO_OF_CHARACTERS + p")
  fi
done

echo $SUM_OF_ALL_CHARACTERS
