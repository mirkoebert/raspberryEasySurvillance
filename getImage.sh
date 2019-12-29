#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M%S").jpg
raspistill --width 1296 --height 972  --nopreview -o cam/$DATE
echo $DATE

