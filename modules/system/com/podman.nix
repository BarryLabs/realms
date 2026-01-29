{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "podman";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Podman Module";
  config = mkIf cfg.enable {
    boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;
    environment = {
      variables = {
        DBX_CONTAINER_MANAGER = "podman";
      };
      systemPackages = with pkgs; [
        podman-compose
      ];
    };
    users.extraGroups.podman.members = [ config.var.user ];
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
        wantedBy = [ "timers.target" ];
      };
      restart-podman-containers = {
        timerConfig = {
          Unit = "restart-podman-containers.service";
          OnCalendar = "Mon 01:00";
        };
        wantedBy = [ "timers.target" ];
      };
    };
    systemd.services = {
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
    };
  };
}
