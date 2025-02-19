#!/bin/bash

files=($(find . -maxdepth 1 -type f))
tmp=$(mktemp)

clear
counter=0
sum=0

for i in "${files[@]}"
do
    if duration=$(mediainfo --Inform="Video;%Duration%" "$i" 2>/dev/null | cut -d '.' -f1); then
        sum=$((duration + sum))
        echo "$i" | cut -d '/' -f2- >> $tmp
        ((counter++))
    fi
done

total_seconds=$((sum / 1000))
hour=$((total_seconds / 3600))
minute=$(((total_seconds % 3600) / 60))
second=$((total_seconds % 60))

echo "$hour:$(printf "%02d" $minute):$(printf "%02d" $second)"

rm $tmp
