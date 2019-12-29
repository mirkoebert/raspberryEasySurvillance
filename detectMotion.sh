#!/bin/bash

file2=`ls -r blur/ | head -n 1`

latestImage=`ls -r cam | head -n1`
convert -normalize -blur 0x8  cam/$latestImage blur/$latestImage


val=$(compare  -fuzz 10% -metric RMSE blur/$file2 blur/$DATE.jpg /dev/null 2>&1)


rm blur/$file2
val2=$(echo $val | awk '{print $1}')


limit=790.4
x=$(echo $val2'>'$limit | bc -l)

FILE=stateMotionDected
if [ "$x" -eq "0" ]; then
   echo "Keine Bewegung erkannt";
else
   if test -f "$FILE"; then
    echo "Bewegung zu Ende"
    rm $FILE
   else
    echo "Bewegung erkannt"
    touch $FILE 
    mv camImages/$latestImage ftp/
    exit;
   fi
fi

rm cam/$latestImage


