#!/bin/dash
#set -x

cd /home/pi/raspberryEasySurvillance

# clean up
rm -f stateMotionDected
rm -f cam/*.*
rm -f blur/*.*
rm -r ftp/*.*

while true; do
  ./run2.sh
done
