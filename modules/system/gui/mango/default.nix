{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  module = "mango";
  cfg = config.augs.gui.${module};
in
{
  options.augs.gui.${module}.enable = mkEnableOption "MangoWC Module";
  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = initial_session;
        initial_session = {
          user = config.var.user;
          command = "${pkgs.mangowc}/bin/mango";
        };
      };
    };
    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      slurp
      swappy
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    programs = {
      mangowc = {
        enable = true;
      };
    };
  };
}
