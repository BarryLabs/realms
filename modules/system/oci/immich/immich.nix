{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "immich";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "enable immich";
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
        "podman-Immich" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-panorama_default.service"
          ];
          requires = [
            "podman-network-panorama_default.service"
          ];
          partOf = [
            "podman-compose-panorama-root.target"
          ];
          wantedBy = [
            "podman-compose-panorama-root.target"
          ];
        };
        "podman-ImmichDB" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-panorama_default.service"
          ];
          requires = [
            "podman-network-panorama_default.service"
          ];
          partOf = [
            "podman-compose-panorama-root.target"
          ];
          wantedBy = [
            "podman-compose-panorama-root.target"
          ];
        };
        "podman-ImmichML" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-panorama_default.service"
          ];
          requires = [
            "podman-network-panorama_default.service"
          ];
          partOf = [
            "podman-compose-panorama-root.target"
          ];
          wantedBy = [
            "podman-compose-panorama-root.target"
          ];
        };
        "podman-ImmichRedis" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-panorama_default.service"
          ];
          requires = [
            "podman-network-panorama_default.service"
          ];
          partOf = [
            "podman-compose-panorama-root.target"
          ];
          wantedBy = [
            "podman-compose-panorama-root.target"
          ];
        };
        "podman-network-panorama_default" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f panorama_default";
          };
          script = ''
            podman network inspect panorama_default || podman network create panorama_default
          '';
          partOf = [ "podman-compose-panorama-root.target" ];
          wantedBy = [ "podman-compose-panorama-root.target" ];
        };
      };
      targets = {
        "podman-compose-panorama-root" = {
          unitConfig = {
            Description = "NAS Immich Root Target.";
          };
          wantedBy = [ "multi-user.target" ];
        };
      };
    };

    virtualisation = {
      oci-containers = {
        backend = "podman";
        containers = {
          "Immich" = {
            image = "ghcr.io/immich-app/immich-server:release";
            environment = {
              "TZ" = "America/New_York";
            };
            environmentFiles = [
              /run/secrets/services/immich/db_name
              /run/secrets/services/immich/db_user
              /run/secrets/services/immich/db_pass
            ];
            volumes = [
              "/etc/localtime:/etc/localtime:ro"
              "/sata/.container/immich/upload:/usr/src/app/upload:rw"
            ];
            ports = [
              "2283:2283/tcp"
            ];
            dependsOn = [
              "ImmichDB"
              "ImmichRedis"
            ];
            log-driver = "journald";
            extraOptions = [
              "--device=/dev/dri:/dev/dri:rwm"
              "--hostname=panorama"
              "--network-alias=immich-server"
              "--network=panorama_default"
              "--security-opt=no-new-privileges:true"
            ];
          };
          "ImmichDB" = {
            image = "docker.io/tensorchord/pgvecto-rs:pg14-v0.2.0@sha256:90724186f0a3517cf6914295b5ab410db9ce23190a2d9d0b9dd6463e3fa298f0";
            log-driver = "journald";
            environment = {
              "POSTGRES_INITDB_ARGS" = "--data-checksums";
            };
            environmentFiles = [
              /run/secrets/services/immich_db/db_name
              /run/secrets/services/immich_db/db_user
              /run/secrets/services/immich_db/db_pass
            ];
            volumes = [
              "/sata/.container/immich/data:/var/lib/postgresql/data:rw"
            ];
            cmd = [
              "postgres"
              "-c"
              "shared_preload_libraries=vectors.so"
              "-c"
              "search_path=\"$user\", public, vectors"
              "-c"
              "logging_collector=on"
              "-c"
              "max_wal_size=2GB"
              "-c"
              "shared_buffers=512MB"
              "-c"
              "wal_compression=on"
            ];
            extraOptions = [
              "--network-alias=database"
              "--network=panorama_default"
              "--security-opt=no-new-privileges:true"
            ];
          };
          "ImmichML" = {
            image = "ghcr.io/immich-app/immich-machine-learning:release";
            volumes = [
              "/sata/.container/immich/ml:/cache:rw"
            ];
            log-driver = "journald";
            extraOptions = [
              "--network-alias=immich-machine-learning"
              "--network=panorama_default"
              "--security-opt=no-new-privileges:true"
            ];
          };
          "ImmichRedis" = {
            image = "docker.io/redis:6.2-alpine@sha256:328fe6a5822256d065debb36617a8169dbfbd77b797c525288e465f56c1d392b";
            volumes = [
              "/sata/.container/immich/cache:/data:rw"
            ];
            log-driver = "journald";
            extraOptions = [
              "--health-cmd=redis-cli ping || exit 1"
              "--network-alias=redis"
              "--network=panorama_default"
              "--security-opt=no-new-privileges:true"
            ];
          };
        };
      };
    };
  };
}
