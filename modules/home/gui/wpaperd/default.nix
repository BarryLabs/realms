{ config
, lib
, ...
}:
with lib;
let
  module = "wpaperd";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "WPaperD Module";
  config = mkIf cfg.enable {
    services = {
      wpaperd = {
        enable = true;
        settings = {
          HDMI-A-1 = {
            path = "/etc/nixos/.config/wallpapers/i_heart_linux.png";
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
