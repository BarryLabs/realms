{ pkgs
, config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.nh;
in
{
  options.augs.com.nh.enable = mkEnableOption "Base NH Module for Realms";
  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
      flake =
        if config.networking.hostName == "abyss" then "/home/${config.var.user}/Projects/repos/Realms"
        else if config.networking.hostName == "yggdrasil" then "/home/${config.var.user}/Projects/repos/Realms"
        else "/etc/nixos";
    };

    environment.systemPackages = with pkgs; [
      nix-output-monitor
      nvd
    ];
  };
}
