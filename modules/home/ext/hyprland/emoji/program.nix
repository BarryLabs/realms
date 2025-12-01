{ pkgs }:
pkgs.writeShellScriptBin "emoji" ''
  if pidof rofi > /dev/null; then
    pkill rofi
  fi
  chosen=$(cat $HOME/.config/.emoji | ${pkgs.rofi}/bin/rofi -i -dmenu -config ~/.config/rofi/config.rasi | awk '{print $1}')
  [ -z "$chosen" ] && exit
  printf "$chosen" | ${pkgs.wl-clipboard}/bin/wl-copy
  ${pkgs.libnotify}/bin/notify-send "'$chosen' copied to clipboard." &
''
