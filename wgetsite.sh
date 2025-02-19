function wgetsite()
{
  sudo wget -r -nH --cut-dirs=2 --no-parent --reject="index.html*" $1 
  sudo chown -R $USER:$USER ./*
};

