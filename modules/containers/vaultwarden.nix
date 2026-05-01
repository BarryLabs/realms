{
  config,
  pkgs,
  lib,
  ...
}: {
  flake.nixosModules.oci-vaultwarden = {
    sops = {
      secrets = {
        "services/vaultwarden/token" = {
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
        "podman-Vaultwarden" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-vault_Vault.service"
          ];
          requires = [
            "podman-network-vault_Vault.service"
          ];
          partOf = [
            "podman-compose-vaultwarden-root.target"
          ];
          wantedBy = [
            "podman-compose-vaultwarden-root.target"
          ];
        };
        "podman-network-vault_Vault" = {
          path = [pkgs.podman];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f vault_Vault";
          };
          script = ''
            podman network inspect vault_Vault || podman network create vault_Vault --driver=bridge
          '';
          partOf = ["podman-compose-vaultwarden-root.target"];
          wantedBy = ["podman-compose-vaultwarden-root.target"];
        };
      };
      targets."podman-compose-vaultwarden-root" = {
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
          "Vaultwarden" = {
            image = "vaultwarden/server:latest";
            log-driver = "journald";
            environmentFiles = [
              /run/secrets/services/vaultwarden/token
            ];
            extraOptions = [
              "--network-alias=vault"
              "--network=vault_Vault"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "5000:80/tcp"
            ];
            volumes = [
              "/srv/vaultwarden/data:/data:rw"
            ];
          };
        };
      };
    };
  };
}
