{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "podman";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Podman System Module";
  config = mkIf cfg.enable {
    environment = {
      variables = {
        DBX_CONTAINER_MANAGER = "podman";
      };
      systemPackages = with pkgs; [
        podman-compose
      ];
    };
    users.extraGroups.podman.members = [ config.var.user ];
    virtualisation = {
      podman = {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
        dockerCompat = true;
        autoPrune = {
          enable = true;
          dates = "weekly";
          flags = [
            "--all"
          ];
        };
      };
    };
  };
}
