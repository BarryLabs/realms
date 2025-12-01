{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "firefly";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "Firefly Container";
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
        "podman-Firefly" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-firefly_Firefly.service"
          ];
          requires = [
            "podman-network-firefly_Firefly.service"
          ];
          partOf = [
            "podman-compose-firefly-root.target"
          ];
          wantedBy = [
            "podman-compose-firefly-root.target"
          ];
        };
        "podman-FireflyDB" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-firefly_Firefly.service"
          ];
          requires = [
            "podman-network-firefly_Firefly.service"
          ];
          partOf = [
            "podman-compose-firefly-root.target"
          ];
          wantedBy = [
            "podman-compose-firefly-root.target"
          ];
        };
        "podman-network-firefly_Firefly" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f firefly_Firefly";
          };
          script = ''
            podman network inspect firefly_Firefly || podman network create firefly_Firefly --driver=bridge
          '';
          partOf = [ "podman-compose-firefly-root.target" ];
          wantedBy = [ "podman-compose-firefly-root.target" ];
        };
      };
      targets."podman-compose-firefly-root" = {
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
          "Firefly" = {
            image = "fireflyiii/core:latest";
            log-driver = "journald";
            dependsOn = [
              "FireflyDB"
            ];
            environment = {
              "TZ" = "America/New_York";
              "DEFAULT_LANGUAGE" = "en_US";
              "LOG_CHANNEL" = "stack";
              "APP_LOG_LEVEL" = "notice";
              "AUDIT_LOG_LEVEL" = "emergency";
              "ENABLE_EXCHANGE_RATES" = "true";
              "APP_ENV" = "production";
              "APP_NAME" = "Realms Wallet";
              "BROADCAST_DRIVER" = "log";
              "QUEUE_DRIVER" = "sync";
              "CACHE_PREFIX" = "firefly";
              "DB_HOST" = "db";
              "DB_CONNECTION" = "pgsql";
            };
            environmentFiles = [
              /run/secrets/services/firefly/owner
              /run/secrets/services/firefly/app_key
              /run/secrets/services/firefly/db_port
              /run/secrets/services/firefly/db_name
              /run/secrets/services/firefly/db_user
              /run/secrets/services/firefly/db_pass
            ];
            extraOptions = [
              "--network-alias=wallet"
              "--network=firefly_Firefly"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "8080:8080/tcp"
            ];
            volumes = [
              "/sata/.container/firefly/upload:/var/www/html/storage/upload:rw"
            ];
          };
          "FireflyDB" = {
            image = "docker.io/library/postgres:17";
            log-driver = "journald";
            environmentFiles = [
              /run/secrets/services/firefly_db/db_name
              /run/secrets/services/firefly_db/db_user
              /run/secrets/services/firefly_db/db_pass
            ];
            volumes = [
              "/sata/.container/firefly/data:/var/lib/postgresql/data:rw"
            ];
            extraOptions = [
              "--network-alias=db"
              "--network=firefly_Firefly"
              "--security-opt=no-new-privileges:true"
            ];
          };
        };
      };
    };
  };
}
