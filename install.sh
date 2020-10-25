#!/bin/bash
#set -x

#run scripts with sudo
if [[ `id -u` -ne 0 ]] ; then echo "Please run this script as root" ; exit 1 ; fi

echo "Install software dependencies"
apt-get --yes install imagemagick tree lftp boxes

echo "Configure Service" | boxes -d boy -ac
cp survillancecam.service /etc/systemd/system/

echo "Enable Service at System Start"
echo 
sudo systemctl enable survillancecam.service
echo
echo "Start Service at System Start"
sudo systemctl start survillancecam.service
echo
echo "Check Service is running"
sudo systemctl status survillancecam.service

