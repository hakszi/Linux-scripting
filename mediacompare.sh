#!/bin/bash

files=()
while IFS= read -r -d $'\0' file; do
    files+=("$file")
done < <(find . -maxdepth 1 -type f -print0)

tmp=$(mktemp)

if [[ -z "$1" ]]; then
    read -p "What extensions are your videos? " format
else
    format=$1
fi
clear
counter=0
for i in "${files[@]}"
do
    if [[ "${i##*.}" == "$format" ]];then
        duration=$(mediainfo --Inform="Video;%Duration%" "$i" | cut -d '.' -f1)
        echo -n "$duration    " >> $tmp
        echo "$i" | cut -d '/' -f2- >> $tmp
        ((counter++))
    fi
done
if [[ $counter == 0 ]]; then
    echo "Sorry, nothing was found with the extension of \"$format\"." >&2
else
    sort -hr $tmp
fi

rm $tmp

