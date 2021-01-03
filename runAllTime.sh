#!/bin/dash
#set -x
cd /home/pi/raspberryEasySurvillance || exit 1

# rescue old motion images
mkdir -p rescued
mv ftp/*.jpg rescued

# clean up
./cleanupDirs.sh

while true; do
  ./runOnce.sh
done

