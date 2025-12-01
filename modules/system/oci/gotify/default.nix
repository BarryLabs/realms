{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "gotify";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "Gotify Container";
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
        "podman-Gotify" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-gotify_Gotify.service"
          ];
          requires = [
            "podman-network-gotify_Gotify.service"
          ];
          partOf = [
            "podman-compose-gotify-root.target"
          ];
          wantedBy = [
            "podman-compose-gotify-root.target"
          ];
        };
        "podman-network-gotify_Gotify" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f gotify_Gotify";
          };
          script = ''
            podman network inspect gotify_Gotify || podman network create gotify_Gotify --driver=bridge
          '';
          partOf = [ "podman-compose-gotify-root.target" ];
          wantedBy = [ "podman-compose-gotify-root.target" ];
        };
      };
      targets."podman-compose-gotify-root" = {
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
          "Gotify" = {
            image = "ghcr.io/gotify/server";
            log-driver = "journald";
            extraOptions = [
              "--network-alias=gotify"
              "--network=gotify_Gotify"
              "--security-opt=no-new-privileges"
            ];
            volumes = [ "./gotify:/app/data" ];
          };
        };
      };
    };
  };
}
