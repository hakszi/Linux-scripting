# dns-block-analyzer
	- captures a specified ammount of packages (or for a duration), and evaluates what DNS addresses have been blocked
	- use: debug purposes, when a service / website doesn't work, and need to diagnose.
	- note: to be run with elevated privileges (sudo)!
	- dependencies: tshark



# convertms
	- recursively finds and converts all files with microsoft extensions to opendocument extensions inside the current folder where the script is run, and recursively in all folders below.
	- conversion:
		- .docx/doc -> .odt
		- .xslx/xls -> .ods
		- .ppt/pptx/pps/ppsx -> odp
	- note: it doesn't overwrite the files, but copies them, renames the copy, and trashes the original file, thus making it recoverable.
	- dependencies: libreoffice



# network package examiner
	- captures network packages for 30 sec, sorts, formats, deduplicates them, and prints them on the console.
	- note: run with "-l" flag to choose interface, and "-h" for detailed description. By default it'll choose the first available interface.
	- note: to be run with elevated privileges (sudo)!
	- dependencies: tshark


# jupyter to pdf
	- converts all and every .ipynb extensioned jupyter files to PDF files, while tries to keep the page's style intact
	- dependencies: python3



# media compare
	- in the current folder finds every video/audio file's lengths, compares them and sorts them accordingly
	- use: some video/audio files are the exact same, but for some reason (like compression) have different sizes and hashes (which this script utiilizies)
	- dependencies: mediainfo



# sendfile & receivefile
	- send and receive (via netcat) functions intended to be put into .bashrc or .zshrc files
	- use: quick file transfer between virtual machines is it's main task, but can also be used for P2P file sharing via the internet.	
	- dependencies: netcat


# topdf function
	- converts every document file (docx, doc, odt) and PPT file (odp) to pdf. Inteded to complement previous "convertms" script.
	- dependencies: libreoffice


# watch
	- evaluates how much time it is to watch all the video / audio files in the current folder
 	- dependencies: mediainfo


# wgetsize function
	- downloads a whole FTP server without annoyances.



# whatsmyip
	- provides various network informations, namely:
		- speed
		- interface name
		- local ip
		- public ip
		- default gateway address
		- dns address
		- mac address
		- location (country, city)
		- network speed
	- based on mullvad's and ipinfo's services, can be changed to other sites.
	- dependencies: speedtest-cli, 
