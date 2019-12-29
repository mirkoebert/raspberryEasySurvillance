#!/bin/bash

sleep $1

DATE=$(date +"%Y-%m-%d_%H%M%S")


cd /home/pi/survillance
file2=`ls -r blur/ | head -n 1`

raspistill --width 1296 --height 972  --nopreview -o cam/$DATE.jpg

convert -normalize -blur 0x8  cam/$DATE.jpg blur/$DATE.jpg

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
    mv camImages/$DATE.jpg ftp/
    exit;
   fi
fi

rm camImages/$DATE.jpg

