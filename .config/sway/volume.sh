headphone_status=$(amixer -c 0 cget numid=16,iface=CARD | awk -F"=" 'NR == 3 {print $2;}')

if [[ $(amixer -M | grep 'Sudio') != "" ]]; then
  control='Sudio Regent - A2DP'
elif [[ "$headphone_status" == "on" ]]; then
  control='Headphone'
else
  control='Speaker'
fi

amixer -q set "$control" $@
