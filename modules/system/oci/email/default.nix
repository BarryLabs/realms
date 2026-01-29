{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "email"
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.template.enable = mkEnableOption "Email Container";
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
        "podman-Email" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-email_Email.service"
          ];
          requires = [
            "podman-network-email_Email.service"
          ];
          partOf = [
            "podman-compose-email-root.target"
          ];
          wantedBy = [
            "podman-compose-email-root.target"
          ];
        };
        "podman-network-email_Email" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f email_Email";
          };
          script = ''
            podman network inspect email_Email || podman network create email_Email --driver=bridge
          '';
          partOf = [ "podman-compose-email-root.target" ];
          wantedBy = [ "podman-compose-email-root.target" ];
        };
      };
      targets."podman-compose-email-root" = {
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
          "Mailserver" = {
            image = "ghcr.io/docker-mailserver/docker-mailserver:latest";
            log-driver = "journald";
            extraOptions = [
              "--network-alias=mail"
              "--network=email_Email"
              "--security-opt=no-new-privileges"
            ];
          };
        };
      };
    };
  };
}
