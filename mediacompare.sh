#!/bin/bash

## USE:
	# Compare video file's length of the same (asked) extension. 
## USEFUL WHEN:
	# Need to compare duplicated video files that fail hash check.


files=`ls ./*`
tmp=/tmp/tmpMEDIA

if [[ ! -e $tmp ]]; then
    touch $tmp
else
    rm -f $tmp
fi


if [[ $1 == "" ]]; then
    read -p "What extensions are your videos? " format
else
    format=$1
fi
clear
counter=0
for i in $files
do
    if [[ `echo $i | rev | cut -d '.' -f 1 | rev` == $format ]];then
        echo -n `mediainfo --Inform="Video;%Duration%" "$i"` " " >> $tmp
        echo `echo $i | cut -d '/' -f 2` >> $tmp
        counter+=1
    fi
done
if [[ $counter == 0 ]]; then
    echo "Sorry, nothing was found with the extension of \"$format\"."
else
    sort -shr $tmp
fi
