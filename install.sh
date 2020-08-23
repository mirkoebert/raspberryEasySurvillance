#!/bin/dash
#set -x

#run scripts with sudo

echo "Install software dependencies"
apt-get --yes install imagemagick tree ftp

echo "Configure Service"
cp survillancecam.service /etc/systemd/system/

echo "Enable Service at System Start"
echo 
echo sudo systemctl enable survillancecam.service
echo
echo "Star" Service"
echo
echo "sudo systemctl start survillancecam.service"
echo 


