#date and time
time=$(date +"%a / %b %d / %I:%M %p")

# battery status
bat_name=$(upower --enumerate | grep 'BAT')
bat_state=$(upower --show-info $bat_name | egrep "state" | awk '{print $2}')
bat_percent=$(upower --show-info $bat_name | egrep "percentage" | awk '{print $2}')

if [[ "$bat_state" == "fully-charged" || "$bat_state" == "charging" ]]; then
  bat_icon=$'\uf583'
elif [[ "bat_state" == "empty" ]]; then
  bat_icon=$'\uf579'
else
  bat_icon=$'\uf57d'
fi

bat="$bat_icon $bat_percent"

# volume status
audio_volume_status=$(amixer -M get Master | awk '/Mono.+/ {print $6}')
audio_volume_percent=$(amixer -M get Master | awk '/Mono.+/ {print $4}' | tr -d [])

if [[ "$audio_volume_status" == "[off]" || "$audio_volume_percent" == "0%" ]]; then
  audio_volume_icon=$'\ufa80'
else
  audio_volume_icon=$'\ufa7d'
fi

audio_volume="$audio_volume_icon $audio_volume_percent"

# network status
network_ssid=$(iw dev wlp2s0 info | grep ssid | awk '{ print $2 }')

if [[ "$network_ssid" != "" ]]; then
  network_icon=$'\ufaa8'
else
  network_icon=$'\ufaa9'
  network_status='off'
fi

network="$network_icon $network_ssid$network_status"

# print full status
printf " { %b }" "$audio_volume" "$network" "$bat" "$time"
