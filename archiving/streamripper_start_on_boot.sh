#!/bin/sh

CMD_METADATA="/usr/local/bin/fetch_external_metadata.sh"
URL_STREAM="http://wsbf.net:8000/low"
DST_PATH="/media/Bret/archives"

X=$(ps aux | grep -c "/usr/bin/streamripper")

if [ $X -lt 2 ] ; then
    /usr/bin/streamripper $URL_STREAM -E $CMD_METADATA -d $DST_PATH -D %T > /dev/null
else
    echo "ERROR: Streamripper is running"
    ps aux | grep "/usr/bin/streamripper $URL_STREAM"
    exit 1
fi
