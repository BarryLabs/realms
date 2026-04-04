{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  module = "niri";
  cfg = config.augs.gui.${module};
in
{
  options.augs.gui.${module}.enable = mkEnableOption "Niri Module";
  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = initial_session;
        initial_session = {
          user = config.var.user;
          command = if config.augs.gui.niri.enable then "${pkgs.niri}/bin/niri-session" else "";
        };
      };
    };
    environment = {
      systemPackages = with pkgs; [
        xwayland-satellite
        wl-clipboard
        nautilus
        grim
        slurp
        swappy
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
    programs.niri = {
      enable = true;
    };
  };
}
