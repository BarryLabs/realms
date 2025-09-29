{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.com.podman;
in
{
  options.augs.com.podman.enable = mkEnableOption "Base Podman System Module";
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
