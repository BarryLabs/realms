{ config
, lib
, pkgs
, ...
}:
with lib; let
  module = "fuzzel";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "Fuzzel Module";
  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        fuzzel
        (pkgs.writeShellScriptBin "emoji" '' 
          if pidof fuzzel > /dev/null; then
            pkill fuzzel
          fi
          chosen=$(cat $HOME/.config/.emoji | ${pkgs.fuzzel}/bin/fuzzel -dmenu | awk '{print $1}')
          [ -z "$chosen" ] && exit
          printf "$chosen" | ${pkgs.wl-clipboard}/bin/wl-copy
          ${pkgs.libnotify}/bin/notify-send "'$chosen' copied to clipboard." &
        '')
      ];
    };
  };
}
