#!/bin/bash

sleep $1
cd /home/pi/survillance

./getImage.sh
./detectMotion.sh

