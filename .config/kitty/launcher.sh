#!/bin/bash

selection="$(dot-desktop | fzf --print-query | sed '/^[[:space:]]*$/d')"

if [ "$selection" != "" ]
then
    command_str="$(dot-desktop "${selection}")"

    if [ "$command_str" == "" ]
    then
        # No desktop file matched, raw command line
        command_str="${selection}"
    fi

    swaymsg -t command "exec $command_str"

    exit 0
fi

exit 1
