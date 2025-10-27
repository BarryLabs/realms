{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "template";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "OCI template for Nix";
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
        "podman-*" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-*_*.service"
          ];
          requires = [
            "podman-network-*_*.service"
          ];
          partOf = [
            "podman-compose-*-root.target"
          ];
          wantedBy = [
            "podman-compose-*-root.target"
          ];
        };
        "podman-network-*" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f *";
          };
          script = ''
            podman network inspect * || podman network create * --driver=bridge
          '';
          partOf = [ "podman-compose-*-root.target" ];
          wantedBy = [ "podman-compose-*-root.target" ];
        };
      };
      targets."podman-compose-*-root" = {
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
          "*" = {
            hostname = "*";
            image = "";
            log-driver = "journald";
            extraOptions = [
              # "--device=/dev/dri:/dev/dri:rwm"
              "--network-alias=*"
              "--network=*_*"
              "--security-opt=no-new-privileges"
            ];
          };
        };
      };
    };
  };
}
