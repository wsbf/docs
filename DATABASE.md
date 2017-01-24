The Database Reference
======================

This document defines the schema of the MySQL database and describes the purpose of each table. Table and column names are provided, and keys are marked as such. For more detailed information, such as column data types, go to http://wsbf.net/phpmyadmin/.

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
def_fishbowl_log_types

	typeID
	type
```

Contains the index and name of each fishbowl log type (Promo Table, Production, etc.).

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

__TODO__: This table could be used to normalize columns in other tables, such as `schedule.start_time` and `schedule.end_time`.

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

	fishbowlID
	timestamp
	username
	semesters
	missed_shows
	live_shows
	springfest
	specialty
	dead_hours
	other
	average
	weight
```

Contains a record of every fishbowl application for the current semester.

_Note_: the `live_shows`, `springfest`, and `other` columns are kept for reference only; the `fishbowl_log` is used instead.

```
fishbowl_log

	fishbowl_logID
	username (-> users)
	date
	log_type (-> def_fishbowl_log_types)
	description
```

Contains records of actions by users that earn fishbowl points.

```
history

	historyID
	contributor_name
	contributor_email
	contributor_website
	contributor_story
	current_location
	positions_held
	years_active
	mailing_address
```

Contains records of alumni stories, apparently added by alumni themselves.

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
libplaylist

	username
	playlist_name
	playlistID
	showID
```

Currently unused, but it could be used by users to prepare playlists for their shows.

```
libreview

	albumID
	review
	username (-> users)
	reviewer
	review_date
```

Contains records for album reviews.

_Note_: the `reviewer` column is kept for reference only; reviewer names are fetched from the `users` table.

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
```

Contains every track that is logged during shows.

_Note_: the `played` column is kept for reference only; with the current logbook, tracks are not logged until they are played.

```
password_reset

	transaction_id
	username (-> users)
	expiration_date
```

Contains records of outstanding password reset requests by users who forgot their passwords.

```
now_playing

	logbookID (-> logbook)
	lb_track_name
	lb_artist_name
```

Contains an easily accessible copy of the currently playing track.

```
schedule

	scheduleID
	show_name
	dayID (-> def_days)
	start_time
	end_time
	show_typeID (-> def_show_types)
	description
	general_genreID (-> def_general_genres)
	active
```

Contains the schedule of shows, including past shows.

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
```

Contains the hosts for every show in `show`.

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

Contains a record of every show sub request that was filled.

```
sub_request

	sub_requestID
	username (-> users)
	scheduleID (-> schedule)
	date
	posted_time
	reason
```

Contains a record of every show sub request.

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

* Profile pictures are currently located at `/wizbif/images/users/`, however it might be easier to store the image name instead of a flag.

* Currently, `username` is the primary key, which means that other tables must use usernames as foreign keys and users cannot change their username. In the future it may be a good idea to add a `userID` column and apply it throughout the database.
