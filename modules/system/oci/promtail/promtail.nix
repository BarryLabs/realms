{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "promtail";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "Promtail Container";
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
        "podman-Promtail" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-promtail_Promtail.service"
          ];
          requires = [
            "podman-network-promtail_Promtail.service"
          ];
          partOf = [
            "podman-compose-promtail-root.target"
          ];
          wantedBy = [
            "podman-compose-promtail-root.target"
          ];
        };
        "podman-network-promtail_Promtail" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f promtail_Promtail";
          };
          script = ''
            podman network inspect promtail_Promtail || podman network create promtail_Promtail --driver=bridge
          '';
          partOf = [ "podman-compose-promtail-root.target" ];
          wantedBy = [ "podman-compose-promtail-root.target" ];
        };
      };
      targets."podman-compose-promtail-root" = {
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
          "Promtail" = {
            image = "grafana/promtail:latest";
            log-driver = "journald";
            extraOptions = [
              "--network-alias=promtail"
              "--network=promtail_Promtail"
              "--security-opt=no-new-privileges"
            ];
            volumes = [ "./promtail-config.yaml:/etc/promtail/promtail-config.yaml" ];
          };
        };
      };
    };
  };
}
