{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.oci.filebrowser;
in
{
  options.augs.oci.filebrowser.enable = mkEnableOption "Filebrowser Container";
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
        "podman-Filebrowser" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-filebrowser_Filebrowser.service"
          ];
          requires = [
            "podman-network-filebrowser_Filebrowser.service"
          ];
          partOf = [
            "podman-compose-filebrowser-root.target"
          ];
          wantedBy = [
            "podman-compose-filebrowser-root.target"
          ];
        };
        "podman-network-filebrowser_Filebrowser" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f filebrowser_Filebrowser";
          };
          script = ''
            podman network inspect filebrowser_Filebrowser || podman network create filebrowser_Filebrowser --driver=bridge
          '';
          partOf = [ "podman-compose-filebrowser-root.target" ];
          wantedBy = [ "podman-compose-filebrowser-root.target" ];
        };
      };
      targets."podman-compose-filebrowser-root" = {
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
          "Filebrowser" = {
            image = "gtstef/filebrowser";
            log-driver = "journald";
            environmentFiles = [
              /run/secrets/services/filebrowser/admin_pass
            ];
            extraOptions = [
              "--hostname=filebrowser"
              "--network-alias=filebrowser"
              "--network=filebrowser_Filebrowser"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "80:80/tcp"
            ];
            volumes = [
              "/sata/.container/filebrowser/folder:/folder"
              "/sata/.container/filebrowser/data:/home/filebrowser/data:rw"
              "/sata/.container/filebrowser/config.yaml:/home/filebrowser/config.yaml:ro"
            ];
          };
        };
      };
    };
  };
}
