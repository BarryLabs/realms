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
              "RUSTFS_ADDRESS" = "0.0.0.0:9000";
              "RUSTFS_TLS_PATH" = "/opt/tls";
              "RUSTFS_CONSOLE_ENABLE" = "true";
              "RUSTFS_CONSOLE_ADDRESS" = "0.0.0.0:9001";
              "RUSTFS_EXTERNAL_ADDRESS" = ":9000";
              "RUSTFS_CORS_ALLOWED_ORIGINS" = "*";
              "RUSTFS_CONSOLE_CORS_ALLOWED_ORIGINS" = "*";
            };
            extraOptions = [
              "--network-alias=rfs"
              "--network=rfs_RFS"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "9000:9000/tcp"
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
