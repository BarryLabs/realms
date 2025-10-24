{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.mods.wm.wayland.hypridle.abyss;
in
{
  options.mods.wm.wayland.hypridle.abyss.enable = mkEnableOption "enable hypridle for abyss";
  config = mkIf cfg.enable {
    services = {
      hypridle = {
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
  };
}
