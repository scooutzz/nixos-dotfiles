#!/usr/bin/env bash

set -euo pipefail

export PATH="$HOME/.local/share/relaxou/bin:$PATH"

# Rofi Theme
THEME="${HOME}/.config/rofi/applets/menu.rasi"

if pidof rofi >/dev/null; then
	pkill rofi
fi

BACK_TO_EXIT=false

menu() {
	local prompt="$1"
	local options="$2"
	local extra="${3:-}"
	local preselect="${4:-}"

	local -a args=(-i -dmenu -p "$prompt" -theme "$THEME" -kb-custom-1 "Alt-Left")

	if [[ "$extra" =~ -w[[:space:]]+([0-9]+) ]]; then
		local w="${BASH_REMATCH[1]}"
		args+=(-theme-str "window { width: ${w}px; }")
	fi

	if [[ -n "$preselect" ]]; then
		local idx
		idx=$(printf "%b" "$options" | grep -nxF "$preselect" | cut -d: -f1 || true)
		if [[ -n "${idx:-}" ]]; then
			args+=(-selected-row "$((idx - 1))")
		fi
	fi

	local selection
	selection="$(printf "%b" "$options" | rofi "${args[@]}")"
	local code=$?

	case "$code" in
	0)
		printf '%s' "$selection"
		return 0
		;;
	1)
		printf '%s' "CNCLD"
		return 1
		;;
	10)
		printf '%s' "BACK"
		return 10
		;;
	*)
		printf '%s' "CNCLD"
		return "$code"
		;;
	esac
}

terminal() {
	kitty -e --class=relaxou "$@"
}

present_terminal() {
	launch-floating-terminal-with-presentation "$1"
}

install() {
	present_terminal "echo 'Installing $1...'; sudo pacman -S --noconfirm $2"
}

install_and_launch() {
	present_terminal "echo 'Installing $1...'; sudo pacman -S --noconfirm $2 && setsid gtk-launch $3"
}

aur_install() {
	present_terminal "echo 'Installing $1 from AUR...'; yay -S --noconfirm $2"
}

aur_install_and_launch() {
	present_terminal "echo 'Installing $1 from AUR...'; yay -S --noconfirm $2 && setsid gtk-launch $3"
}

back_to() {
	local parent_menu="${1:-}"
	if [[ "$BACK_TO_EXIT" == "true" ]]; then
		exit 0
	elif [[ -n "$parent_menu" ]]; then
		"$parent_menu"
	else
		show_main_menu
	fi
}

show_main_menu() {
	local sel
	sel="$(menu "Go" $'󰉉 Install\n󰭌  Remove\n  Themes\n  About')" || true

	case "${sel,,}" in
	*install*) show_install_menu ;;
	*remove*) show_remove_menu ;;
	*themes*) show_theme_switcher_menu ;;
	*about*) launch-about ;;
	cncld | back | "")
		exit 0
		;;
	*)
		show_main_menu
		;;
	esac
}

show_install_menu() {
	local sel
	sel="$(menu "Install" $'󰣇  Package\n󰣇  AUR\n  Web App\n  TUI\n  Style')" || true

	case "$sel" in
	*Package*) terminal pkg-install ;;
	*AUR*) terminal pkg-aur-install ;;
	*Web*) present_terminal webapp-install ;;
	*TUI*) present_terminal tui-install ;;
	*Style*) show_install_style_menu ;;
	CNCLD | BACK | "") back_to show_main_menu ;;
	*) show_install_menu ;;
	esac
}

show_remove_menu() {
	local sel
	sel=$(menu "Remove" "󰣇  Package\n  Web App\n  TUI")

	case "$sel" in
	*Package*) terminal pkg-remove ;;
	*Web*) present_terminal webapp-remove ;;
	*TUI*) present_terminal tui-remove ;;
	*) show_main_menu ;;
	esac
}

show_install_style_menu() {
	local sel
	sel="$(menu "Install" $'󰸌  Theme\n  Background\n  Font')" || true

	case "$sel" in
	*Theme*) present_terminal omarchy-theme-install ;;
	*Background*) nautilus ~/.config/backgrounds ;;
	CNCLD | BACK | "") show_install_menu ;;
	*) show_install_style_menu ;;
	esac
}

show_theme_switcher_menu() {
	local sel
	sel="$(menu "Switch Theme" $'󰸌 Rosé Pine\n󰸌 Tokyo Night\n󰸌 Catppuccin\n󰸌 Gruvbox\n󰸌 Everforest\n󰸌 Nord')" || true

	case "${sel,,}" in
	*rosé*) change_theme 'rose-pine' ;;
	*tokyo*) change_theme 'tokyo-night' ;;
	*catppuccin*) change_theme 'catppuccin-mocha' ;;
	*gruvbox*) change_theme 'gruvbox' ;;
	*everforest*) change_theme 'everforest' ;;
	*nord*) change_theme 'nord' ;;
	cncld | back | "")
		back_to show_main_menu
		;;
	*)
		show_theme_switcher_menu
		;;
	esac
}

change_theme() {
	theme-switcher "$1"
}

go_to_menu() {
	case "${1,,}" in
	*install*) show_install_menu ;;
	*remove*) show_remove_menu ;;
	*themes*) show_theme_switcher_menu ;;
	*apps* | *learn* | *trigger* | *style* | *setup* | *update* | *about* | *system*)
		show_main_menu
		;;
	*) show_main_menu ;;
	esac
}

if [[ -n "${1:-}" ]]; then
	BACK_TO_EXIT=true
	go_to_menu "$1"
else
	show_main_menu
fi
