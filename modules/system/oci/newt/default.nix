{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "newt";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "Newt Container";
  config = mkIf cfg.enable {
    sops = {
      secrets = {
        "endpoint" = {
          mode = "0400";
        };
        "id" = {
          mode = "0400";
        };
        "secret" = {
          mode = "0400";
        };
      };
    };
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
        "podman-Newt" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-tun_Newt.service"
          ];
          requires = [
            "podman-network-tun_Newt.service"
          ];
          partOf = [
            "podman-compose-newt-root.target"
          ];
          wantedBy = [
            "podman-compose-newt-root.target"
          ];
        };
        "podman-network-tun_Newt" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f tun_Newt";
          };
          script = ''
            podman network inspect tun_Newt || podman network create tun_Newt --driver=bridge
          '';
          partOf = [ "podman-compose-newt-root.target" ];
          wantedBy = [ "podman-compose-newt-root.target" ];
        };
      };
      targets."podman-compose-newt-root" = {
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
          "Newt" = {
            image = "fosrl/newt:latest";
            log-driver = "journald";
            environment = {
              "LOG_LEVEL" = "debug";
            };
            environmentFiles = [
              /run/secrets/id
              /run/secrets/secret
              /run/secrets/endpoint
            ];
            extraOptions = [
              "--network-alias=tun"
              "--network=tun_Newt"
              "--security-opt=no-new-privileges"
            ];
          };
        };
      };
    };
  };
}
