{
  flake.nixosModules.oci-pgadmin = {
  config,
  pkgs,
  lib,
  ...
}: {
    sops = {
      secrets = {
        "services/pgadmin/default_email" = {
          mode = "0400";
        };
        "services/pgadmin/default_pass" = {
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
        "podman-pgAdmin" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-pgadmin_Pgadmin.service"
          ];
          requires = [
            "podman-network-pgadmin_Pgadmin.service"
          ];
          partOf = [
            "podman-compose-pgadmin-root.target"
          ];
          wantedBy = [
            "podman-compose-pgadmin-root.target"
          ];
        };
        "podman-network-pgadmin_Pgadmin" = {
          path = [pkgs.podman];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f pgadmin_Pgadmin";
          };
          script = ''
            podman network inspect pgadmin_Pgadmin || podman network create pgadmin_Pgadmin --driver=bridge
          '';
          partOf = ["podman-compose-pgadmin-root.target"];
          wantedBy = ["podman-compose-pgadmin-root.target"];
        };
      };
      targets."podman-compose-pgadmin-root" = {
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
          "pgAdmin" = {
            image = "dpage/pgadmin4:latest";
            log-driver = "journald";
            environmentFiles = [
              /run/secrets/services/pgadmin/default_email
              /run/secrets/services/pgadmin/default_pass
            ];
            extraOptions = [
              "--network-alias=pgadmin"
              "--network=pgadmin_Pgadmin"
            ];
            ports = [
              "9000:80/tcp"
            ];
          };
        };
      };
    };
  };
}
