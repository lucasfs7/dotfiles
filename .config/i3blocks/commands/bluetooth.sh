#!/bin/sh

status=$(\
  bluetoothctl -- "show" | \
  awk '/Powered:.+/ { print $2}' | \
  sed 's/yes/on/g' | \
  sed 's/no/off/g'\
)

device_status=$(\
  bluetoothctl -- 'info' | \
  awk '/Connected:.+/ {print $2}'\
)

device_name=$(\
  bluetoothctl -- 'info' | \
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

echo "$icon $label"
