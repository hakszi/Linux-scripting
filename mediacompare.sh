#!/bin/bash

files=($(find . -maxdepth 1 -type f))
tmp=$(mktemp)

counter=0
for i in "${files[@]}"
do
    if duration=$(mediainfo --Inform="Video;%Duration%" "$i" 2>/dev/null | cut -d '.' -f1); then
      if [[ "$duration" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
        echo -n "$duration    " >> $tmp
        echo "$i" | cut -d '/' -f2- >> $tmp
        ((counter++))
      fi
    fi
done

sort -hr $tmp 

echo 
echo "-------------- duplicates --------------"
echo

sort -k1,1 -hr $tmp | awk '
  {
    if (seen[$1]) {
      duplicates[$1] = duplicates[$1] " " $2
    } else {
      seen[$1] = 1
      duplicates[$1] = $2
    }
  }
  END {
    for (duration in duplicates) {
      if (split(duplicates[duration], files) > 1) {
        printf "%s", duration
        for (i in files) {
          printf " %s", files[i]
        }
        printf "\n"
      }
    }
  }
'
rm $tmp
