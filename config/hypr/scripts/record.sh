#!/usr/bin/env bash
#  ┳┓┏┓┏┓┏┓┳┓┳┓
#  ┣┫┣ ┃ ┃┃┣┫┃┃
#  ┛┗┗┛┗┛┗┛┛┗┻┛
#
# Transformado para usar gpu-screen-recorder no lugar de wf-recorder
# Mantém:
# - Toggle (rodar novamente para parar)
# - Três modos:
#   --fullscreen-sound  -> tela focada com áudio
#   --fullscreen        -> tela focada sem áudio
#   (default)           -> região (slurp); se parâmetro for --sound, inclui áudio
#
# Saída: $HOME/Videos/recording_YYYY-MM-DD_HH.MM.SS.mp4

set -euo pipefail

getdate() {
  date '+%Y-%m-%d_%H.%M.%S'
}
getaudiooutput() {
  pactl list sources | grep 'Name' | grep 'monitor' | head -n1 | cut -d ' ' -f2
}
getactivemonitor() {
  hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name'
}

xdgvideo="$(xdg-user-dir VIDEOS)"
if [[ $xdgvideo = "$HOME" ]]; then
  unset xdgvideo
fi
mkdir -p "${xdgvideo:-$HOME/Videos}"
cd "${xdgvideo:-$HOME/Videos}" || exit

# Toggle: se já estiver gravando, parar e sair
if pgrep -f gpu-screen-recorder > /dev/null; then
  notify-send "Recording Stopped" "Stopped" -a 'Recorder' &
  pkill -INT -f gpu-screen-recorder &
  exit 0
fi

# Iniciar gravação
outfile="./recording_$(getdate).mp4"
FPS="${FPS:-60}"

if [[ "${1:-}" == "--fullscreen-sound" ]]; then
  MON="$(getactivemonitor || true)"; MON="${MON:-focused}"
  notify-send "Starting recording" "$(basename "$outfile")" -a 'Recorder'
  gpu-screen-recorder \
    -w "$MON" \
    -f "$FPS" \
    -a "$(getaudiooutput)" \
    -o "$outfile" & disown

elif [[ "${1:-}" == "--fullscreen" ]]; then
  MON="$(getactivemonitor || true)"; MON="${MON:-focused}"
  notify-send "Starting recording" "$(basename "$outfile")" -a 'Recorder'
  gpu-screen-recorder \
    -w "$MON" \
    -f "$FPS" \
    -o "$outfile" & disown

else
  # Seleção de região com slurp -> gpu-screen-recorder usa "-w region" + "-region WxH+X+Y"
  if ! region="$(slurp 2>/dev/null)"; then
    notify-send "Recording cancelled" "Selection was cancelled" -a 'Recorder'
    exit 1
  fi
  # region no formato: "X,Y WxH"
  x="${region%%,*}"
  rest="${region#*,}"
  y="${rest%% *}"
  size="${region##* }"
  w="${size%x*}"
  h="${size#*x}"
  geom="${w}x${h}+${x}+${y}"

  notify-send "Starting recording" "$(basename "$outfile")" -a 'Recorder'
  if [[ "${1:-}" == "--sound" ]]; then
    gpu-screen-recorder \
      -w region -region "$geom" \
      -f "$FPS" \
      -a "$(getaudiooutput)" \
      -o "$outfile" & disown
  else
    gpu-screen-recorder \
      -w region -region "$geom" \
      -f "$FPS" \
      -o "$outfile" & disown
  fi
fi
