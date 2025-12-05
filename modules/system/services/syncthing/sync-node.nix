{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "sync-node";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Syncthing Module";
  config = mkIf cfg.enable {
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
    networking.firewall = {
      allowedTCPPorts = [22000];
      allowedUDPPorts = [21027 22000];
    };
    environment.systemPackages = with pkgs; [
      syncthing
    ];
  };
}
