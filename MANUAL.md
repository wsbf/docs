The Computer Engineer Manual
============================

This manual contains everything that the Computer Engineer at WSBF needs to know about WSBF's computing resources.

- Getting Started
- Domains and Email Forwarding
- Firewall
- Hardware Infrastructure
- Files and Software Infrastructure
- Miscellaneous Tasks
- Troubleshooting

## Getting Started

The role of the Computer Engineer is to maintain the station's computing resources, which include the website and studio software. The computer engineer should be able to work with remote file systems (Secure Shell), databases, and websites. Contact the previous engineer for password information.

Here is a reference of programming languages that are used throughout WSBF:

- [Bash](https://www.gnu.org/software/bash/): scripting language for the Unix shell
- [MySQL](https://dev.mysql.com): database query language
- [PHP](http://php.net/manual/en): scripting language for server-side scripts
- [HTML](https://developer.mozilla.org/en-US/docs/Web/HTML)/[CSS](https://developer.mozilla.org/en-US/docs/Web/CSS): markup and styling languages for web pages
- [Javascript](https://developer.mozilla.org/en-US/docs/Web/JavaScript): scripting language for web page logic
- [Python](https://www.python.org): scripting language used for ZAutomate

There are also some important software libraries:

- [AngularJS](https://angularjs.org) (HTML/Javascript): Web application framework
- [Bootstrap](https://getbootstrap.com) (HTML/CSS): Styling framework

Being familiar with these technologies will allow you to manage all of WSBF's software and add whatever features you want, but if you aren't familiar with all of them, don't try to learn them all at once! Study one language or library based on what you need at the time, or else you might burn out. It is possible to become skilled in all of these languages, but it takes time. Spend some time reading through WSBF's code at your leisure, and seek to understand the code before you change anything.

#### WARNING

WSBF operates under the jurisdiction of Clemson University and the FCC, so it is important that WSBF is not a liability to these parties. __Placing lewd or vulgar content on the website may prompt severe punishment from the Clemson Board of Trustees or the FCC.__

## Domains and Email Forwarding

WSBF has two domains:

1. [wsbf.clemson.edu](wsbf.clemson.edu) is WSBF's original domain provided by Clemson University. It is managed by CCIT, so any changes to its DNS settings must be made through them. `wsbf.clemson.edu` is currently configured to redirect to `wsbf.net`.

2. [wsbf.net](wsbf.net) is WSBF's current domain. It is registered with [Namecheap](namecheap.com), along with all of its subdomains.

The following sub-domains should be defined in the DNS settings:

	dev.wsbf.net
	m.wsbf.net
	new.wsbf.net
	www.wsbf.net

Namecheap also provides email forwarding from `*@wsbf.net` to the personal emails of senior staff. Consequently, these email forwarding rules must be updated whenever staff changes.

The following senior staff emails should always be set:

	announcer@wsbf.net
	chief@wsbf.net
	computer@wsbf.net
	events@wsbf.net
	gm@wsbf.net
	member@wsbf.net
	music@wsbf.net
	production@wsbf.net
	promo@wsbf.net

In addition, other staff positions may be set when they are filled:

	equipment@wsbf.net
	jazz@wsbf.net
	hiphop@wsbf.net
	history@wsbf.net
	loudrock@wsbf.net
	news@wsbf.net
	rpm@wsbf.net
	world@wsbf.net

In addition, every staff member should be able to send mail from their wsbf email address. This is done in Gmail by going to `Settings -> Accounts and Import -> Send mail as -> Add another email address you own`.

TODO: include information on smtp.gmail.com hack.

## Firewall

Since WSBF's computing infrastructure exists on Clemson University's `130.127` network, WSBF computers are subject to the campus firewall, which allows outgoing traffic but blocks unrequested incoming traffic. CCIT maintains a list of exceptions for WSBF computers. The following ports should be allowed to receive incoming traffic:

	wsbf.net:80 (http)
	wsbf.net:443 (https)

All other ports on all WSBF computers should be kept in the default firewall policy. The above exceptions essentially mean that the web server should be allowed to serve content and the audio stream to the Internet. Use the Clemson VPN to access other services such as SSH from off-campus.

## Hardware Infrastructure

All of WSBF's hardware resources are located in the WSBF suite. They are listed below by IP address:

### 130.127.17.2 (Paul)

Paul is a Windows server who runs an RDS program for the radio stream.

* Paul also currently has the old site for `wsbf.clemson.edu` and some other old but possibly important files that need to be sorted through.

### 130.127.17.4 (George)

George is the web server. George runs the Apache web server, the MySQL database, and Icecast, which serves the audio stream from Transcode. George mounts ZAutoLib through John, and also hosts RIPPED_MUSIC with Samba, so that albums and carts can be transferred remotely.

### 130.127.17.5 (Automatrix)

Automatrix is the Linux machine in Studio A. It runs ZAutomate, which includes Automation, the DJ Studio, and the Cart Machine. Automatrix mounts ZAutoLib through John.

### 130.127.17.6 (Transcode)

Transcode is a Linux machine currently located in Studio B. It runs Darkice, which digitizes and streams the audio signal from Studio A to the web server.

### 130.127.17.39 (John)

John is the archiver. John records everything that is on air and writes each show to a file. John also mounts ZAutoLib (the music library).

### 130.127.17.40

This machine doesn't have a name, but it is the Windows machine in Studio A. It runs the online logbook for DJs and the webcam.

Currently, the two computers in Studio A share a keyboard and mouse (probably by some kind of USB splitter magic), and they each run a program called Synergy that tracks the mouse crossing screens. Automatrix could assume the functions of this Windows machine, and remove the need for Synergy, but there is a risk that DJs browsing the Internet on Automatrix might play audio from a web page that would be inadvertently put on air.

### 130.127.17.42 (Ringo)

Ringo is the replication slave for the MySQL database on George. Ringo runs a copy of the database and updates it whenever the master database updates. Ringo also creates periodic backups of the database with `automysqlbackup`.

__TODO__: Of course, there is more hardware involved in transmitting the audio stream from Studio A to the studio hub in Studio B and the transmitter shack on Kite Hill, but they are generally managed by the Chief Engineer. At some point the backup automation computer in the shack should be documented here.

## Files and Software Infrastructure

Within each computer there is a set of critical files and software that must be maintained. In general, these computers should be able to run the following software as long as they are using a modern version of Ubuntu.

### 130.127.17.4 (George)

Software

	apache2
	icecast2
	letsencrypt
	mysql
	php5
	phpmyadmin
	samba

Files

	/etc/
	├── apache2/
	│   ├── sites-available/
	│   │   ├── 000-default
	│   │   ├── dev.wsbf.net
	│   │   ├── new.wsbf.net
	│   │   ├── wsbf.clemson.edu
	│   │   └── wsbf.net
	│   ├── sites-enabled/
	│   │   └── ... (symlinks to files in sites-available/)
	│   └── apache2.conf
	├── php5/apache2/
	│   └── php.ini
	└── samba/
	    └── smb.conf

	/home/compe/
	├── certbot-auto
	└── RIPPED_MUSIC/
		├── albums/
		└── carts/

	/var/www/
	├── blog/
	├── camera/
	├── wsbf/
	└── ZAutoLib/

### 130.127.17.5 (Automatrix)

Software

	ZAutomate

Files

	/hompe/compe/
	└── zautomate

	/hompe/dj/Desktop/
	└── (shortcut to start ZAutomate)

### 130.127.17.6 (Transcode)

Software

	darkice

Files

	/home/compe/
	├── darkice.cfg
	└── README.txt

	/usr/local/bin/
	└── darkice_start_on_boot.sh

### 130.127.17.39 (John)

Software

	samba
	streamripper

Files

	/etc/samba/
	└── smb.conf

	/usr/local/bin/
	└── streamripper_start_on_boot.sh

### 130.127.17.42 (Ringo)

Software

	automysqlbackup
	mysql

Files

	/etc/defaults
	└── automysqlbackup

## Miscellaneous Tasks

### Operating the Fishbowl

The senior staff use the "fishbowl" at the start of each semester to prioritize DJs by quality, so that the best DJs receive the best schedule options for the semester.

1. Archive the fishbowl. The `fishbowl` table is copied to `fishbowl_log` and then cleared.
2. Open the fishbowl config file at `/var/www/wsbf/wizbif/api/fishbowl/config.php` and set the semester (`SPRING` or `FALL`), the start date for counting CD reviews, and the deadline for DJs to submit their fishbowl application. Make sure that the deadline is before the senior staff meeting on the night of show picks.
3. Notify all active DJs that they are required to fill out their applications by the deadline.
4. After the deadline, let the senior staff rate each of the applications.
5. Print the results of the fishbowl. The first bowl contains the highest-rated DJs, and so on. The order within each fishbowl is random.

### Adding Carts to the Cart Machine

DJs use the "cart machine" to play station IDs, public service announcements, underwritings, and other non-musical audio clips.

1. Make sure that the audio file is an MP3. Use an application like `ffmpeg` or a website like [media.io](http://media.io) to convert files.
2. Move the audio file into `/var/www/wizbif/ZAutoLib/carts/` on George.
3. Log in to [phpmyadmin](https://wsbf.net/phpmyadmin/), select the `def_cart_type` table, and find the `cart_typeID` of the audio file.
4. Select the `libcart` table and insert a new record. Select the start and end dates to air the PSA, the `cart_typeID`, the title, and the filename. Leave any other fields blank. Use the existing records to guide your choices.
5. Reload the Cart Machine in Studio A and confirm that the new cart appears.
6. If the new cart is an underwriting, leave a note on the main desk in Studio A to tell DJs how often to play the underwriting.

### Resetting Account Passwords

The current website doesn't have an automated way for users to reset their own passwords if they forget, so the computer engineer must do a few things manually.

1. When someone requests a password reset, they should email after they submit the request.
2. Go to the `password_reset` table and find the user's transaction.
3. Email the user with a link to the password reset page. This link should have the form `https://wsbf.net/login/#/reset-password/[transaction id]`. Warn the user that the link will eventually expire.

## Troubleshooting

Here are some solutions to common problems that have occurred before. In general, if you can't solve a problem, contact a former computer engineer. Some former engineers are listed here with most recent first:

- Ben Shealy `bentshermann@gmail.com`
* Yates Monteith `jymonte@g.clemson.edu`
* David Cohen `dcohenii@gmail.com`
* Zach Musgrave `zmusgrave@gmail.com`

### Power Outages

In case of a power outages, follow these steps to the best of your ability:

1. Go to the transmitter.
2. Ensure that the transmitter and exciter are on.
3. Ensure that the transmitter computer is on. Backup automation and transmitter management software should start automatically.
4. Go to the station.
5. Turn on all of the "Program 1" buttons on the sound board. Every single one of them.
6. Restart John. John mounts ZAutoLib, so ensure that ZAutoLib is on also. (Archiving should start automatically)
7. Restart George the Web server.
8. Restart Automatrix. Automatrix will mount ZAutoLib through John. When Automation, DJ Studio, and Cart Machine initialize, they should be able to load tracks if ZAutoLib is mounted.
9. If the station has been down for more than 4 hours, play the Sign On cart. In DJ Studio, search "psa", it should be first on the list.
10. Start Automation.
