#!/usr/bin/env bash

set -euo pipefail

WALL_DIR="$HOME/.config/backgrounds/"
ROFI_THEME="$HOME/.config/rofi/applets/wallSelect.rasi"
WLIST="$HOME/.cache/wlist"

if ! pgrep -x awww-daemon >/dev/null; then
	awww init &
	sleep 1
fi

find "$WALL_DIR" -maxdepth 1 -type f | sort >"$WLIST"

walList() {
	while IFS= read -r tempWal; do
		walName=$(basename "$tempWal")
		echo -en "$walName\0icon\x1f$tempWal\n"
	done <"$WLIST"
}

wallpaper=$(walList | rofi -dmenu -theme "$ROFI_THEME" -p "Wallpaper")

if [ -n "${wallpaper}" ]; then
	walPath=$(grep "$(echo ${wallpaper#[[:space:]]*})" "$WLIST")
	awww img "$walPath" --transition-type outer --transition-step 90 --transition-pos 0.854,0.977
	matugenMagick "$walPath"
	sed -i "s|^\$image = .*|\$image = $walPath|" "$HOME/.config/hypr/ui/image.conf"
fi

rm -f "$WLIST"
