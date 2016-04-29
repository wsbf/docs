The Database Reference
======================

This document defines the schema of the MySQL database and describes the purpose of each table. Table and column names are provided, and keys are marked as such. For more detailed information, such as column data types, go to [wsbf.net/phpmyadmin](http://wsbf.net/phpmyadmin).

TODO: convert collation of databases, tables, and columns to `utf8_general_ci`.

Currently unused tables:
```
history
intern_list
libplaylist
likes
mailing_list
office_hours
```

## Tables

```
def_airability

	airabilityID
	airability
```

Contains the index and name of each airability status, which is used for tracks in the music library.

```
def_cart_type

	cart_typeID
	type
```

Contains the index and name of each cart type (PSA, station ID, etc.).

```
def_days

	dayID
	day
```

Contains the index and name of each day of the week.

```
def_general_genres

	general_genreID
	genre
```

Contains the index and name of each general genre.

```
def_mediums

	mediumID
	medium
```

Contains the index and name of each album medium (CD, Vinyl, etc.).

```
def_positions

	positionID
	position
	description
```

Contains the index, name, and description of each staff position.

```
def_rotations

	rotationID
	rotation_bin
	binAbbr
```

Contains the index, name, and abbreviation of each rotation bin in the music library.

```
def_show_times

	show_timeID
	show_time
```

Contains the index and name of each show time in the schedule.

* This table could be used to normalize columns in other tables, such as `schedule.start_time` and `schedule.end_time`.

```
def_show_types

	show_typeID
	type
```

Contains the index and name of each show type (Rotation, Specialty, etc.)

```
def_status

	statusID
	status
```

Contains the index and name of each user status (Active, Suspended, etc.)

```
def_teams

	teamID
	team
```

Contains the index and name of each team (Red, Blue, etc.)

```
fishbowl

	id
	timestamp
	username
	semesters
	missedShows
	liveShows
	springFest
	specialty
	dead_hours
	other
	average
	weight
```

Contains a record of every fishbowl application for the current semester.

* Some columns could be computed from other tables:

* `semesters` from the `schedule` and `schedule_hosts` tables
* `missedShows` from the `show` and `show_host` tables
* `dead_hours` from the `schedule` and `schedule_hosts` tables

* Some column names use camelCase, which is inconsistent with the rest of the database.

```
fishbowl_log

	id
	timestamp
	username
	semesters
	missedShows
	liveShows
	springFest
	specialty
	dead_hours
	other
	average
	weight
```

Contains a record of every fishbowl application from previous semesters (exact same structure as `fishbowl`).

* `fishbowl` and `fishbowl_log` could be merged into one table with a `current` column to distinguish records for the current semester, as in the `schedule` table.

```
libaction

	actionID
	username (-> users)
	time
	change_description
```

Contains records for actions related to the music library, which seem to include the following actions:

- SUBMITTED REVIEW FOR album
- EDITED REVIEW FOR album
- INSERTED or UPDATED tracks for album (probably an obsolete message)
- INSERTED tracks for new album
- UPDATED tracks for existing album

```
libalbum

	albumID
	album_name
	num_discs
	album_code
	artistID (-> libartist)
	labelID (-> liblabel)
	mediumID (-> def_mediums)
	genre
	general_genreID (-> def_general_genres)
	rotationID (-> def_rotations)
```

Contains records for every album in the music library.

```
libartist

	artistID
	artist_name
```

Contains records for every artist in the music library.

```
libcart

	cartID
	start_date
	end_date
	play_mask
	issuer
	title
	cart_typeID (-> def_cart_type)
	filename
```

Contains records for items in the cart (PSAs, station IDs, etc.).

```
liblabel

	labelID
	label
```

Contains records for every music label in the music library.

```
libreview

	albumID
	review
	username (-> users)
	reviewer
	review_date
```

Contains records for album reviews.

* The `reviewer` column may be redundant since `users.preferred_name` could be used instead.

```
libtrack

	albumID (-> libalbum)
	disc_num
	track_num
	track_name
	artistID (-> libartist)
	airabilityID (-> def_airability)
	file_name
```

Contains records for every track in the music library. Every track should belong to an album in `libalbum`.

```
logbook

	logbookID
	showID (-> show)
	lb_album_code
	lb_rotation
	lb_track_num
	lb_track_name
	lb_artist
	lb_album
	lb_label
	time_played
	played
	deleted
```

Contains every track that is logged from the online logbook.

* Currently there are no records with `deleted=1`. Was a delete option intended for the online logbook? Who knows.
* The logbook could be designed such that `played` and `deleted` are not needed. Just have the logbook REPLACE when a track is played.

```
password_reset

	transaction_id
	username (-> users)
	expiration_date
```

Contains records of outstanding password reset requests by users who forgot their passwords.

* Currently there is a web interface to reset a user's password, but the computer engineer must email the URL to the user.

```
now_playing

	logbookID
	lb_track_name
	lb_artist_name
```

Contains the logbook index of the currently playing track.

* The other two columns may be redundant if the record is joined with columns in the logbook. Since this table seems to only ever have one row, it makes little difference.

```
schedule

	scheduleID
	show_name
	dayID (-> def_days)
	start_time
	end_time
	show_typeID (-> def_show_types)
	description
	genre
	active
```

Contains the schedule of shows, including past shows.

* Genre names are stored instead of genre IDs, so there is an opportunity here for normalization. Also, they are actually general genres.

```
schedule_hosts

	scheduleID (-> scheduleID)
	username (-> users)
	schedule_alias
```

Contains the hosts for every show in `schedule`.

```
show

	showID
	start_time
	end_time
	show_name
	show_typeID (-> def_show_types)
	scheduleID (-> schedule)
	max_listeners
```

Contains a record of every show that has been logged in the logbook.

* `show_name` is already stored in `schedule`, so it could be removed. However, a DJ may want to be able to have show-specific names.
* `show_typeID` is already stored is `schedule`, but not all shows have a `scheduleID`.

```
show_hosts

	showID (-> show)
	username (-> users)
	show_alias
```

Contains the hosts for every show in `show`.

* `show_alias` is already stored in `schedule_hosts`, so it could be removed.

```
staff

	positionID (-> def_positions)
	username (-> users)
	start_date
	end_date
```

Contains indexes and start/end dates for senior staff since ~2009.

```
sub_fill

	sub_requestID (-> sub_request)
	username (-> users)
```

Contains a record for every show sub request that was filled.

```
sub_request

	sub_requestID
	username (-> users)
	* dayID (-> def_days)
	* start_time
	* end_time
	date
	posted_time
	reason
	* show_name
	* show_typeID (-> def_show_types)
```

Contains a record of every show sub request ever submitted.

* The columns marked with an asterisk could be replaced with scheduleID.

```
users

	username
	password
	first_name
	last_name
	preferred_name
	email_addr
	teamID (-> def_teams)
	statusID (-> def_status)
	profile_paragraph
	has_picture
```

Contains a record for every WSBF user.

* Profile pictures are stored in `/var/www/wizbif/profiles`

* Currently, `username` is the primary key, which means that other tables must use usernames as foreign keys and users cannot change their username. In the future it may be a good idea to add a `userID` column and apply it throughout the database.
