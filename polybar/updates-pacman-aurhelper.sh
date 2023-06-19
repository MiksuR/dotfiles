#!/bin/sh

if [[ $(nmcli con show --active | wc -l) == 1 ]]; then
    echo "NaN"
    exit 0
fi

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$((updates_arch + updates_aur))

echo "$updates"
