{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.wm.wayland.wpaperd.yggdrasil;
in
{
  options.mods.wm.wayland.wpaperd.yggdrasil.enable = mkEnableOption "enable wpaperd for yggdrasil";
  config = mkIf cfg.enable {
    services = {
      wpaperd = {
        enable = true;
        settings = {
          HDMI-A-1 = {
            path = "/etc/nixos/.config/wallpapers/astronaut.png";
            apply-shadow = true;
          };
          HDMI-A-2 = {
            path = "/etc/nixos/.config/wallpapers/nixos_dark.png";
            apply-shadow = true;
          };
        };
      };
    };
  };
}
