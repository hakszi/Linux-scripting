function topdf()
{
  tmp_files=$(mktemp).

  find . -type f \( -name '*.docx' -o -name '*.doc' -o -name '*.odt' -o -name '*.odp' \) -printf %P\\n | sed -e 's/ /\\ /g' > "$tmp_files"

  while read "p"; do
      location="`readlink -f "$p" | rev | cut -d '/' -f2- | rev | sed -e 's/$/\//g'`"
      libreoffice --headless --convert-to pdf "$p" --outdir "$location" | sed 's/ /\\ /g' > /dev/null 2>&1
      trash "$p"
      echo "$p -> `echo $p | cut -d . -f1 | xargs -I {} echo -n "{}.pdf"`"
  done <"$tmp_files"
};
