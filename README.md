Linux scripts I wrote for myself to save some time & solve various problem, to learn and because I love CLI. Sharing this on here, as this may solve someone's problem, or save some time.
	
What each of the scripts do:
# Easy-CLI-Wireshark.sh
CLI DNS capture tool
Using tshark, this function captures DNS queries for 30 sec, then sorts, formats, deduplicates, and outputs them.
Could be edited to capture a number of packets before ending it, increase / decreasing the time, or also to change the output format.
### - Dependency: tshark


# block.sh
CLI Wireshark to check blocked DNS addresses
Using tshark capture & filter for blocked dns addresses. Could be useful when blocking something on network level, and not on the computer itself, and need to diagnose.
### - Dependency: tshark


# convertms.sh
Convert Microsoft files to OpenDocument format
Find all files, also recursively inside folders and subfolders, and convert:
- .docx/doc -> .odt
- .xslx/xls -> .ods
- .ppt/pptx/pps/ppsx -> odp

### For ease, it doesn't deletes them, just moves them to /tmp/, so it can be easily recovered. It could be relatively easily converted to also converting them to .pdf, for whoever needs that.

### - Dependency: libreoffice, sed, find, exiftool

# mediacompare.sh
Compare media files based on their length
### Usecase: find duplicate video/audio files that have different hashes for some reason (yeah, I wrote it for this specifically). Couldn't figure out how to solve without asking the user to enter the extensions, but that's fine I guess.

### - Dependency: mediainfo



# whatsmyip.sh
Convenient what's my ip script without having to use the browser.
Provides information of:
- interface
- local ip
- public ip
- default gateway
- primary DNS (ipv4 only)
- secondary DNS (ipv4 only)
- mac address
- ip location

The script utilizies "https://am.i.mullvad.net" online services for location information, and "https://ipinfo.io" for public ip. There were other ways, but comparing time required and convenience, this was much more worth it.

### - Dependency: curl, grep
