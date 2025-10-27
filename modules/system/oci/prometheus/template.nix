{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "prometheus";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "Prometheus Container";
  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
    };
    networking.firewall.interfaces =
      let
        matchAll = if !config.networking.nftables.enable then "podman+" else "podman*";
      in
      {
        "${matchAll}".allowedUDPPorts = [ 53 ];
      };

    systemd = {
      services = {
        "podman-Prometheus" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-prometheus_Prometheus.service"
          ];
          requires = [
            "podman-network-prometheus_Prometheus.service"
          ];
          partOf = [
            "podman-compose-prometheus_Prometheus-root.target"
          ];
          wantedBy = [
            "podman-compose-prometheus_Prometheus-root.target"
          ];
        };
        "podman-network-prometheus_Prometheus" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f prometheus_Prometheus";
          };
          script = ''
            podman network inspect prometheus_Prometheus || podman network create prometheus_Prometheus --driver=bridge
          '';
          partOf = [ "podman-compose-prometheus-root.target" ];
          wantedBy = [ "podman-compose-prometheus-root.target" ];
        };
      };
      targets."podman-compose-prometheus-root" = {
        unitConfig = {
          Description = "Root Target";
        };
        wantedBy = [ "multi-user.target" ];
      };
    };

    virtualisation = {
      oci-containers = {
        backend = "podman";
        containers = {
          "Prometheus" = {
            image = "prom/prometheus";
            log-driver = "journald";
            extraOptions = [
              "--network-alias=prometheus"
              "--network=prometheus_Prometheus"
              "--security-opt=no-new-privileges"
            ];
            ports = [ "9090:9090/tcp" ];
            volumes = [ "./prometheus.yml:/etc/prometheus/prometheus.yml" ];
          };
        };
      };
    };
  };
}
