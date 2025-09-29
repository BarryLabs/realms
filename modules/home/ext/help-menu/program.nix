{ pkgs }:
pkgs.writeShellScriptBin "help-menu" ''

  if pidof rofi > /dev/null; then
    pkill rofi
  fi

  keybinds=$(cat ~/.config/hypr/hyprland.conf | grep -E '^bind')
  display_keybinds=$(echo "$keybinds" | sed 's/\$modifier/SUPER/g')
  echo "$display_keybinds" | rofi -dmenu -i -config ~/.config/rofi/config.rasi

''
