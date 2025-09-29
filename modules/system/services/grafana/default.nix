{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.grafana;
in
{
  options.augs.services.grafana.enable = mkEnableOption "Base Grafana Module";
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
