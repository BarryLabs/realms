{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.mods.wm.wayland.wpaperd.abyss;
in
{
  options.mods.wm.wayland.wpaperd.abyss.enable = mkEnableOption "enable wpaperd for abyss";
  config = mkIf cfg.enable {
    services = {
      wpaperd = {
        enable = true;
        settings = {
          eDP-1 = {
            path = "/etc/nixos/.config/wallpapers/treepond_colors.png";
            apply-shadow = true;
          };
        };
      };
    };
  };
}
