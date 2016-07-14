# Contents

- New Server Setup
- Filesystem
- Script & Cron
- Web Interface

## New Server Setup
    // list devices
    lsblk
    // show drive data
    sudo file -s /dev/sdb2
    // format fs (/dev/sdb2) to ext4
    sudo mkfs -t ext4 /dev/sdb2
    // mount fs once
    sudo mount /dev/sdd2/ /media/archives
    // mount on boot - edit fstab 
    // create directory 'archives'
    mkdir archives

## Archiving Filesystem 
Archiving is run on John, 130.127.17.39, in the engineering closet. 
Current mounted drives are ZAutoLib, archives, and BACKUPS.  
Archives are written as ShowID.mp3, a schema developed by David Cohen.

1. **media/ZAutoLib/archives**

    - archiving scripts currently write to this directory
2. **media/archives**

    - recovered BC_China, now formatted to ext4 and receiving archives from BACKUPS/BC_China.
3. **media/BACKUPS**

    - BC_China
    - archives
    - archives_try2

### Procedure for reformatting BC_China filesystem to ext4
    1 Record Archives on Boot
    2 Naming format for archives
        Alter streamripper.php
        alter fetch_external_metadata_PL
        reformat BC_China (aka Archie) to ext4
           give non-stupid name
        move old archives from ext_hdd to Archie
        move old archives from ZAutoLib to Archie
        switch archiving from ZAutoLib to archie
        Rename all old archives to match new format
            modify db if needed
        Erase Ext_HDD

### Procedure for reformatting ZAutoLib Raid-Array to ext4

        1 move to backup automation
        2 move archives to Archie
        3 copy zautolib to ext_HDD
        4 reformat ZAutoLib to Ext4
        5.1 copy ext_hdd data back to ZAutoLib
        5.2 modify fstab on affected computers
            - George
            - A2
            - John

## Archival Script 
    This script runs on John (130.127.17.39) to start darkice and icecast. 
    /usr/local/bin/streamripper_start_on_boot.sh

    START:
        IS ARCHIVING RUNNING?
            IF YES, DO NOTHING
            IF NO, START RUNNING ARCHIVES
	
## Web interfaces

- Stable: http://new.wsbf.net/wizbif/archives/index.php
- Bleeding Edge: new.wsbf.net/jpgr > profiles > search > show name & date

**Page specification**

    Drop Down Menu for DJ name.  Select DJ, hit submit, it provides you a list of 
    all shows that DJ has done.  If an archive exists for a particular show, it 
    provides a hyperlink to that archive.  If it does not, no hyperlink is provided.

    Drop Down Menu for Show Name.  Select a show, hit submit, the webpage provides 
    you a list of all shows that correspond to that show name.  If an archive exists 
    for a particular show, it provides a hyperlink to that archive.  If it does not, 
    no hyperlink is provided.

    Calendar Widget for Date.  Select a date, hit submit, the webpage provides 
    you a list of all shows that occured on that date.  If an archive exists 
    for a particular show, it provides a hyperlink to that archive.  If it does not, 
    no hyperlink is provided.

## TO YATES
1. How long should we keep archives?
	- Forever.
2. Should we keep archives of automation?
	- No.  However, we should keep track of what was played.  
3. What should we do with incomplete archives?
	- Trash them. 
4. What should we do with archives that lack identifying information?
	- Write a script to flesh out information, but if not enough, jettison it.  
