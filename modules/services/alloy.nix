{
  flake.nixosModules.alloy = {pkgs, config, ...}:
  let
    alloyConfig = pkgs.writeText "config.alloy" ''
      local.file_match "local_files" {
        path_targets = [{"__path__" = "/var/log/*.log"}]
        sync_period = "5s"
      }
      loki.source.file = "log_scrape" {
        targets = local.file_match.local_files.targets
        forward_to = [loki.process.filter_logs.receiver]
        tail_from_end = true
      }
      loki.write "grafana_loki" {
        endpoint {
          url = "http://192.168.70.5:3100/loki/api/v1/push"
        }
      }
    '';
  in
  {
    services.alloy = {
      enable = true;
      configPath = alloyConfig;
    };
  };
}
