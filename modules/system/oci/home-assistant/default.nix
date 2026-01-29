{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "home-assistant";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "Home Assistant Container";
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
        "podman-HomeAssistant" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-home_Home.service"
          ];
          requires = [
            "podman-network-home_Home.service"
          ];
          partOf = [
            "podman-compose-homeassistant-root.target"
          ];
          wantedBy = [
            "podman-compose-homeassistant-root.Target"
          ];
        };
        "podman-network-home_Home" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f home_Home";
          };
          script = ''
            podman network inspect home_Home || podman network create home_Home --driver=bridge
          '';
          partOf = [ "podman-compose-homeassistant-root.target" ];
          wantedBy = [ "podman-compose-homeassistant-root.target" ];
        };
      };
      targets."podman-compose-homeassistant-root" = {
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
          "HomeAssistant" = {
            image = "";
            log-driver = "journald";
            environment = {
              "PUID" = "1000";
              "PGID" = "1000";
            };
            environmentFiles = [
              /run/secrets/home-assistant/tz
            ];
            extraOptions = [
              # "--device=/dev/dri:/dev/dri:rwm"
              "--network-alias=home"
              "--network=home_Home"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "8096:8096/tcp"
            ];
            volumes = [
              "/srv/modules/home-assistant/cache:/cache"
              "/srv/modules/home-assistant/config:/config"
            ];
          };
        };
      };
    };
  };
}
