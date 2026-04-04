{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "rustfs";
  cfg = config.augs.oci.${module};
in
{
  options.augs.oci.${module}.enable = mkEnableOption "RustFS Container";
  config = mkIf cfg.enable {
    sops = {
      secrets = {
        "services/rustfs/access" = {
          mode = "0400";
        };
        "services/rustfs/secret" = {
          mode = "0400";
        };
      };
    };
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
        "podman-RustFS" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-rfs_RFS.service"
          ];
          requires = [
            "podman-network-rfs_RFS.service"
          ];
          partOf = [
            "podman-compose-rustfs-root.target"
          ];
          wantedBy = [
            "podman-compose-rustfs-root.target"
          ];
        };
        "podman-network-rfs_RFS" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f rfs_RFS";
          };
          script = ''
            podman network inspect rfs_RFS || podman network create rfs_RFS --driver=bridge
          '';
          partOf = [ "podman-compose-rustfs-root.target" ];
          wantedBy = [ "podman-compose-rustfs-root.target" ];
        };
      };
      targets."podman-compose-rustfs-root" = {
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
          "RustFS" = {
            image = "rustfs/rustfs:latest";
            log-driver = "journald";
            environment = {
              "RUSTFS_CONSOLE_ENABLE" = "true";
              "RUSTFS_CONSOLE_ADDRESS" = "0.0.0.0:9001";
              "RUSTFS_ADDRESS" = "0.0.0.0:11000";
              "RUSTFS_TLS_PATH" = "/opt/tls";
              "RUSTFS_EXTERNAL_ADDRESS" = ":11000";
              "RUSTFS_CORS_ALLOWED_ORIGINS" = "*";
              "RUSTFS_CONSOLE_CORS_ALLOWED_ORIGINS" = "*";
            };
            environmentFiles = [
              /run/secrets/services/rustfs/access
              /run/secrets/services/rustfs/secret          
            ];
            extraOptions = [
              "--network-alias=rfs"
              "--network=rfs_RFS"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "11000:9000/tcp"
              "9001:9001/tcp"
            ];
            volumes = [
              "/srv/rustfs/data:/data"
              "/srv/rustfs/logs:/app/logs"
              "/srv/rustfs/tls:/opt/tls"
            ];
          };
        };
      };
    };
  };
}
