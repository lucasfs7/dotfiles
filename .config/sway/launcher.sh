#!/bin/bash

(cat ~/.cache/wal/sequences &)

readarray -t lines < <(echo "$(dot-desktop | fzf --print-query)")
query="${lines[0]}"
selection="${lines[1]}"

if [ "$selection" != "" ]
then
    command_str="$(dot-desktop "${selection}")"
elif [ "$query" != "" ]
then
    command_str="${query}"
else
  exit 1
fi

swaymsg -t command "exec $command_str"
exit 0
