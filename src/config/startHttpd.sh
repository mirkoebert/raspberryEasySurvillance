#!/bin/bash
#set -x

busybox httpd -p 8080 -h ~/raspberryEasySurvillance/www/

server=$(hostname -A | awk '{print $1}')
echo 
echo "open http://${server}:8080/snapshot.jpg
echo

