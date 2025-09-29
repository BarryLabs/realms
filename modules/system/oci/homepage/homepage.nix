{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.oci.homepage;
in
{
  options.augs.oci.homepage.enable = mkEnableOption "Homepage Container";
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
        "podman-Homepage" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-homepage_Homepage.service"
          ];
          requires = [
            "podman-network-homepage_Homepage.service"
          ];
          partOf = [
            "podman-compose-homepage-root.target"
          ];
          wantedBy = [
            "podman-compose-homepage-root.target"
          ];
        };
        "podman-network-homepage_Homepage" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f homepage_Homepage";
          };
          script = ''
            podman network inspect homepage_Homepage || podman network create homepage_Homepage --driver=bridge
          '';
          partOf = [ "podman-compose-homepage-root.target" ];
          wantedBy = [ "podman-compose-homepage-root.target" ];
        };
      };
      targets."podman-compose-homepage-root" = {
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
          "Homepage" = {
            image = "ghcr.io/benphelps/homepage:latest";
            log-driver = "journald";
            extraOptions = [
              "--network-alias=homepage"
              "--network=homepage_Homepage"
              "--security-opt=no-new-privileges"
            ];
            ports = [ "127.0.0.1:3000:3000" ];
            volumes = [
              "./config:/app/config"
              "/var/run/docker.sock:/var/run/docker.sock:ro"
            ];
          };
        };
      };
    };
  };
}
