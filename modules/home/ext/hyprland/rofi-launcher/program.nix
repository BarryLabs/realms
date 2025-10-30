{pkgs}:
pkgs.writeShellScriptBin "rofi-launcher" ''
  if pidof rofi > /dev/null; then
    pkill rofi
  fi
  rofi -show drun
''
