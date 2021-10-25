#!/bin/bash
#set -x
# -e option instructs bash to immediately exit if any command [1] has a non-zero exit status
# We do not want users to end up with a partially working install, so we exit the script
# instead of continuing the installation with something broken
set -e

    COL_NC='\e[0m' # No Color
    COL_LIGHT_GREEN='\e[1;32m'
    COL_LIGHT_RED='\e[1;31m'
    TICK="[${COL_LIGHT_GREEN}✓${COL_NC}]"
    CROSS="[${COL_LIGHT_RED}✗${COL_NC}]"
    INFO="[i]"
    # shellcheck disable=SC2034
    DONE="${COL_LIGHT_GREEN} done!${COL_NC}"
    OVER="\\r\\033[K"


#run scripts with sudo
if [[ $(id -u) -ne 0 ]] ; then echo "Please run this script as root" ; exit 1 ; fi

grep Model /proc/cpuinfo 

str="Install software dependencies"
printf "%b  %b %s\\n" "${OVER}" "${TICK}" "${str}"
apt-get update
apt-get --yes install imagemagick tree lftp lighttpd  boxes dialog unattended-upgrades 

str="Enable automatic installation of security updates"
printf "%b  %b %s\\n" "${OVER}" "${TICK}" "${str}"
sudo dpkg-reconfigure -plow unattended-upgrades

str="Install and Setup lighttpd HTTP server"
printf "%b  %b %s\\n" "${OVER}" "${TICK}" "${str}"
groupadd www-data
usermod -G www-data -a pi
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html
service lighttpd force-reload

str="Install PHP and enable CGI"
printf "%b  %b %s\\n" "${OVER}" "${TICK}" "${str}"
apt install php-cgi
lighty-enable-mod fastcgi-php

str="Server Mode Setup: Disable WIFI Power Saving"
printf "%b  %b %s\\n" "${OVER}" "${TICK}" "${str}"
iwconfig wlan0 power off
echo "wireless-power off"  >> /etc/network/interfaces

str="Disable unneeded components"
printf "%b  %b %s\\n" "${OVER}" "${TICK}" "${str}"
/opt/vc/bin/tvservice -o

str="Configure Service"
printf "%b  %b %s\\n" "${OVER}" "${TICK}" "${str}"
cp ./src/config/survillancecam.service /etc/systemd/system/

str="Enable Service at System Start"
printf "%b  %b %s\\n" "${OVER}" "${TICK}" "${str}"
systemctl enable survillancecam.service

str="Start Service at System Start"
printf "%b  %b %s\\n" "${OVER}" "${TICK}" "${str}"
systemctl start survillancecam.service

str="Check Service is running"
printf "%b  %b %s\\n" "${OVER}" "${TICK}" "${str}"
systemctl status survillancecam.service

echo "Run ./config.sh to configure the software" | boxes -boy -ac


