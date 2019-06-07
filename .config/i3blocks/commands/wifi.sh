#!/bin/sh

. "$HOME/.cache/wal/colors.sh"

ssid=$(iw dev wlp2s0 info | grep ssid | awk '{ print $2 }')

if [[ "$ssid" != "" ]]; then
  icon='直'
  status=$ssid
else
  icon='睊'
  status='off'
fi

echo "[ $icon $status ]"
echo ""
echo "$foreground"
echo "$background"
