{
  flake.homeModules.grafana = {

    sops.secrets."grafana.yaml" = {
      sopsFile = ../../secrets/grafana.yaml;
      format = "binary";
      owner = "grafana";
      group = "grafana";
      mode = "0400";
    };

    home-manager.users.heimdall = { config, ... }: {
      home.stateVersion = "25.05";

      home.file.".config/monitoring/prometheus/prometheus.yml".text = ''
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

      home.file.".config/monitoring/grafana/provisioning/datasources/datasources.yml".text = ''
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

      home.file.".config/monitoring/promtail/config.yml".text = ''
        server:
          http_listen_port: 9080
          grpc_listen_port: 0

        positions:
          filename: /tmp/positions.yaml

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

      services.podman = {
        enable = true;

        networks.monitoring = { };

        containers.grafana = {
          image = "docker.io/grafana/grafana:11.6.0@sha256:62d2b9d20a19714ebfe48d1bb405086081bc602aa053e28cf6d73c7537640dfb";
          autoStart = true;
          network = "monitoring.network";
          networkAlias = [ "grafana" ];
          ports = [ "0.0.0.0:3000:3000" ];
          volumes = [
            "/var/lib/heimdall/grafana:/var/lib/grafana"
            "${config.home.homeDirectory}/.config/monitoring/grafana/provisioning/datasources:/etc/grafana/provisioning/datasources:ro"
            "/etc/localtime:/etc/localtime:ro"
          ];
          environmentFile = [ "/run/secrets/grafana.env" ];
          extraConfig = {
            Container = {
              User = "0";
              Group = "0";
              DropCapability = "ALL";
              NoNewPrivileges = true;
            };
            Service.Restart = "always";
            Unit = {
              After = [ "podman-prometheus.service" "podman-loki.service" ];
              Wants = [ "podman-prometheus.service" "podman-loki.service" ];
            };
          };
        };

        containers.prometheus = {
          image = "docker.io/prom/prometheus:v3.4.0@sha256:78ed1f9050eb9eaf766af6e580230b1c4965728650e332cd1ee918c0c4699775";
          autoStart = true;
          network = "monitoring.network";
          networkAlias = [ "prometheus" ];
          ports = [ "127.0.0.1:9090:9090" ];
          volumes = [
            "/var/lib/heimdall/prometheus:/prometheus"
            "${config.home.homeDirectory}/.config/monitoring/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:ro"
            "/etc/localtime:/etc/localtime:ro"
          ];
          extraConfig = {
            Container = {
              User = "0";
              Group = "0";
              DropCapability = "ALL";
              NoNewPrivileges = true;
            };
            Service.Restart = "always";
          };
        };

        containers.loki = {
          image = "docker.io/grafana/loki:3.4.2@sha256:58a6c186ce78ba04d58bfe2a927eff296ba733a430df09645d56cdc158f3ba08";
          autoStart = true;
          network = "monitoring.network";
          networkAlias = [ "loki" ];
          ports = [ "127.0.0.1:3100:3100" ];
          volumes = [
            "/var/lib/heimdall/loki:/loki"
            "/etc/localtime:/etc/localtime:ro"
          ];
          extraConfig = {
            Container = {
              User = "0";
              Group = "0";
              DropCapability = "ALL";
              NoNewPrivileges = true;
            };
            Service.Restart = "always";
          };
        };

        containers.promtail = {
          image = "docker.io/grafana/promtail:3.4.2@sha256:c6e9a987ca086cbfef945b8ebd708eb09f98b5e78bfb659e4e5a8b3bd604d11b";
          autoStart = true;
          network = "monitoring.network";
          networkAlias = [ "promtail" ];
          volumes = [
            "/var/lib/heimdall/promtail:/tmp"
            "${config.home.homeDirectory}/.config/monitoring/promtail/config.yml:/etc/promtail/config.yml:ro"
            "/var/log:/var/log:ro"
            "/etc/localtime:/etc/localtime:ro"
          ];
          extraConfig = {
            Container = {
              User = "0";
              Group = "0";
              DropCapability = "ALL";
              NoNewPrivileges = true;
            };
            Service.Restart = "always";
            Unit = {
              After = [ "podman-loki.service" ];
              Wants = [ "podman-loki.service" ];
            };
          };
        };

        containers.node-exporter = {
          image = "docker.io/prom/node-exporter:v1.9.1@sha256:d00a542e409ee618a4edc67da14dd48c5da66726bbd5537ab2af9c1dfc442c8a";
          autoStart = true;
          network = "monitoring.network";
          networkAlias = [ "node-exporter" ];
          ports = [ "127.0.0.1:9100:9100" ];
          volumes = [
            "/:/host:ro,rslave"
            "/etc/localtime:/etc/localtime:ro"
          ];
          extraPodmanArgs = [ "--pid=host" ];
          extraConfig = {
            Container = {
              Exec = "--path.rootfs=/host";
              DropCapability = "ALL";
              NoNewPrivileges = true;
              ReadOnly = true;
            };
            Service.Restart = "always";
          };
        };
      };
    };
  };
}
