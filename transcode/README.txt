DARKICE CONFIGURATION
9/24/2013

DAVID COHEN
864-986-0007
dacohenii@gmail.com

This computer runs a program called darkice, which transcodes captured audio (from studio A) into various formats, as determined by ~/darkice.cfg.

Darkice sends all of these audio streams to a program called icecast (http://www.icecast.org/), which broadcasts the encoded streams to the listeners at stream.wsbf.net:8000/<MOUNT POINT>
	(if you just go to stream.wsbf.net:8000 in a browser, you will get a diagnostic page listing mount points, etc)


Darkice is run with the following command (no quotes): "sudo darkice -c /home/compe/darkice.cfg"

NOTE: FOR DARKICE TO START, ICECAST MUST ALREADY BE RUNNING!!!
NOTE: FOR DARKICE TO START, ICECAST MUST ALREADY BE RUNNING!!!
NOTE: FOR DARKICE TO START, ICECAST MUST ALREADY BE RUNNING!!!
NOTE: FOR DARKICE TO START, ICECAST MUST ALREADY BE RUNNING!!!
NOTE: FOR DARKICE TO START, ICECAST MUST ALREADY BE RUNNING!!!
NOTE: FOR DARKICE TO START, ICECAST MUST ALREADY BE RUNNING!!!

It is automatically started with the script at /usr/local/bin/darkice_start_on_boot.sh. Crontab runs this script every 2 minutes (sudo crontab -e to edit)

SEE THE FOLLOWING THREAD:
	http://ubuntuforums.org/showthread.php?t=1780884
