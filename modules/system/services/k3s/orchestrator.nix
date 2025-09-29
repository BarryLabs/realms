{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.k3s.orchestrator;
in
{
  options.augs.services.k3s.orchestrator.enable = mkEnableOption "Base k3s Orchestrator Module";
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
