{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "promtail";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Promtail Module";
  config = mkIf cfg.enable {
    systemd = {
      services = {
        promtail = {
          description = "Promtail for Loki";
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            ExecStart = ''
              ${pkgs.grafana-loki}/bin/promtail --config.file ${../../../../.config/promtail/${config.var.host}.yaml}
            '';
          };
        };
      };
    };
  };
}
