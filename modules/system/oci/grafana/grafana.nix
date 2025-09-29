{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.oci.grafana;
in
{
  options.augs.oci.grafana.enable = mkEnableOption "Grafana Container";
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
        "podman-Grafana" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-grafana_Grafana.service"
          ];
          requires = [
            "podman-network-grafana_Grafana.service"
          ];
          partOf = [
            "podman-compose-grafana-root.target"
          ];
          wantedBy = [
            "podman-compose-grafana-root.target"
          ];
        };
        "podman-network-grafana_Grafana" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f grafana_Grafana";
          };
          script = ''
            podman network inspect grafana_Grafana || podman network create grafana_Grafana --driver=bridge
          '';
          partOf = [ "podman-compose-grafana-root.target" ];
          wantedBy = [ "podman-compose-grafana-root.target" ];
        };
      };
      targets."podman-compose-grafana-root" = {
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
          "Grafana" = {
            image = "grafana/grafana-enterprise";
            log-driver = "journald";
            extraOptions = [
              "--network-alias=grafana"
              "--network=grafana_Grafana"
              "--security-opt=no-new-privileges"
            ];
            ports = [ "3000:3000/tcp" ];
            volumes = [ "./grafana:/var/lib/grafana" ];
          };
        };
      };
    };
  };
}
