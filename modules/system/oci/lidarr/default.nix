{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "lidarr";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "Lidarr Container";
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
        "podman-Lidarr" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-lidarr_Lidarr.service"
          ];
          requires = [
            "podman-network-lidarr_Lidarr.service"
          ];
          partOf = [
            "podman-compose-lidarr-root.target"
          ];
          wantedBy = [
            "podman-compose-lidarr-root.target"
          ];
        };
        "podman-network-lidarr_Lidarr" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f lidarr_Lidarr";
          };
          script = ''
            podman network inspect lidarr_Lidarr || podman network create lidarr_Lidarr --driver=bridge
          '';
          partOf = [ "podman-compose-lidarr-root.target" ];
          wantedBy = [ "podman-compose-lidarr-root.target" ];
        };
      };
      targets."podman-compose-lidarr-root" = {
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
          "Lidarr" = {
            image = "lscr.io/linuxserver/lidarr:latest";
            log-driver = "journald";
            environment = {
              "PUID" = "1000";
              "PGID" = "1000";
            };
            environmentFiles = [
              /run/secrets/tz
            ];
            extraOptions = [
              "--network-alias=headphone"
              "--network=lidarr_Lidarr"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "8686:8686/tcp"
            ];
            volumes = [
              "/srv/modules/lidarr/config:/config"
            ];
          };
        };
      };
    };
  };
}
