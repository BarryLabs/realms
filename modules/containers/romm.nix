{
  flake.nixosModules.oci-romm = {
  config,
  pkgs,
  lib,
  ...
}: {
    sops = {
      secrets = {
        "services/romm/user" = {
          mode = "0400";
        };
        "services/romm/name" = {
          mode = "0400";
        };
        "services/romm/pass" = {
          mode = "0400";
        };
        "services/romm/auth-key" = {
          mode = "0400";
        };
        "services/romm/retroachievements_key" = {
          mode = "0400";
        };
        "services/romm/steamgrid_key" = {
          mode = "0400";
        };
        "services/romm/db/user" = {
          mode = "0400";
        };
        "services/romm/db/name" = {
          mode = "0400";
        };
        "services/romm/db/pass" = {
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
        "podman-Romm" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-romm_Romm.service"
          ];
          requires = [
            "podman-network-romm_Romm.service"
          ];
          partOf = [
            "podman-compose-romm-root.target"
          ];
          wantedBy = [
            "podman-compose-romm-root.target"
          ];
        };
        "podman-network-romm_Romm" = {
          path = [pkgs.podman];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f romm_Romm";
          };
          script = ''
            podman network inspect romm_Romm || podman network create romm_Romm --driver=bridge
          '';
          partOf = ["podman-compose-romm-root.target"];
          wantedBy = ["podman-compose-romm-root.target"];
        };
      };
      targets."podman-compose-romm-root" = {
        unitConfig = {
          Description = "Root Target";
        };
        wantedBy = ["multi-user.target"];
      };
    };

    virtualisation = {
      oci-containers = {
        backend = "podman";
        containers = {
          "Romm" = {
            image = "rommapp/romm:latest";
            log-driver = "journald";
            environment = {
              "DB_HOST" = "Romm-DB";
              "HASHEOUS_API_ENABLED" = "true";
              "ROMM_DB_DRIVER" = "postgresql";
              "DB_PORT" = "5432";
            };
            environmentFiles = [
              /run/secrets/services/romm/name
              /run/secrets/services/romm/user
              /run/secrets/services/romm/pass
              /run/secrets/services/romm/auth-key
              /run/secrets/services/romm/retroachievements_key
              /run/secrets/services/romm/steamgrid_key
            ];
            extraOptions = [
              "--device=/dev/dri:/dev/dri:rwm"
              "--network-alias=romm"
              "--network=romm_Romm"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "10000:8080/tcp"
            ];
            volumes = [
              "/srv/romm/resource:/romm/resource"
              "/srv/romm/library:/romm/library"
            ];
          };
          "Romm-DB" = {
            image = "postgres:16-alpine";
            log-driver = "journald";
            environmentFiles = [
              /run/secrets/services/romm/db/name
              /run/secrets/services/romm/db/user
              /run/secrets/services/romm/db/pass
            ];
            extraOptions = [
              "--network-alias=romm"
              "--network=romm_Romm"
              "--security-opt=no-new-privileges"
            ];
            volumes = [
              "/srv/romm/db:/var/lib/postgresql/data"
            ];
          };
        };
      };
    };
  };
}
