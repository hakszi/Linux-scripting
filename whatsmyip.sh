speed=$(mktemp)
intf=$(ip a | grep " UP " | cut -d ' ' -f 2 | cut -d ':' -f 1)
localip=$(hostname -I | cut -d ' ' -f1 )
publicip=$(curl --silent --show-error https://ipinfo.io/ip 2>&1)
defaultgateway=$(ip r | grep default | cut -d ' ' -f3)
dns=$(nmcli dev show | grep 'IP4.DNS' | awk '{print $2}' | tr '\n' ' ')
mac=$(ip a | grep `hostname -I | cut -d ' ' -f1` -B 1 | grep "link/ether" | awk '{print $2}')
city=$(curl --silent --show-error https://am.i.mullvad.net/city 2>&1)
country=$(curl --silent --show-error https://am.i.mullvad.net/country 2>&1)
/usr/bin/speedtest-cli --secure --simple | tee $speed > /dev/null

echo "Interface in use: $intf"
echo "Local IP: $localip"
echo "Public IP: $publicip"
echo "Default Gateway: $defaultgateway"
echo -n "Primary & Secondary DNS (IPv4): "
  echo $dns
echo "Hardware MAC address: $mac"
echo "Location: $country, $city"
/usr/bin/cat $speed
