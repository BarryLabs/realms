{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.mods.wm.wayland.hypridle.yggdrasil;
in
{
  options.mods.wm.wayland.hypridle.yggdrasil.enable = mkEnableOption "enable hypridle for yggdrasil";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hypridle
    ];
    services.hypridle = {
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 300;
            on-timeout = "hyprlock";
          }
          {
            timeout = 900;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
