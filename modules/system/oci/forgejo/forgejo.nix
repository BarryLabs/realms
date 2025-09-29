{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.oci.forgejo;
in
{
  options.augs.oci.forgejo.enable = mkEnableOption "Forgejo Container";
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
        "podman-Forgejo" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-forgejo_Forgejo.service"
          ];
          requires = [
            "podman-network-forgejo_Forgejo.service"
          ];
          partOf = [
            "podman-compose-forgejo-root.target"
          ];
          wantedBy = [
            "podman-compose-forgejo-root.target"
          ];
        };
        "podman-network-forgejo_Forgejo" = {
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f forgejo_Forgejo";
          };
          script = ''
            podman network inspect forgejo_Forgejo || podman network create forgejo_Forgejo --driver=bridge
          '';
          partOf = [ "podman-compose-forgejo-root.target" ];
          wantedBy = [ "podman-compose-forgejo-root.target" ];
        };
      };
      targets."podman-compose-forgejo-root" = {
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
          "Forgejo" = {
            # labels = {
            #   "traefik.https.routers.example.rule" = "Host(`example.container`)";
            # };
            image = "codeberg.org/forgejo/forgejo:11";
            log-driver = "journald";
            environment = {
              USER_UID = 1000;
              USER_GID = 1000;
            };
            extraOptions = [
              "--network-alias=forgejo"
              "--network=forgejo_Forgejo"
              "--security-opt=no-new-privileges"
            ];
            ports = [
              "222:22"
              "3000:3000"
            ];
            volumes = [
              "./data:/data"
              "/etc/timezone:/etc/timezone:ro"
              "/etc/localtime:/etc/localtime:ro"
            ];
          };
        };
      };
    };
  };
}
