#!/bin/dash
#set -x
if [ ! -z "$1" ]
  then
    sleep $1
fi
cd '/home/pi/raspberryEasySurvillance'



DATE=$(date +"%Y-%m-%d_%H%M%S").jpg
raspistill --width 1296 --height 972 --timeout 1  --nopreview -o cam/$DATE



convert -colorspace LinearGray -normalize -blur 2x2  cam/$DATE blur/$DATE.mpc




file2=`ls -r blur/*.mpc | head -n 2 | tail -n 1`
latestImage="blur/$DATE.mpc"


val=$(compare  -fuzz 10% -metric AE $file2 $latestImage null 2>&1)

file2Cache=`ls -r blur/*.cache | head -n 2 | tail -n 1`
rm "$file2" "$file2Cache"

file2Image=`ls -r cam/ | head -n 2 | tail -n 1`
if [ "$val" -gt 1000 ]; then
   FILE=stateMotionDected
   if test -f "$FILE"; then
    rm "$FILE"
   else
    touch $FILE 
    cp "cam/$DATE" "ftp/"
    mv "cam/$file2Image" "ftp/"
    exit;
   fi
fi

rm "cam/$file2Image"


