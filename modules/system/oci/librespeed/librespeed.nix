{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.oci.librespeed;
in
{
  options.augs.oci.librespeed.enable = mkEnableOption "Librespeed Container";
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
        "podman-Librespeed" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-librespeed_Librespeed.service"
          ];
          requires = [
            "podman-network-librespeed_Librespeed.service"
          ];
          partOf = [
            "podman-compose-librespeed-root.target"
          ];
          wantedBy = [
            "podman-compose-librespeed-root.target"
          ];
        };
        "podman-network-librespeed_Librespeed" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f librespeed_Librespeed";
          };
          script = ''
            podman network inspect librespeed_Librespeed || podman network create librespeed_Librespeed --driver=bridge
          '';
          partOf = [ "podman-compose-librespeed-root.target" ];
          wantedBy = [ "podman-compose-librespeed-root.target" ];
        };
      };
      targets."podman-compose-librespeed-root" = {
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
          "Librespeed" = {
            image = "lscr.io/linuxserver/librespeed:latest";
            log-driver = "journald";
            environment = {
              PUID = 1000;
              PGID = 1000;
              TZ = "America/New_York";
              # PASSWORD = "password";
            };
            environmentFiles = [
              /run/secrets/librespeed
            ];
            extraOptions = [
              "--network-alias=librespeed"
              "--network=librespeed_Librespeed"
              "--security-opt=no-new-privileges"
            ];
          };
        };
      };
    };
  };
}
