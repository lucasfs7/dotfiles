#!/bin/sh

. "$HOME/.cache/wal/colors.sh"

status=$(\
  bluetooth | \
  awk '{print $3}'
)

device=$(\
  echo -e 'devices' | \
  bluetoothctl | \
  awk '/Device.+/ { print $2}'\
)

device_status=$(\
  echo -e "info $device" | \
  bluetoothctl | \
  awk '/Connected:.+/ {print $2}'\
)

device_name=$(\
  echo -e "info $device" | \
  bluetoothctl | \
  awk '/Name:*/ {$1=""; print $0}' | \
  sed -e 's/^[[:space:]]*//'
)

if [[ "$status" == "off" ]]; then
  icon=''
  label=$status
elif [[ "$device_status" == "yes" ]]; then
  icon=''
  label=$device_name
else
  icon=''
  label=$status
fi

echo "[ $icon $label ]"
echo ""
echo "$foreground"
echo "$background"
