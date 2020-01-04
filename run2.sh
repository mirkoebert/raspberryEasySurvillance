#!/bin/dash
#set -x
if [ -z "$1" ]
  then
    echo 'No sleep time given.'
else
    sleep $1
fi
cd '/home/pi/raspberryEasySurvillance'



DATE=$(date +"%Y-%m-%d_%H%M%S").jpg
raspistill --width 1296 --height 972 --timeout 1  --nopreview -o cam/$DATE



latestImage=`ls -r cam | head -n1`
convert -colorspace LinearGray -normalize -blur 2x2  cam/$latestImage blur/$latestImage.mpc





file2=`ls -r blur/*.mpc | head -n 2 | tail -n 1`
file2Cache=`ls -r blur/*.cache | head -n 2 | tail -n 1`
latestImage=`ls -r blur/*.mpc | head -n 1`


val=$(compare  -fuzz 10% -metric AE $file2 $latestImage null 2>&1)

rm "$file2" "$file2Cache"

latestImage=`ls -r cam/ | head -n 1`
file2Image=`ls -r cam/ | head -n 2 | tail -n 1`
FILE=stateMotionDected
if [ "$val" -lt 1000 ]; then
   echo "No Motion";
else
   if test -f "$FILE"; then
    echo "Motion ends"
    rm "$FILE"
   else
    echo "Motion detected"
    touch $FILE 
    cp "cam/$latestImage" "ftp/"
    mv "cam/$file2Image" "ftp/"
    exit;
   fi
fi

rm "cam/$file2Image"
#rm cam/$latestImage

