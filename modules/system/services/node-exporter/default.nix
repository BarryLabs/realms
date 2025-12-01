{ config
, lib
, ...
}:
with lib; let
  module = "node-exporter";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Node-Exporter Module";
  config = mkIf cfg.enable {
    services = {
      prometheus = {
        exporters = {
          node = {
            enable = true;
            port = 9002;
            openFirewall = true;
            enabledCollectors = [ "systemd" ];
          };
        };
      };
    };
  };
}
