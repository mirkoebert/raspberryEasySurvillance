#!/bin/bash
#set -x

file2=`ls -r blur/ | head -n 2 | tail -n 1`
latestImage=`ls -r blur | head -n 1`


val=$(compare  -fuzz 10% -metric RMSE blur/$file2 blur/$latestImage /dev/null 2>&1)


rm blur/$file2
val2=$(echo $val | awk '{print $1}')


limit=791.4
x=$(echo $val2'>'$limit | bc -l)


FILE=stateMotionDected
if [ "$x" -eq "0" ]; then
   echo "No Motion";
else
   if test -f "$FILE"; then
    echo "Motion ends"
    rm $FILE
   else
    echo "Motion detected"
    touch $FILE 
    mv cam/$latestImage ftp/
    exit;
   fi
fi

rm cam/$latestImage


