#!/bin/dash
#set -x
. config
cd $RES_DIR

# clean up
rm -f stateMotionDected
rm -f cam/*.*
rm -f blur/*.*
rm -r ftp/*.*

while true; do
  ./run2.sh
done

