{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.services.promtail;
in
{
  options.augs.services.promtail.enable = mkEnableOption "Base Promtail Module";
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
