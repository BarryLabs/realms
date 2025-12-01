{ pkgs
, config
, lib
, ...
}:
with lib;
let
  module = "nh";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base NH Module for Realms";
  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
      flake =
        if config.networking.hostName == "abyss" then "/home/${config.var.user}/Projects/repos/realms-main"
        else if config.networking.hostName == "yggdrasil" then "/home/${config.var.user}/Projects/repos/realms-main"
        else "/etc/nixos";
    };

    environment.systemPackages = with pkgs; [
      nix-output-monitor
      nvd
    ];
  };
}
