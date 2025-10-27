{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.wm.wayland.hyprpaper.yggdrasil;
in
{
  options.mods.wm.wayland.hyprpaper.yggdrasil.enable = mkEnableOption "Hyprpaper Module";
  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      importantPrefixes = [ ];
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload =
          [ "/etc/nixos/.config/wallpapers/i_heart_linux.png" "/etc/nixos/.config/wallpapers/nixos_dark.png" ];

        wallpaper = [
          "HDMI-A-1,/etc/nixos/.config/wallpapers/i_heart_linux.png"
          "HDMI-A-2,/etc/nixos/.config/wallpapers/nixos_dark.png"
        ];
      };
    };
  };
}
