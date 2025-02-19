function sendfile()
{
	if [ -n $1 ] ; then
		nc -Nlp 3333 < $1
	else echo "'$1' no paramteters given!";fi
};


function receivefile()
{
	if [ -n $1 ] ; then
		nc -lp 3333 > $1
	else echo "'$1' no paramteters given!";fi
};

