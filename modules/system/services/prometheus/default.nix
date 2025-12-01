{ config
, lib
, ...
}:
with lib; let
  module = "prometheus";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Prometheus Module";
  config = mkIf cfg.enable {
    services = {
      prometheus = {
        enable = true;
        port = 9001;
        scrapeConfigs = [
          {
            job_name = "Realm Node Collection";
            static_configs = [
              {
                targets = [
                  "127.0.0.1:${toString config.services.prometheus.exporters.node.port}"
                  "192.168.1.235:${toString config.services.prometheus.exporters.node.port}"
                  "192.168.1.245:${toString config.services.prometheus.exporters.node.port}"
                  "192.168.30.5:${toString config.services.prometheus.exporters.node.port}"
                  "192.168.40.5:${toString config.services.prometheus.exporters.node.port}"
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
