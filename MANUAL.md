The Computer Engineer Manual
============================

This manual contains everything that the Computer Engineer at WSBF needs to know about WSBF's computing resources.

- Getting Started
- Domains and Email Forwarding
- Hardware Infrastructure
- Files and Software Infrastructure
- Troubleshooting

## Getting Started

The role of the Computer Engineer is to maintain the station's computing resources, which include the website and studio software. Here is a reference of programming languages that are used throughout WSBF:

- [MySQL](https://dev.mysql.com): database query language
- [PHP](http://php.net/manual/en): scripting language for server-side scripts
- [HTML](https://developer.mozilla.org/en-US/docs/Web/HTML)/[CSS](https://developer.mozilla.org/en-US/docs/Web/CSS): markup and styling languages for web pages
- [Javascript](https://developer.mozilla.org/en-US/docs/Web/JavaScript): scripting language for web page logic
- [Python](https://www.python.org): scripting language used for ZAutomate

There are also some important software libraries:

- [AngularJS](https://angularjs.org) (HTML/Javascript): Web application framework
- [Bootstrap](https://getbootstrap.com) (HTML/CSS): Styling framework

Being familiar with these technologies will allow you to manage all of WSBF's software and add whatever features you want, but if you aren't familiar with all of them, don't try to learn them all at once! Study one language or library based on what you need at the time, or else you might burn out. It is possible to become skilled in all of these languages, but it takes time. Spend some time reading through WSBF's code at your leisure, seek to understand the code before you change anything.

## Domains and Email Forwarding

WSBF has two domains:

1. [wsbf.clemson.edu](wsbf.clemson.edu) is WSBF's original domain provided by Clemson University. It is managed by CCIT, so any changes to its DNS settings must be made through them. `wsbf.clemson.edu` is currently configured to redirect to `wsbf.net`.

2. [wsbf.net](wsbf.net) is WSBF's current domain. It is registered with [Namecheap](namecheap.com), along with all of its subdomains.

Subdomains (`*.wsbf.net`) are defined by A Records in the DNS settings. The following subdomains should be defined:

	dev.wsbf.net
	m.wsbf.net
	new.wsbf.net
	stream.wsbf.net

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

## Hardware Infrastructure

All of WSBF's hardware resources are located in the WSBF suite. They are listed below by IP address:

`130.127.17.2` (Paul)

Paul is a Windows server who runs an RDS program for the radio stream.

*Paul also currently has the old site for `wsbf.clemson.edu` and some other old but possibly important files that need to be sorted through.

`130.127.17.4` (George)

George is the web server. George hosts the website and runs the Apache web server and MySQL database.

`130.127.17.5` (Automatrix)

Automatrix is the Linux machine in Studio A. It runs ZAutomate, which includes Automation, the DJ Studio, and the PSA Cart.

*Automatrix normally mounts the digital library through John, but because of issues with BC_China, George currently hosts the digital library, so Automatrix mounts the library through George.

`130.127.17.6` (Transcode)

Transcode is a Linux machine currently located in Studio B. It runs DarkIce and IceCast, which provide radio streaming to the Internet at stream.wsbf.net.

`130.127.17.39` (John)

John is the archiver. John records everything that is on air (except for Automation) and writes each show to a file. John also hosts the digital library.

*Because of issues with BC_China, John currently mounts the digital library through George.

`130.127.17.40`

This machine doesn't have a name, but it is the Windows machine in Studio A. It runs the online logbook for DJs and the webcam.

Currently, the two computers in Studio A share a keyboard and mouse (probably by some kind of USB splitter magic), and they each run a program called Synergy that tracks the mouse crossing screens. Automatrix could assume the functions of this Windows machine, and remove the need for Synergy, but there is a risk that DJs browsing the Internet on Automatrix might play audio from a web page that would be inadvertently put on air.

`130.127.17.42` (Ringo)

Ringo is the database replicator... so he replicates the database. Probably need to find more about that.

*Ringo saves archives to BC_China?

__TODO__: incorporate notes from state of archiving

`130.127.17.?`

The General Manager, Music Director, and Production Director each have their own Windows machines in the WSBF suite.

__TODO__: Of course, there is more hardware involved in transmitting the audio stream from Studio A to the studio hub in Studio B and the transmitter shack on Kite Hill, but they are generally managed by the Chief Engineer. At some point the backup automation computer in the shack should be documented here.

## Files and Software Infrastructure

Within each computer there is a set of critical files and software that must be maintained. In general, these computers should be able to run the following software as long as they are using a modern version of Ubuntu.

*Any remaining Windows machines that perform back-end tasks (such as Paul) should be eventually migrated to Linux.

`130.127.17.2` (Paul)

__TODO__

`130.127.17.4` (George)

Software
- Apache 2 web server
- MySQL database
- modules for PHP with Apache and MySQL

Files

	/etc/apache2/
	├── sites-available/
	│   ├── default
	│   ├── dev.wsbf.net
	│   ├── m.wsbf.net
	│   ├── new.wsbf.net
	│   ├── wsbf.clemson.edu
	│   └── wsbf.net
	├── sites-enabled/
	│   └── ... (symlinks to files in sites-available/)
	├── apache2.conf
	└── httpd.conf

	/home/compe/
		__TODO__

	/var/www/
	├── dev/
	│   └── ... (same structure as wsbf/)
	├── mobile/
	└── wsbf/
		├── api/
		├── blog/
		└── wizbif/

__TODO__

## Troubleshooting

### Power Outages

In case of a power outages, follow these steps to the best of your ability:

1. Go to the transmitter.
2. Ensure that the transmitter and exciter are on.
3. Ensure that the transmitter computer is on. Backup automation and transmitter management software should start automatically.
4. Go to the station.
5. Restart George the Web server.
6. Restart Automatrix. When George is online, Automatrix will mount ZAutoLib through George. When Automation, DJ Studio, and Cart Machine initialize, they should be able to load tracks if ZAutoLib is mounted.
8. If the station has been down for more than 4 hours, play the Sign On cart. In DJ Studio, search "psa", it should be first on the list.
9. Start Automation.
10. Restart John. Archiving should start automatically.

### Streaming/Broadcasting Issues

At the time of writing, doing the following to the digital detangler usually restores streaming and broadcasting:

1. Go to Studio A or call the DJ on Air
2. Restart the detangler
3. Hit load once
4. Hit route twice
5. If that doesn't work, reboot Transcode
6. If that doesn't work, call Matt Rana
