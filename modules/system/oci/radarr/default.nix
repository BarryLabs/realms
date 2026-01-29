{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "radarr";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "Radarr Container";
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
        "podman-Radarr" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-radarr_Radarr.service"
          ];
          requires = [
            "podman-network-radarr_Radarr.service"
          ];
          partOf = [
            "podman-compose-radarr-root.target"
          ];
          wantedBy = [
            "podman-compose-radarr-root.target"
          ];
        };
        "podman-network-radarr_Radarr" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f radarr_Radarr";
          };
          script = ''
            podman network inspect radarr_Radarr || podman network create radarr_Radarr --driver=bridge
          '';
          partOf = [ "podman-compose-radarr-root.target" ];
          wantedBy = [ "podman-compose-radarr-root.target" ];
        };
      };
      targets."podman-compose-radarr-root" = {
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
          "Radarr" = {
            image = "lscr.io/linuxserver/radarr:latest";
            log-driver = "journald";
            environment = {
              "PUID" = "1000";
              "PGID" = "100";
            };
            environmentFiles = [
              /run/secrets/tz
            ];
            extraOptions = [
              "--network-alias=dish"
              "--network=radarr_Radarr"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "7878:7878/tcp"
            ];
            volumes = [
              "/srv/modules/radarr/config:/config"
            ];
          };
        };
      };
    };
  };
}
