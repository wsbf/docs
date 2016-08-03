#!/bin/sh

X=`ps aux | grep -c "darkice.cfg"`

# Checking startup status for darkice

if [ $X != 2 ]; then
#    echo "SUCCESS: We can now start darkice after boot"
#    echo 1 > /usr/local/bin/darkice_boot_pid
    /sbin/alsa force-reload
    /usr/bin/darkice -v 10 -c /home/compe/darkice.cfg
else
    echo "ERROR: PID does not equal 0, so we can't start"
    exit 1
fi
