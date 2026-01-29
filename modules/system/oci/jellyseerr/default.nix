{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "jellyseerr";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "Jellyseerr Container";
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
        "podman-Jellyseerr" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-seerr_Seerr.service"
          ];
          requires = [
            "podman-network-seerr_Seerr.service"
          ];
          partOf = [
            "podman-compose-jellyseerr-root.target"
          ];
          wantedBy = [
            "podman-compose-jellyseerr-root.target"
          ];
        };
        "podman-network-seerr_Seerr" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f seerr_Seerr";
          };
          script = ''
            podman network inspect seerr_Seerr || podman network create seerr_Seerr --driver=bridge
          '';
          partOf = [ "podman-compose-jellyseerr-root.target" ];
          wantedBy = [ "podman-compose-jellyseerr-root.target" ];
        };
      };
      targets."podman-compose-jellyseerr-root" = {
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
          "Jellyseerr" = {
            image = "ghcr.io/fallenbagel/jellyseerr:latest";
            log-driver = "journald";
            environment = {
              "PUID" = "1000";
              "PGID" = "100";
              "LOG_LEVEL" = "info";
            };
            environmentFiles = [
              /run/secrets/tz
            ];
            extraOptions = [
              "--network-alias=theater"
              "--network=seerr_Seerr"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "5055:5055/tcp"
            ];
            volumes = [
              "/srv/modules/jellyseerr/config:/app/config"
            ];
          };
        };
      };
    };
  };
}
