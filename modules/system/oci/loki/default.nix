{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "loki";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "Loki Container";
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
        "podman-Loki" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-loki_Loki.service"
          ];
          requires = [
            "podman-network-loki_Loki.service"
          ];
          partOf = [
            "podman-compose-loki-root.target"
          ];
          wantedBy = [
            "podman-compose-loki-root.target"
          ];
        };
        "podman-network-loki_Loki" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f loki_Loki";
          };
          script = ''
            podman network inspect loki_Loki || podman network create loki_Loki --driver=bridge
          '';
          partOf = [ "podman-compose-loki-root.target" ];
          wantedBy = [ "podman-compose-loki-root.target" ];
        };
      };
      targets."podman-compose-loki-root" = {
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
          "Loki" = {
            image = "grafana/loki";
            log-driver = "journald";
            extraOptions = [
              "--network-alias=loki"
              "--network=loki_Loki"
              "--security-opt=no-new-privileges"
            ];
            cmd = [ "-config.file=/mnt/config/loki-config.yaml" ];
            ports = [ "3100:3100/tcp" ];
            volumes = [
              "./data:/tmp:rw"
              "./loki-config.yaml:/mnt/config/loki-config.yaml:rw"
            ];
          };
        };
      };
    };
  };
}
