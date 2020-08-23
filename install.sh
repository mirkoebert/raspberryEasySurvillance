#!/bin/dash
#set -x

#run scripts with sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run script with sudo"
  exit
fi

echo "Install software dependencies"
apt-get --yes install imagemagick tree ftp

echo "Configure Service"
cp survillancecam.service /etc/systemd/system/

echo "Start Service"


