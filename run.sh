#!/bin/bash

if [ -z "$1" ]
  then
    echo "No sleep time given."
else
    sleep $1
fi

cd /home/pi/survillance

./getImage.sh
./detectMotion.sh

