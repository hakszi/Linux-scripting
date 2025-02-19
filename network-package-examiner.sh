#!/bin/bash

tmp=$(mktemp)

if [[ $1 == "" ]]; then
    interface=`tshark -D | egrep "(^| )1.( |$)" | cut -d '.' -f 2 | cut -d ' ' -f 2`
elif [[ $1 == '-h' || $1 == '--help' ]]; then
    clear
    echo "If you start this program without argument, it uses the most viable source."
    echo "You have the option to start the function with parameter -h (or --help), which gives you this guide."
    echo "You can also start the function with parameter -l (or --list), which lists the available interfaces."
    echo "This bash function catches packets for 30 seconds (can manually change this), then sorts, deduplicates them, and puts it out to the screen."

#If you run this as a function, replace "exit" with "return".
    exit
    #return
elif [[ $1 == "-l" || $1 == "--list" ]]; then
    clear
    tshark -D
    echo
    echo -n "Enter an interface: "
    read interface
else
    interface=$1
fi

#tshark -i $interface -w $tmp -a packets:2000
tshark -i $interface -w $tmp -a duration:30
tshark -r $tmp -Y "dns.count.answers > 0" -T fields -e dns.qry.name -e dns.resp.name | sort -k1 | cut -f1 | awk '!seen[$0]++'

rm $tmp
