{ config, pkgs, lib, ... }:
  let
    dataDir = "/home/heimdall/.local/share/monitoring";
  in

  {
  sops.secrets.grafana-env = {
    sopsFile = ../../secrets/grafana.env;
    format = "dotenv";
    key = "";
    path = "/home/heimdall/.config/monitoring/grafana/env";
  };

  home.file = {
    "${dataDir}/grafana/.keep".text = "";
    "${dataDir}/prometheus/.keep".text = "";
    "${dataDir}/loki/.keep".text = "";
    "${dataDir}/promtail/.keep".text = "";
  
    ".config/monitoring/prometheus/prometheus.yml".text = ''
      global:
        scrape_interval: 15s
        evaluation_interval: 15s
        external_labels:
          monitor: grafana

      scrape_configs:
        - job_name: prometheus
          static_configs:
            - targets: ['localhost:9090']

        - job_name: grafana
          static_configs:
            - targets: ['grafana:3000']

        - job_name: loki
          static_configs:
            - targets: ['loki:3100']

        - job_name: node
          static_configs:
            - targets: ['node-exporter:9100']
    '';

    ".config/monitoring/grafana/provisioning/datasources/datasources.yml".text = ''
      apiVersion: 1
      datasources:
        - name: Prometheus
          type: prometheus
          access: proxy
          url: http://prometheus:9090
          isDefault: true
          editable: false
        - name: Loki
          type: loki
          access: proxy
          url: http://loki:3100
          editable: false
    '';

    ".config/monitoring/promtail/config.yml".text = ''
      server:
        http_listen_port: 9080
        grpc_listen_port: 0

      positions:
        filename: /var/lib/promtail/positions.yaml

      clients:
        - url: http://loki:3100/loki/api/v1/push

      scrape_configs:
        - job_name: varlog
          static_configs:
            - targets:
                - localhost
              labels:
                job: varlog
                __path__: /var/log/**/*.log
    '';
  };

  services.podman = {
    enable = true;

    networks.monitoring = { };

    containers = {
      grafana = {
        image = "docker.io/grafana/grafana:latest";
        autoStart = true;
        network = "monitoring.network";
        networkAlias = [ "grafana" ];
        ports = [ "127.0.0.1:3000:3000" ];
        volumes = [
          "${dataDir}/grafana:/var/lib/grafana:U,Z"
          "${config.home.homeDirectory}/.config/monitoring/grafana/provisioning/datasources:/etc/grafana/provisioning/datasources:ro"
          "/etc/localtime:/etc/localtime:ro"
        ];
        environmentFile = [ config.sops.secrets.grafana-env.path ];
        extraConfig = {
          Container = {
            User = "472";
            Group = "472";
            DropCapability = "ALL";
            NoNewPrivileges = true;
            ReadOnly = true;
            Tmpfs = [ 
              "/tmp:rw,noexec,nosuid,size=100m" 
              "/var/lib/grafana/sessions:rw,noexec,nosuid,size=10m"
            ];
          };
          Service = {
            Restart = "always";
            RestartSec = "5";
            MemoryMax = "512M";
            CPUQuota = "100%";
            TimeoutStartSec = "60";
          };
          Unit = {
            Description = "Grafana Monitoring Dashboard";
            After = [ "network-online.target" "sops-nix.service" ];
            Wants = [ "network-online.target" "sops-nix.service" ];
          };
        };
      };

      # prometheus = {
      #   image = "docker.io/prom/prometheus:latest";
      #   autoStart = true;
      #   network = "monitoring.network";
      #   networkAlias = [ "prometheus" ];
      #   ports = [ "127.0.0.1:9090:9090" ];
      #   volumes = [
      #     "${dataDir}/prometheus:/prometheus:U,Z"
      #     "${config.home.homeDirectory}/.config/monitoring/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:ro"
      #     "/etc/localtime:/etc/localtime:ro"
      #   ];
      #   extraConfig = {
      #     Container = {
      #       User = "65534";
      #       Group = "65534";
      #       DropCapability = "ALL";
      #       NoNewPrivileges = true;
      #       ReadOnly = true;
      #       Tmpfs = [ "/tmp:rw,noexec,nosuid,size=100m" ];
      #     };
      #     Service = {
      #       Restart = "always";
      #       RestartSec = "5";
      #       MemoryMax = "1G";
      #       TimeoutStartSec = "60";
      #     };
      #     Unit = {
      #       Description = "Prometheus for Grafana";
      #       After = [ "network-online.target" ];
      #       Wants = [ "network-online.target" ];
      #     };
      #   };
      # };

      # loki = {
      #   image = "docker.io/grafana/loki:latest";
      #   autoStart = true;
      #   network = "monitoring.network";
      #   networkAlias = [ "loki" ];
      #   ports = [ "127.0.0.1:3100:3100" ];
      #   volumes = [
      #     "${dataDir}/loki:/loki:U,Z"
      #     "/etc/localtime:/etc/localtime:ro"
      #   ];
      #   extraConfig = {
      #     Container = {
      #       User = "10001";
      #       Group = "10001";
      #       DropCapability = "ALL";
      #       NoNewPrivileges = true;
      #       ReadOnly = true;
      #       Tmpfs = [ "/tmp:rw,noexec,nosuid,size=100m" ];
      #     };
      #     Service = {
      #       Restart = "always";
      #       RestartSec = "5";
      #       MemoryMax = "512M";
      #     };
      #     Unit = {
      #       Description = "Loki Log Aggregation";
      #       After = [ "network-online.target" ];
      #       Wants = [ "network-online.target" ];
      #     };
      #   };
      # };

      # promtail = {
      #   image = "docker.io/grafana/promtail:latest";
      #   autoStart = true;
      #   network = "monitoring.network";
      #   networkAlias = [ "promtail" ];
      #   volumes = [
      #     "${dataDir}/promtail:/var/lib/promtail:U,Z"
      #     "${config.home.homeDirectory}/.config/monitoring/promtail/config.yml:/etc/promtail/config.yml:ro"
      #     "/var/log:/var/log:ro"
      #     "/etc/localtime:/etc/localtime:ro"
      #   ];
      #   extraConfig = {
      #     Container = {
      #       User = "0";
      #       Group = "0";
      #       AddCapability = [ "dac_read_search" ];
      #       DropCapability = "ALL";
      #       NoNewPrivileges = true;
      #       ReadOnly = true;
      #       Tmpfs = [ "/tmp:rw,noexec,nosuid,size=50m" ];
      #     };
      #     Service = {
      #       Restart = "always";
      #       RestartSec = "5";
      #       MemoryMax = "256M";
      #     };
      #     Unit = {
      #       Description = "Promtail Log Shipper";
      #       After = [ "network-online.target" "podman-loki.service" ];
      #       Wants = [ "network-online.target" "podman-loki.service" ];
      #     };
      #   };
      # };

      # node-exporter = {
      #   image = "docker.io/prom/node-exporter:latest";
      #   autoStart = true;
      #   network = "monitoring.network";
      #   networkAlias = [ "node-exporter" ];
      #   ports = [ "127.0.0.1:9100:9100" ];
      #   volumes = [
      #     "/:/host:ro,rslave"
      #     "/etc/localtime:/etc/localtime:ro"
      #   ];
      #   extraPodmanArgs = [ "--pid=host" ];
      #   extraConfig = {
      #     Container = {
      #       Exec = "--path.rootfs=/host";
      #       User = "0";
      #       Group = "0";
      #       DropCapability = "ALL";
      #       AddCapability = [ 
      #         "sys_time"
      #         "sys_admin"
      #         "net_raw"
      #       ];
      #       NoNewPrivileges = true;
      #       ReadOnly = true;
      #     };
      #     Service = {
      #       Restart = "always";
      #       RestartSec = "5";
      #       MemoryMax = "128M";
      #     };
      #     Unit = {
      #       Description = "Node exporter";
      #       After = [ "network-online.target" ];
      #       Wants = [ "network-online.target" ];
      #     };
      #   };
      # };
    };
  };
}
