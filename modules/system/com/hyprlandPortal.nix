{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.augs.com.hyprlandPortal;
in
{
  options.augs.com.hyprlandPortal.enable =
    mkEnableOption "Base Hyprland Portal Module";
  config = mkIf cfg.enable {
    xdg = {
      portal = {
        enable = true;
        wlr = {
          enable = true;
        };
        configPackages = [
          pkgs.xdg-desktop-portal-hyprland
        ];
      };
    };
  };
}
