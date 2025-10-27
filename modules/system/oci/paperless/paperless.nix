{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "paperless";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "enable paperless";
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
        "podman-Paperless" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-cabinet_default.service"
          ];
          requires = [
            "podman-network-cabinet_default.service"
          ];
          partOf = [
            "podman-compose-cabinet-root.target"
          ];
          wantedBy = [
            "podman-compose-cabinet-root.target"
          ];
        };
        "podman-PaperlessDB" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-cabinet_default.service"
          ];
          requires = [
            "podman-network-cabinet_default.service"
          ];
          partOf = [
            "podman-compose-cabinet-root.target"
          ];
          wantedBy = [
            "podman-compose-cabinet-root.target"
          ];
        };
        "podman-PaperlessRedis" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-cabinet_default.service"
          ];
          requires = [
            "podman-network-cabinet_default.service"
          ];
          partOf = [
            "podman-compose-cabinet-root.target"
          ];
          wantedBy = [
            "podman-compose-cabinet-root.target"
          ];
        };
        "podman-network-cabinet_default" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f cabinet_default";
          };
          script = ''
            podman network inspect cabinet_default || podman network create cabinet_default
          '';
          partOf = [ "podman-compose-cabinet-root.target" ];
          wantedBy = [ "podman-compose-cabinet-root.target" ];
        };
      };
      targets = {
        "podman-compose-cabinet-root" = {
          unitConfig = {
            Description = "NAS Cabinet Root Target.";
          };
          wantedBy = [ "multi-user.target" ];
        };
      };
    };

    virtualisation = {
      oci-containers = {
        backend = "podman";
        containers = {
          "Paperless" = {
            image = "ghcr.io/paperless-ngx/paperless-ngx:latest";
            log-driver = "journald";
            dependsOn = [
              "PaperlessDB"
              "PaperlessRedis"
            ];
            extraOptions = [
              "--hostname=cabinet"
              "--network-alias=webserver"
              "--network=cabinet_default"
              "--security-opt=no-new-privileges:true"
            ];
            environment = {
              "USERMAP_GID" = "1000";
              "USERMAP_UID" = "1000";
              "PAPERLESS_DB" = "db";
              "PAPERLESS_REDIS" = "redis://redis:6379";
              "PAPERLESS_TIME_ZONE" = "America/New_York";
              "PAPERLESS_FILENAME_FORMAT" = "{created_year}/{correspondent}/{title}";
            };
            environmentFiles = [
              /run/secrets/services/paperless/admin_user
              /run/secrets/services/paperless/admin_pass
              /run/secrets/services/paperless/db_pass
              /run/secrets/services/paperless/db_user
            ];
            ports = [
              "8000:8000/tcp"
            ];
            volumes = [
              "/sata/.container/paperless/application/consume:/usr/src/paperless/consume:rw"
              "/sata/.container/paperless/application/data:/usr/src/paperless/data:rw"
              "/sata/.container/paperless/application/export:/usr/src/paperless/export:rw"
              "/sata/.container/paperless/application/media:/usr/src/paperless/media:rw"
            ];
          };
          "PaperlessDB" = {
            image = "docker.io/library/postgres:17";
            log-driver = "journald";
            environmentFiles = [
              /run/secrets/services/paperless_db/db_name
              /run/secrets/services/paperless_db/db_user
              /run/secrets/services/paperless_db/db_password
            ];
            extraOptions = [
              "--network-alias=db"
              "--network=cabinet_default"
              "--security-opt=no-new-privileges:true"
            ];
            volumes = [
              "/sata/.container/paperless/data:/var/lib/postgresql/data:rw"
            ];
          };
          "PaperlessRedis" = {
            image = "docker.io/library/redis:8";
            log-driver = "journald";
            extraOptions = [
              "--network-alias=redis"
              "--network=cabinet_default"
              "--security-opt=no-new-privileges:true"
            ];
            volumes = [
              "/sata/.container/paperless/redis:/data:rw"
            ];
          };
        };
      };
    };
  };
}
