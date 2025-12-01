{ config
, lib
, vars
, ...
}:
with lib;
let
  module = "hyprpaper";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "Hyprpaper Module";
  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      importantPrefixes = [ ];
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;
        preload = [
          "/etc/nixos/.config/wallpapers/i_heart_linux.png"
          "/etc/nixos/.config/wallpapers/nixos_dark.png"
        ];
        wallpaper =
          if vars.user == "chandler" then [
            "HDMI-A-1,/etc/nixos/.config/wallpapers/i_heart_linux.png"
            "HDMI-A-2,/etc/nixos/.config/wallpapers/nixos_dark.png"
          ] else if vars.user == "mamotdask" then [
            "eDP-1,/etc/nixos/.config/wallpapers/nixos_dark.png"
          ] else [ ];
      };
    };
  };
}
