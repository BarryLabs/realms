{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "prowlarr";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "Prowlarr Container";
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
        "podman-Prowlarr" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-prowlarr_Prowlarr.service"
          ];
          requires = [
            "podman-network-prowlarr_Prowlarr.service"
          ];
          partOf = [
            "podman-compose-prowlarr-root.target"
          ];
          wantedBy = [
            "podman-compose-prowlarr-root.target"
          ];
        };
        "podman-network-prowlarr_Prowlarr" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f prowlarr_Prowlarr";
          };
          script = ''
            podman network inspect prowlarr_Prowlarr || podman network create prowlarr_Prowlarr --driver=bridge
          '';
          partOf = [ "podman-compose-prowlarr-root.target" ];
          wantedBy = [ "podman-compose-prowlarr-root.target" ];
        };
      };
      targets."podman-compose-prowlarr-root" = {
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
          "Prowlarr" = {
            image = "lscr.io/linuxserver/prowlarr:latest";
            log-driver = "journald";
            environment = {
              "PUID" = "1000";
              "PGID" = "100";
            };
            environmentFiles = [
              /run/secrets/tz
            ];
            extraOptions = [
              "--network-alias=prowl"
              "--network=prowlarr_Prowlarr"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "9696:9696/tcp"
            ];
            volumes = [
              "/srv/modules/prowlarr/config:/config"
            ];
          };
        };
      };
    };
  };
}
