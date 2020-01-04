#!/bin/dash
#set -x
if [ ! -z "$1" ]
  then
    sleep $1
fi
cd '/home/pi/raspberryEasySurvillance'

file2Image=`ls -r cam/ | head -n 1`


DATE=$(date +"%Y-%m-%d_%H%M%S").jpg
raspistill --width 1296 --height 972 --timeout 1  --nopreview -o cam/$DATE



latestNImage="blur/$DATE.mpc"
convert -colorspace LinearGray -normalize -blur 2x2  cam/$DATE $latestNImage



file2=`ls -r blur/*.mpc | head -n 2 | tail -n 1`
val=$(compare  -fuzz 10% -metric AE $file2 $latestNImage null 2>&1)

file2Cache=`ls -r blur/*.cache | head -n 2 | tail -n 1`
rm "$file2" "$file2Cache"


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


