#!/bin/dash
#set -x
cd /home/pi/raspberryEasySurvillance || exit 1

# clean up
rm -f stateMotionDected
rm -f cam/*.*
rm -f blur/*.*
rm -r ftp/*.*
rm -r www/*.*

while true; do
  ./runOnce.sh
done

