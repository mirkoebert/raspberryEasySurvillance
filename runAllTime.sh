#!/bin/dash
#set -x
. config
cd $RES_HOMER

# clean up
rm -f stateMotionDected
rm -f cam/*.*
rm -f blur/*.*
rm -r ftp/*.*

while true; do
  ./run2.sh
done

