{
  flake.nixosModules.oci-filebrowser = {
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
        "podman-Filebrowser" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-file_File.service"
          ];
          requires = [
            "podman-network-file_File.service"
          ];
          partOf = [
            "podman-compose-filebrowser-root.target"
          ];
          wantedBy = [
            "podman-compose-filebrowser-root.target"
          ];
        };
        "podman-network-file_File" = {
          path = [pkgs.podman];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f file_File";
          };
          script = ''
            podman network inspect file_File || podman network create file_File --driver=bridge
          '';
          partOf = ["podman-compose-filebrowser-root.target"];
          wantedBy = ["podman-compose-filebrowser-root.target"];
        };
      };
      targets."podman-compose-filebrowser-root" = {
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
          "Filebrowser" = {
            image = "gtstef/filebrowser:stable";
            user = "vault";
            log-driver = "journald";
            extraOptions = [
              "--network-alias=file"
              "--network=file_File"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "80:80/tcp"
            ];
            volumes = [
              "/srv/filebrowser/files:/files:rw"
              "/srv/filebrowser/data:/home/filebrowser/data:rw"
            ];
          };
        };
      };
    };
  };
}
