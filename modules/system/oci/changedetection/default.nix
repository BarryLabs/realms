{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "changedetection";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "ChangeDetection Container";
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
        "podman-ChangeDetection" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-C_D.service"
          ];
          requires = [
            "podman-network-C_D.service"
          ];
          partOf = [
            "podman-compose-cd-root.target"
          ];
          wantedBy = [
            "podman-compose-cd-root.target"
          ];
        };
        "podman-network-C_D" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f C_D";
          };
          script = ''
            podman network inspect C_D || podman network create C_D --driver=bridge
          '';
          partOf = [ "podman-compose-cd-root.target" ];
          wantedBy = [ "podman-compose-cd-root.target" ];
        };
      };
      targets."podman-compose-cd-root" = {
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
          "ChangeDetection" = {
            image = "lscr.io/linuxserver/changedetection.io:latest";
            log-driver = "journald";
            ports = [
	      "5000:5000/tcp"
	    ];
	    environment = {
              "PUID" = "1000";
              "PGID" = "1000";
            };
            environmentFiles = [
              /run/secrets/tz
            ];
            extraOptions = [
              "--network-alias=cd"
              "--network=C_D"
              "--security-opt=no-new-privileges"
            ];
          };
        };
      };
    };
  };
}
