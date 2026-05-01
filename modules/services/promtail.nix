{config, ...}: {
  flake.nixosModules.promtail = {pkgs, ...}: {
    systemd = {
      services = {
        promtail = {
          description = "Promtail for Loki";
          wantedBy = ["multi-user.target"];
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
