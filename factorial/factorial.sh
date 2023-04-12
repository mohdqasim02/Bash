#! /bin/zsh

NUM=$1
FACTORIAL=1

if [ $NUM -lt 0 ];then
  echo "0"
  exit
fi

# jot -s"*" $NUM1 1 $NUM1 | sed s/"*"/"\n*\n"/g | sort -r | tr "\n" " " | sed 's:\(.*\):\1p:g' | dc
#seq -s'\n*\n' 0 1 $NUM1 | sort -r | sed 's/^0/1/g' | tr "\n" " " | sed 's:^\(.*\) \* $:1 \1 p:g' | dc

#RECURSIVE APPROACH
#echo "$(dc -e "$NUM $(./factorial.sh $(dc -e "$NUM 1 - p")) * p")"

#WITH FOR LOOP
#for CURRENT_NUM in {1..$NUM}
#do
#  FACTORIAL=$(dc -e "$FACTORIAL $CURRENT_NUM * p")
#done

#WITH WHILE LOOP
while [ $NUM -gt 0 ]
do
  FACTORIAL=$(dc -e "$FACTORIAL $NUM * p")
  NUM=$(dc -e "$NUM 1 - p")
done

echo $FACTORIAL
