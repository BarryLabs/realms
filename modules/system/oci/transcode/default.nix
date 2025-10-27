{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "transcode";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "enable tdarr";
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
        "podman-Tdarr" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-transcode_Transcode.service"
          ];
          requires = [
            "podman-network-transcode_Transcode.service"
          ];
          partOf = [
            "podman-compose-transcode-root.target"
          ];
          wantedBy = [
            "podman-compose-transcode-root.target"
          ];
        };
        "podman-network-transcode_Transcode" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f transcode_Transcode";
          };
          script = ''
            podman network inspect transcode_Transcode || podman network create transcode_Transcode
          '';
          partOf = [ "podman-compose-transcode-root.target" ];
          wantedBy = [ "podman-compose-transcode-root.target" ];
        };
      };
      targets = {
        "podman-compose-transcode-root" = {
          unitConfig = {
            Description = "Transcode Podman Quadlet Root Target";
          };
          wantedBy = [ "multi-user.target" ];
        };
      };
    };
    virtualisation = {
      oci-containers = {
        backend = "podman";
        containers = {
          "Tdarr" = {
            image = "ghcr.io/haveagitgat/tdarr:latest";
            environment = {
              "PGID" = "1000";
              "PUID" = "1000";
              "TZ" = "America/New_York";
              "UMASK_SET" = "002";
              "ffmpegVersion" = "7";
              "inContainer" = "true";
              "internalNode" = "true";
              "nodeName" = "farmInternalNode";
              "serverIP" = "0.0.0.0";
              "serverPort" = "8266";
              "webUIPort" = "8265";
            };
            volumes = [
              "/home/shiva/.services/Containers/Tdarr/configs:/app/configs:rw"
              "/home/shiva/.services/Containers/Tdarr/logs:/app/logs:rw"
              "/home/shiva/.services/Containers/Tdarr/server:/app/server:rw"
              "/srv/Media/Sort:/media:rw"
              "/srv/Media/tCache:/temp:rw"
            ];
            ports = [
              "8265:8265/tcp"
              "8266:8266/tcp"
            ];
            log-driver = "journald";
            extraOptions = [
              "--device=/dev/dri:/dev/dri:rwm"
              "--network-alias=Tdarr"
              "--network=transcode_Transcode"
              "--security-opt=no-new-privileges"
            ];
          };
        };
      };
    };
  };
}
