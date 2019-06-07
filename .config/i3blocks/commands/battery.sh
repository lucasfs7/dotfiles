#!/bin/sh

. "$HOME/.cache/wal/colors.sh"

name=$(upower --enumerate | grep 'BAT')
state=$(upower --show-info $name | egrep "state" | awk '{print $2}')
percent=$(upower --show-info $name | egrep "percentage" | awk '{print $2}')

if [[ "$state" == "fully-charged" || "$state" == "charging" ]]; then
  icon=''
elif [[ "state" == "empty" ]]; then
  icon=''
else
  icon=''
fi

echo "[ $icon $percent ]"
echo ""
echo "$foreground"
echo "$background"
