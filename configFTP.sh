#!/bin/bash
#set -x

HEIGHT=20
WIDTH=80
CHOICE_HEIGHT=4
BACKTITLE="raspberryEasySurvillance"
TITLE="Configuration FTP"
MENU="Choose one of the following options:"


server="nas1.local"
password="geheim23"
user="camUser2"

# open fd
exec 3>&1

# Store data to $VALUES variable
VALUES=$(dialog --ok-label "Submit" \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --form "$MENU" \
15 50 0 \
	"Username:" 1 1	"$user" 	1 10 30 0 \
	"Server:"   2 1	"$server"  	2 10 30 0 \
	"Password:" 3 1	"$password"  	3 10 30 0 \
2>&1 1>&3)

# close fd
exec 3>&-

# display values just entered
echo "$VALUES"

i=0
while read -r line; do
   ((i++))
   declare var$i="${line}"
done <<< "${VALUES}"


if [ -n "$VALUES" ]; then
    echo "Write ~/.netrc"
    echo "machine $var2 login $var1  password $var3 " > ~/.netrc
else
    echo "empty"
fi

