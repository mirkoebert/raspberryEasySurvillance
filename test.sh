#!/bin/bash

function prepare {        
	echo -----------------------------
	echo `date` Test: $1 
	rm -f cam/*.jpg
	rm -f blur/*.jpg
	rm -f ftp/*.jpg
	rm -f stateMotionDected
}

function assertEquals {
  echo `date` Result: "$1"
  if [ "$1" = "$2" ]; then
	echo Ok
  else
	echo Failed
  fi
}

prepare 1	
cp testPic/image.jpg cam
./normaize.sh
cp testPic/image2.jpg cam
./normaize.sh

result=$(./detectMotion.sh)
assertEquals "No Motion" "$result"


prepare 2	
cp testPic/image2.jpg cam
./normaize.sh
cp testPic/image3.jpg cam
./normaize.sh

result=$(./detectMotion.sh)
assertEquals "No Motion" "$result"


prepare 3	
cp testPic/image4.jpg cam
./normaize.sh
cp testPic/image3.jpg cam
./normaize.sh

result=$(./detectMotion.sh)
assertEquals "No Motion" "$result"

prepare 4	
cp testPic/image4.jpg cam
./normaize.sh
cp testPic/image4X.jpg cam
./normaize.sh

result=$(./detectMotion.sh)
assertEquals "Motion detected" "$result"

