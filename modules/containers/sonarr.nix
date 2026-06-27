{
  flake.nixosModules.oci-sonarr = {
  config,
  pkgs,
  lib,
  ...
}: {
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
        "podman-Sonarr" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-sonarr_Sonarr.service"
          ];
          requires = [
            "podman-network-sonarr_Sonarr.service"
          ];
          partOf = [
            "podman-compose-sonarr-root.target"
          ];
          wantedBy = [
            "podman-compose-sonarr-root.target"
          ];
        };
        "podman-network-sonarr_Sonarr" = {
          path = [pkgs.podman];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f sonarr_Sonarr";
          };
          script = ''
            podman network inspect sonarr_Sonarr || podman network create sonarr_Sonarr --driver=bridge
          '';
          partOf = ["podman-compose-sonarr-root.target"];
          wantedBy = ["podman-compose-sonarr-root.target"];
        };
      };
      targets."podman-compose-sonarr-root" = {
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
          "Sonarr" = {
            image = "lscr.io/linuxserver/sonarr:latest";
            log-driver = "journald";
            environment = {
              "PUID" = "1000";
              "PGID" = "100";
            };
            environmentFiles = [
              /run/secrets/tz
            ];
            extraOptions = [
              "--network-alias=sub"
              "--network=sonarr_Sonarr"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "8989:8989/tcp"
            ];
            volumes = [
              "/srv/modules/sonarr/config:/config"
            ];
          };
        };
      };
    };
  };
}
