{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.oci.nextcloud;
in
{
  options.augs.oci.nextcloud.enable = mkEnableOption "Nextcloud Container";
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
        "podman-Nextcloud" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-nextcloud_Nextcloud.service"
          ];
          requires = [
            "podman-network-nextcloud_Nextcloud.service"
          ];
          partOf = [
            "podman-compose-nextcloud-root.target"
          ];
          wantedBy = [
            "podman-compose-nextcloud-root.target"
          ];
        };
        "podman-network-nextcloud_Nextcloud" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f nextcloud_Nextcloud";
          };
          script = ''
            podman network inspect nextcloud_Nextcloud || podman network create nextcloud_Nextcloud --driver=bridge
          '';
          partOf = [ "podman-compose-nextcloud-root.target" ];
          wantedBy = [ "podman-compose-nextcloud-root.target" ];
        };
      };
      targets."podman-compose-nextcloud-root" = {
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
          "Nextcloud" = {
            # labels = {
            #   "traefik.https.routers.example.rule" = "Host(`example.container`)";
            # };
            image = "lscr.io/linuxserver/nextcloud:latest";
            log-driver = "journald";
            environment = {
              PUID = 1000;
              PGID = 1000;
              TZ = "America/New_York";
            };
            environmentFiles = [
              /run/secrets/cloud
            ];
            extraOptions = [
              # "--device=/dev/dri:/dev/dri:rwm"
              "--network-alias=cloud"
              "--network=nextcloud_Nextcloud"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "443:443/tcp"
            ];
            volumes = [
              "./config:/config"
              "./data:/data"
            ];
          };
          "Database" = {
            image = "postgres:17";
            log-driver = "journald";
            environment = {
              PUID = 1000;
              PGID = 1000;
              TZ = "America/New_York";
            };
            environmentFiles = [
              /run/secrets/cloud-database
            ];
            extraOptions = [
              "--network-alias=database"
              "--network=nextcloud_Nextcloud"
              "--security-opt=no-new-privileges"
            ];
            volumes = [
              "./config:/config"
              "./data:/data"
            ];
          };
        };
      };
    };
  };
}
