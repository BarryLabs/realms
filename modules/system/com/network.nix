{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.network;
in
{
  options.augs.com.network.enable = mkEnableOption "Base Networking Module";
  config = mkIf cfg.enable {
    networking = {
      hostName = config.var.host;
      firewall = {
        enable = true;
        allowedUDPPorts = [ ];
        allowedTCPPorts = [ ];
      };
      wireless = {
        iwd = {
          enable = if config.networking.hostName == "abyss" then true else false;
        };
      };
    };
  };
}
