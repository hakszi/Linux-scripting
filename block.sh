#!/bin/bash

tmp=$(mktemp)

if [[ $1 == "Mullvad" && $2 == "packets" && $3 -ge 1 && $3 -le 1000000 ]]; then
  tshark -i 3 -w $tmp -a packets:$3 2>&1 
elif [[ $1 == "Mullvad" && $2 == "duration" && $3 -ge 1 && $3 -le 3600 ]]; then 
  tshark -i 3 -w $tmp -a duration:$3
else 
  clear 
  tshark -D
  echo "--- --- --- --- --- --- --- --- "
  echo -en "Enter an interface: "
  read interface 
  while [[ ! ($interface -ge 1 && $interface -le 20) ]]; do
    echo -en "Invalid input, try again: "
    read interface
  done

  echo 
  echo "--- --- --- --- --- --- --- --- "

  echo "1. Specify number of packets to capture
2. Specify duration to capture packets"

  continue=true
  while [[ $continue == true ]]; do 
  read -p "Your choice: " type
  case "$type" in
    1)
      continue=false

      echo 
      echo "--- --- --- --- --- --- --- --- "
      echo "How many packets (max 1M)? "
      packets=0
      while [[ ! ($packets -ge 1 && $package -le 1000000) ]]; do 
        read -p "Your choice: " packets
      done
      tshark -i $interface -w $tmp -a packets:$packets 2>&1
      ;;
      2)
      continue=false
      echo 
      echo "--- --- --- --- --- --- --- --- "
      echo "How long (max 3600s)? "
      duration=0
        while [[ ! ($duration -ge 1 && $duration -le 3600) ]]; do 
          read -p "Your choice: " duration 
          tshark -i $interface -w $tmp -a duration:$duration
          start=$(date +%s)
          while true; do
            time="$(( $(date +%s) - $start))" 
            printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
            sleep 0.1 &
          done
        done
      ;;
      *) 
      ;;
    esac
  done
fi



#tshark -r $tmp -Y "dns.count.answers > 0" -T fields -e dns.qry.name -e dns.resp.name | sort -k1 | cut -f1 | awk '!seen[$0]++'
#tshark -r $tmp -Y "dns.flags.response == 1 && dns.flags.rcode == 3" -T fields -e dns.qry.name -e dns.resp.name | sort -k1 | cut -f1 | awk '!seen[$0]++'
