{
  flake.nixosModules.oci-immich = {
  config,
  pkgs,
  lib,
  ...
}: {
    sops = {
      secrets = {
        "services/immich/db_name" = {
          mode = "0400";
        };
        "services/immich/db_user" = {
          mode = "0400";
        };
        "services/immich/db_pass" = {
          mode = "0400";
        };
        "services/immich_db/db_name" = {
          mode = "0400";
        };
        "services/immich_db/db_user" = {
          mode = "0400";
        };
        "services/immich_db/db_pass" = {
          mode = "0400";
        };
      };
    };
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
    };

    networking.firewall.interfaces = let
      matchAll =
        if !config.networking.nftables.enable
        then "podman+"
        else "podman*";
    in {
      "${matchAll}".allowedUDPPorts = [53];
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
          path = [pkgs.podman];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f panorama_default";
          };
          script = ''
            podman network inspect panorama_default || podman network create panorama_default
          '';
          partOf = ["podman-compose-panorama-root.target"];
          wantedBy = ["podman-compose-panorama-root.target"];
        };
      };
      targets = {
        "podman-compose-panorama-root" = {
          unitConfig = {
            Description = "NAS Immich Root Target.";
          };
          wantedBy = ["multi-user.target"];
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
              "/srv/immich/upload:/usr/src/app/upload:rw"
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
            image = "ghcr.io/immich-app/postgres:14-vectorchord0.4.3-pgvectors0.2.0@sha256:bcf63357191b76a916ae5eb93464d65c07511da41e3bf7a8416db519b40b1c23";
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
              "/srv/immich/data:/var/lib/postgresql/data:rw"
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
              "/srv/immich/ml:/cache:rw"
            ];
            log-driver = "journald";
            extraOptions = [
              "--network-alias=immich-machine-learning"
              "--network=panorama_default"
              "--security-opt=no-new-privileges:true"
            ];
          };
          "ImmichRedis" = {
            image = "docker.io/valkey/valkey:9@sha256:8e8d64b405ce18f41b8e5ee20aa4687a8ed0022d1298f2ce31cdcf3a76e09411";
            volumes = [
              "/srv/immich/cache:/data:rw"
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
