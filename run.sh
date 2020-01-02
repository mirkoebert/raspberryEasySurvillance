#!/bin/bash

if [ -z "$1" ]
  then
    echo "No sleep time given."
else
    sleep $1
fi

cd /home/pi/raspberryEasySurvillance

./getImage.sh
./normaize.sh
./detectMotion.sh

