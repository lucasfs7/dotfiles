#date and time
time=$(date +"%a / %b %d / %I:%M %p")

# battery status
bat_name=$(upower --enumerate | grep 'BAT')
bat_state=$(upower --show-info $bat_name | egrep "state" | awk '{print $2}')
bat_percent=$(upower --show-info $bat_name | egrep "percentage" | awk '{print $2}')

if [[ "$bat_state" == "fully-charged" || "$bat_state" == "charging" ]]; then
  bat_icon=''
elif [[ "bat_state" == "empty" ]]; then
  bat_icon=''
else
  bat_icon=''
fi

bat="$bat_icon $bat_percent"

# volume status
audio_volume_headphone_status=$(\
  amixer -c 0 cget numid=16,iface=CARD | \
  awk -F"=" 'NR == 3 {print $2;}'\
)

if [[ $(amixer -M | grep 'Sudio') != "" ]]; then
  audio_volume_control='Sudio Regent - A2DP'
  audio_volume_off_icon='﫾'
  audio_volume_on_icon='﫽'
elif [[ "$audio_volume_headphone_status" == "on" ]]; then
  audio_volume_control='Headphone'
  audio_volume_off_icon='ﳌ'
  audio_volume_on_icon=''
else
  audio_volume_control='Speaker'
  audio_volume_off_icon='婢'
  audio_volume_on_icon=$'墳'
fi

audio_volume_control_status=$(\
  amixer -M get "$audio_volume_control" | \
  awk '/Front Left:.+/ {print $NF}' | \
  tr -d '[]'\
)

if [[ "$audio_volume_control_status" == "off" ]]; then
  audio_volume_icon=$audio_volume_off_icon
else
  audio_volume_icon=$audio_volume_on_icon
fi

audio_volume_percent=$(\
  amixer -M get "$audio_volume_control" | \
  awk '/Front Left:.+/ {print $5}' | \
  tr -d '[]'\
)

audio_volume="$audio_volume_icon $audio_volume_percent"

# network status
network_ssid=$(iw dev wlp2s0 info | grep ssid | awk '{ print $2 }')

if [[ "$network_ssid" != "" ]]; then
  network_icon='直'
  network_status=$network_ssid
else
  network_icon='睊'
  network_status='off'
fi

network="$network_icon $network_status"

# print full status
# printf " [0;31;47m %b [0m" "$audio_volume" "$network" "$bat" "$time"
printf " [ %b ]" "$audio_volume" "$network" "$bat" "$time"
