#!/bin/bash
#set -x

HEIGHT=20
WIDTH=80
CHOICE_HEIGHT=5
BACKTITLE="raspberryEasySurvillance"
TITLE="Configuration"
MENU="Choose one of the following options:"

OPTIONS=(1 "Install Sofware and Start Demon"
         2 "Configure FTP Image Upload - write .netrc"
         3 "Start Http deamon"
	 4 "Kill Http deamon"
 	 5 "Exit")


while true
do
CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            sudo ./install.sh
            ;;
        2)
            ./configureFTP.sh
            ;;
        3)
            .src/config/startHttpd.sh
            ;;
        4)
            pkill busybox
            ;;
        5)
            exit
            ;;
esac

done

