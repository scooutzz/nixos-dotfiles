#!/usr/bin/env bash
#  ┓ ┏┏┓┳┓┏┓┏┓┏┓┳┓┏┓┓┏
#  ┃┃┃┣ ┣┫┗┓┣ ┣┫┣┫┃ ┣┫
#  ┗┻┛┗┛┻┛┗┛┗┛┛┗┛┗┗┛┛┗
#

# Rofi config
rofiTheme="${HOME}/.config/rofi/applets/webSearch.rasi"

# Websites (ícones)
option_1=""
option_2="󰊫"
option_3="󰗃"
option_4="󰊤"
option_5=""
option_6="󰕄"

# Rofi CMD
rofi_cmd() {
  if [[ -r "$rofiTheme" ]]; then
    rofi -markup-rows -dmenu -theme "$rofiTheme"
  else
    rofi -markup-rows -dmenu
  fi
}

# Passa as opções para o rofi dmenu
run_rofi() {
  printf '%s\n' \
    "$option_1" \
    "$option_2" \
    "$option_3" \
    "$option_4" \
    "$option_5" \
    "$option_6" | rofi_cmd
  }

# Executa comando
run_cmd() {
  case "$1" in
    --opt1) xdg-open 'https://www.google.com/' >/dev/null 2>&1 & ;;
    --opt2) xdg-open 'https://mail.google.com/' >/dev/null 2>&1 & ;;
    --opt3) xdg-open 'https://www.youtube.com/' >/dev/null 2>&1 & ;;
    --opt4) xdg-open 'https://www.github.com/' >/dev/null 2>&1 & ;;
    --opt5) xdg-open 'https://www.reddit.com/' >/dev/null 2>&1 & ;;
    --opt6) xdg-open 'https://www.twitter.com/' >/dev/null 2>&1 & ;;
  esac
}

# Ações
chosen="$(run_rofi)"
# Se o usuário cancelar/fechar o rofi, sai silenciosamente
[[ -z "$chosen" ]] && exit 0

case "$chosen" in
  "$option_1") run_cmd --opt1 ;;
  "$option_2") run_cmd --opt2 ;;
  "$option_3") run_cmd --opt3 ;;
  "$option_4") run_cmd --opt4 ;;
  "$option_5") run_cmd --opt5 ;;
  "$option_6") run_cmd --opt6 ;;
esac
