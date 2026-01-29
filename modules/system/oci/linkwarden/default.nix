{ pkgs, lib, config, ... }:
with lib;
let
  module = "linkwarden";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "Linkwarden Container";
  config = mkIf cfg.enable {
    sops = {
      secrets = {
        "services/linkwarden/nextauth_key" = {
          mode = "0400";
        };
        "services/linkwarden/meili_key" = {
          mode = "0400";
        };
        "services/linkwarden/db_key" = {
          mode = "0400";
        };
        "services/linkwarden/db_url" = {
          mode = "0400";
        };
      };
    };
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
    };

    networking.firewall.interfaces = let
      matchAll = if !config.networking.nftables.enable then "podman+" else "podman*";
    in {
      "${matchAll}".allowedUDPPorts = [ 53 ];
    };

    systemd = {
      targets = {
        "podman-compose-linkwarden-root" = {
          unitConfig = {
            Description = "Root Target";
          };
          wantedBy = [ "multi-user.target" ];
        };
      };
      services = {
        "podman-network-linkwarden_Linkwarden" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f linkwarden_Linkwarden";
          };
          script = ''
            podman network inspect linkwarden_Linkwarden || podman network create linkwarden_Linkwarden
          '';
          partOf = [ "podman-compose-linkwarden-root.target" ];
          wantedBy = [ "podman-compose-linkwarden-root.target" ];
        };
        "podman-Linkwarden" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-linkwarden_Linkwarden.service"
          ];
          requires = [
            "podman-network-linkwarden_Linkwarden.service"
          ];
          partOf = [
          "podman-compose-linkwarden-root.target"
          ];
          wantedBy = [
            "podman-compose-linkwarden-root.target"
          ];
        };
        "podman-LinkwardenMeilisearch" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-linkwarden_Linkwarden.service"
          ];
          requires = [
            "podman-network-linkwarden_Linkwarden.service"
          ];
          partOf = [
            "podman-compose-linkwarden-root.target"
          ];
          wantedBy = [
            "podman-compose-linkwarden-root.target"
          ];
        };
        "podman-LinkwardenDB" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-linkwarden_Linkwarden.service"
          ];
          requires = [
            "podman-network-linkwarden_Linkwarden.service"
          ];
          partOf = [
            "podman-compose-linkwarden-root.target"
          ];
          wantedBy = [
            "podman-compose-linkwarden-root.target"
          ];
        };
      };
    };

    virtualisation = {
      oci-containers = {
        backend = "podman";
        containers = {
          "Linkwarden" = {
            image = "ghcr.io/linkwarden/linkwarden:latest";
            environment = {
              "NEXTAUTH_URL" = "http://localhost:4000/api/v1/auth";
            };
            environmentFiles = [
              /run/secrets/services/linkwarden/nextauth_key
              /run/secrets/services/linkwarden/meili_key
              /run/secrets/services/linkwarden/db_key
              /run/secrets/services/linkwarden/db_url
            ];
            volumes = [
              "/srv/linkwarden/data:/data/data:rw"
            ];
            ports = [
              "4000:3000/tcp"
            ];
            dependsOn = [
              "LinkwardenMeilisearch"
              "LinkwardenDB"
            ];
            log-driver = "journald";
            extraOptions = [
              "--network-alias=linkwarden"
              "--network=linkwarden_Linkwarden"
              "--security-opt=no-new-privileges:true"
            ];
          };
          "LinkwardenMeilisearch" = {
            image = "getmeili/meilisearch:v1.12.8";
            environment = {
              "NEXTAUTH_URL" = "http://localhost:4000/api/v1/auth";
            };
            environmentFiles = [
              /run/secrets/services/linkwarden/nextauth_key
              /run/secrets/services/linkwarden/meili_key
              /run/secrets/services/linkwarden/db_key
            ];
            volumes = [
              "/srv/linkwarden/meili_data:/meili_data:rw"
            ];
            log-driver = "journald";
            extraOptions = [
              "--network-alias=meilisearch"
              "--network=linkwarden_Linkwarden"
              "--security-opt=no-new-privileges:true"
            ];
          };
          "LinkwardenDB" = {
            image = "postgres:16-alpine";
            environment = {
              "NEXTAUTH_URL" = "http://localhost:4000/api/v1/auth";
            };
            environmentFiles = [
              /run/secrets/services/linkwarden/nextauth_key
              /run/secrets/services/linkwarden/meili_key
              /run/secrets/services/linkwarden/db_key
            ];
            volumes = [
              "/srv/linkwarden/postgres:/var/lib/postgresql/data:rw"
            ];
            log-driver = "journald";
            extraOptions = [
              "--network-alias=postgres"
              "--network=linkwarden_Linkwarden"
              "--security-opt=no-new-privileges:true"
            ];
          };
        };
      };
    };    
  };
}
