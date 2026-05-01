{
  config,
  pkgs,
  lib,
  ...
}: {
  flake.nixosModules.podman = {
    boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;
    environment = {
      variables = {
        DBX_CONTAINER_MANAGER = "podman";
      };
      systemPackages = with pkgs; [
        podman-compose
      ];
    };
    users.extraGroups.podman.members = [config.var.user];
    virtualisation = {
      podman = {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
        dockerCompat = true;
        autoPrune = {
          enable = true;
          dates = "weekly";
          flags = [
            "--all"
          ];
        };
      };
    };
    systemd.timers = {
      update-podman-containers = {
        timerConfig = {
          Unit = "update-podman-containers.service";
          OnCalendar = "Mon 00:00";
        };
        wantedBy = ["timers.target"];
      };
      restart-podman-containers = {
        timerConfig = {
          Unit = "restart-podman-containers.service";
          OnCalendar = "Mon 01:00";
        };
        wantedBy = ["timers.target"];
      };
    };
    systemd.services =
      if config.networking.hostName != "yggdrasil"
      then {
        update-podman-containers = {
          serviceConfig = {
            Type = "oneshot";
            ExecStart = lib.getExe (
              pkgs.writeShellScriptBin "update-podman-containers" ''
                images=$(${pkgs.podman}/bin/podman ps -a --format="{{.Image}}" | sort -u)

                for image in $images; do
                  ${pkgs.podman}/bin/podman pull "$image"
                done
              ''
            );
          };
        };
        restart-podman-containers = {
          serviceConfig = {
            Type = "oneshot";
            ExecStart = lib.getExe (
              pkgs.writeShellScriptBin "restart-podman-containers" ''
                ${pkgs.podman}/bin/podman restart -a
              ''
            );
          };
        };
      }
      else {};
  };
  flake.homeModules.podman = {pkgs, ...}: {
    home.packages = with pkgs; [
      podman-compose
    ];
    services = {
      podman = {
        enable = true;
        autoUpdate = {
          enable = true;
          onCalendar = "Sun *-*-* 00:00";
        };
        settings = {
          registries = {
            search = [
              "quay.io"
              "docker.io"
            ];
          };
        };
      };
    };
  };
}
