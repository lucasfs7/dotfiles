#!/bin/sh

muted=$(pamixer --get-mute)
percent="$(pamixer --get-volume)%"
headphone_status=$(\
  amixer -c 0 cget numid=16,iface=CARD | \
  awk -F"=" 'NR == 3 {print $2;}'\
)
bluetooth=$(\
  pactl info | awk '/Default Sink:.+/ {print $3}' | \
  grep 'bluez'\
)

if [[ "$bluetooth" != "" ]]; then
  off_icon='﫾'
  on_icon='﫽'
elif [[ "$headphone_status" == "on" ]]; then
  off_icon='ﳌ'
  on_icon=''
else
  off_icon='婢'
  on_icon=$'墳'
fi

if [[ "$muted" == "true" ]]; then
  icon=$off_icon
else
  icon=$on_icon
fi

echo "[ $icon $percent ]"
