{ config
, lib
, ...
}:
with lib; let
  module = "k3s-orchestrator";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "k3s Orchestrator Module";
  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [ 6443 ];
      allowedUDPPorts = [ 8472 ];
    };
    services.k3s = {
      enable = true;
      role = "server";
      extraFlags = toString [
        "--debug"
      ];
    };
  };
}
