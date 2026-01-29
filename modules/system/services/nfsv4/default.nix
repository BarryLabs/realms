{ config
, lib
, ...
}:
with lib; let
  module = "nfsv4";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "NFSv4 Module";
  config = mkIf cfg.enable {
    services.nfs.server.enable = true;
    networking.firewall = {
      allowedTCPPorts = [2049];
    };
  };
}
