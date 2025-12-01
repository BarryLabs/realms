{ config
, lib
, ...
}:
with lib; let
  module = "grafana";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Grafana Module";
  config = mkIf cfg.enable {
    services = {
      grafana = {
        enable = true;
        settings = {
          server = {
            http_addr = "0.0.0.0";
            http_port = 3000;
            enable_gzip = true;
          };
        };
      };
    };
  };
}
