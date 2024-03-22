#!/bin/bash

function convertms()
{
  tmp_files=$(mktemp).

  find . -type f \( -name '*.docx' -o -name '*.doc' \) -printf %P\\n | sed -e 's/ /\\ /g' > "$tmp_files"

  while read "p"; do
      location="`readlink -f "$p" | rev | cut -d '/' -f2- | rev | sed -e 's/$/\//g'`"
      libreoffice --headless --convert-to odt "$p" --outdir "$location" | sed 's/ /\\ /g' > /dev/null 2>&1
      echo "$p -> `echo $p | cut -d . -f1 | xargs -I {} echo -n "{}.odt"`"
  done <"$tmp_files"

  

  find . -type f \( -name '*.xlsx' -o -name '*.xls' \) -printf %P\\n | sed -e 's/ /\\ /g' > "$tmp_files"

  while read "p"; do
      location="`readlink -f "$p" | rev | cut -d '/' -f2- | rev | sed -e 's/$/\//g'`"
      libreoffice --headless --convert-to ods "$p" --outdir "$location" | sed 's/ /\\ /g' > /dev/null 2>&1
      echo "$p -> `echo $p | cut -d . -f1 | xargs -I {} echo -n "{}.ods"`"
  done <"$tmp_files"



  find . -type f \( -name '*.ppt' -o -name '*.pptx' -o -name '*.pps' -o -name '*.ppsx'  \)  -printf %P\\n | sed -e 's/ /\\ /g' > "$tmp_files"

  while read "p"; do
      location="`readlink -f "$p" | rev | cut -d '/' -f2- | rev | sed -e 's/$/\//g'`"
      libreoffice --headless --convert-to odp "$p" --outdir "$location" | sed 's/ /\\ /g' > /dev/null 2>&1
      echo "$p -> `echo $p | cut -d . -f1 | xargs -I {} echo -n "{}.pdf"`"
  done <"$tmp_files"


  find . -type f \( -name '*.docx' -o -name '*.doc' -o -name '*.xlsx' -o -name '*.xls' -o -name '*.ppt' -o -name '*.pptx' -o -name '*.pps' -o -name '*.ppsx' \) -exec mv -t "/tmp/" {} + 
  
  echo "Done! Moved every MS file to /tmp/ for easier recovery."
  exiftool -r -overwrite_original -all= *

  rm $tmp_files
};
