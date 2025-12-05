{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "hyprland";
  cfg = config.augs.gui.${module};
in
{
  options.augs.gui.${module}.enable = mkEnableOption "Hyprland Module";
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
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = initial_session;
        initial_session = {
          user = config.var.user;
          command = "${pkgs.hyprland}/bin/hyprland";
        };
      };
    };
    programs = {
      hyprland = {
        enable = true;
      };
    };
  };
}
