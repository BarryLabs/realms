{
  flake.nixosModules.oci-copyparty = {
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
        "podman-Copyparty" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-copy_Copy.service"
          ];
          requires = [
            "podman-network-copy_Copy.service"
          ];
          partOf = [
            "podman-compose-copyparty-root.target"
          ];
          wantedBy = [
            "podman-compose-copyparty-root.target"
          ];
        };
        "podman-network-copy_Copy" = {
          path = [pkgs.podman];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f copy_Copy";
          };
          script = ''
            podman network inspect copy_Copy || podman network create copy_Copy --driver=bridge
          '';
          partOf = ["podman-compose-copyparty-root.target"];
          wantedBy = ["podman-compose-copyparty-root.target"];
        };
      };
      targets."podman-compose-copyparty-root" = {
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
          "Copyparty" = {
            image = "copyparty/ac:latest";
            user = "1000:100";
            log-driver = "journald";
            environment = {
              "LD_PRELOAD" = "/usr/lib/libmimalloc-secure.so.NOPE";
              "PYTHONUNBUFFERED" = "1";
            };
            extraOptions = [
              "--network-alias=file"
              "--network=file_File"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "3923:3923/tcp"
            ];
            volumes = [
              "/srv/copyparty/files:/w:rw"
              "/srv/copyparty/config:/cfg:rw"
            ];
          };
        };
      };
    };
  };
}
