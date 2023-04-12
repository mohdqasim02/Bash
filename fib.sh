#! /bin/zsh

NUM=$1
echo -n "\n$NUM-th Term of the series is: "
jot -b"dsr + lrr" -s" " $NUM 1 $NUM | sed -e "s:^\(dsr + lrr\):0:g" -e "s:^\(0\) dsr + lrr:\1 1:g" | sed "s:\(.*\):\1 p:g" | dc #Nth term
echo "-------------------------------------------"
echo "\t---> Full Series <---"
jot -b "dsr + lrr p" -s" " $NUM 1 $NUM | sed -e "s:^dsr + lrr p:0:g" -e "s:^\(0\) dsr + lrr p:\1 1 rfr:g" | dc  #full series
echo -n "\n"
