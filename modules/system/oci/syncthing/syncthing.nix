{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.oci.syncthing;
in
{
  options.augs.oci.syncthing.enable = mkEnableOption "Syncthing Container";
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
        "podman-Syncthing" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-syncthing_Syncthing.service"
          ];
          requires = [
            "podman-network-syncthing_Syncthing.service"
          ];
          partOf = [
            "podman-compose-syncthing-root.target"
          ];
          wantedBy = [
            "podman-compose-syncthing-root.target"
          ];
        };
        "podman-network-syncthing_Syncthing" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f syncthing_Syncthing";
          };
          script = ''
            podman network inspect syncthing_Syncthing || podman network create syncthing_Syncthing --driver=bridge
          '';
          partOf = [ "podman-compose-syncthing-root.target" ];
          wantedBy = [ "podman-compose-syncthing-root.target" ];
        };
      };
      targets."podman-compose-syncthing-root" = {
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
          "Syncthing" = {
            image = "lscr.io/linuxserver/syncthing:latest";
            log-driver = "journald";
            environment = {
              PUID = "1000";
              PGID = "1000";
            };
            extraOptions = [
              "--network-alias=Sync"
              "--network=syncthing_Syncthing"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "8384:8384"
              "22000:22000/tcp"
              "22000:22000/udp"
              "21027:21027/udp"
            ];
            volumes = [
              "/sata/.container/syncthing/config:/config"
              "/sata/.container/syncthing/data:/Syncthing"
            ];
          };
        };
      };
    };
  };
}
