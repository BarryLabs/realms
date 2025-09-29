{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.programs.hyprland;

in
{
  options.augs.programs.hyprland.enable = mkEnableOption "Hyprland with Catppuccin Mocha SDDM";
  config = mkIf cfg.enable {
    services.displayManager = {
      sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        extraPackages = [ pkgs.catppuccin-sddm ];
        wayland = {
          enable = true;
          compositor = "weston";
        };
        theme = "catppuccin-mocha-mauve";
      };
    };
    programs = {
      hyprland = {
        enable = true;
      };
    };
  };
}
