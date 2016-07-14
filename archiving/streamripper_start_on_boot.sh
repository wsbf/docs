#!/bin/sh

URL_METADATA="http://new.wsbf.net/wizbif/streamripper.php"
URL_STREAM="http://stream.wsbf.net:8000/low"

X=`ps aux | grep -c "/usr/bin/streamripper $URL_STREAM"`

if [ $X -lt 2 ] ; then
     /usr/bin/streamripper "$URL_STREAM" -d /media/ZAutoLib/archives -s -E "perl /home/compe/fetch_external_metadata.pl $URL_METADATA" -D %T > /dev/null
else
    echo "ERROR: Streamripper is running"
    ps aux | grep "/usr/bin/streamripper $URL_STREAM"
    exit 1
fi
