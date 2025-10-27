{ config
, lib
, ...
}:
with lib;
let
  module = "network";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Networking Module";
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
