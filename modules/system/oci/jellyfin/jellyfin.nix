{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.oci.jellyfin;
in
{
  options.augs.oci.jellyfin.enable = mkEnableOption "Jellyfin Container";
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
        "podman-Jellyfin" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-media_Media.service"
          ];
          requires = [
            "podman-network-media_Media.service"
          ];
          partOf = [
            "podman-compose-jellyfin-root.target"
          ];
          wantedBy = [
            "podman-compose-jellyfin-root.target"
          ];
        };
        "podman-network-media_Media" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f media_Media";
          };
          script = ''
            podman network inspect media_Media || podman network create media_Media --driver=bridge
          '';
          partOf = [ "podman-compose-jellyfin-root.target" ];
          wantedBy = [ "podman-compose-jellyfin-root.target" ];
        };
      };
      targets."podman-compose-jellyfin-root" = {
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
          "Jellyfin" = {
            image = "lscr.io/linuxserver/jellyfin:latest";
            log-driver = "journald";
            extraOptions = [
              "--device=/dev/dri:/dev/dri:rwm"
              "--network-alias=theater"
              "--network=media_Media"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "8096:8096/tcp"
            ];
            volumes = [
              ""
              ""
              ""
              ""
              ""
            ];
          };
        };
      };
    };
  };
}
