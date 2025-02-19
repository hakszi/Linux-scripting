function jupyter-to-pdf()
{
  tmp_files=$(mktemp).

  find . -type f ! -path '*/.*' \( -name '*.ipynb' \) -printf %P\\n | sed -e 's/ /\\ /g' > "$tmp_files"
  while read "p"; do
      location="`readlink -f "$p" | rev | cut -d '/' -f2- | rev | sed -e 's/$/\//g'`"
      python3 -m nbconvert --to pdf "$p" --log-level='CRITICAL'
      echo "$p -> `echo $p | cut -d . -f1 | xargs -I {} echo -n "{}.pdf"`"
      trash "$p"
  done <"$tmp_files"
};

