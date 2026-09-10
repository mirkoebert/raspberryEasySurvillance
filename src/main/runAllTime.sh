#!/bin/dash
#set -x
cd /home/pi/raspberryEasySurvillance || exit 1

# rescue old motion images
mkdir -p rescued
mv ftp/*.jpg rescued

# clean up
./src/main/cleanUpDirs.sh

while true; do
  ./src/main/runOnce.sh
done

