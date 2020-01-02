#!/bin/bash
testDir=testPic1296x972_8-bit_sRGB
#testDir=testPic1296x972_8-bit_gray

function prepare {        
	echo -----------------------------
	echo `date` Test: $1 
	rm -f cam/*.jpg
	rm -f blur/*.*
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
cp $testDir/image.jpg cam
./normaize.sh
cp $testDir/image2.jpg cam
./normaize.sh

result=$(./detectMotion.sh)
assertEquals "No Motion" "$result"


prepare 2	
cp $testDir/image2.jpg cam
./normaize.sh
cp $testDir/image3.jpg cam
./normaize.sh

result=$(./detectMotion.sh)
assertEquals "No Motion" "$result"


prepare 3	
cp $testDir/image4.jpg cam
./normaize.sh
cp $testDir/image3.jpg cam
./normaize.sh

result=$(./detectMotion.sh)
assertEquals "No Motion" "$result"

prepare 4	
cp $testDir/image4.jpg cam
./normaize.sh
cp $testDir/image4X.jpg cam
./normaize.sh

result=$(./detectMotion.sh)
assertEquals "Motion detected" "$result"

