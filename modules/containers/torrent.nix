{
  config,
  pkgs,
  lib,
  ...
}: {
  flake.nixosModules.oci-torrent = {
    sops = {
      secrets = {
        "vpn/provider" = {
          mode = "0400";
        };
        "vpn/type" = {
          mode = "0400";
        };
        "vpn/addresses" = {
          mode = "0400";
        };
        "vpn/key" = {
          mode = "0400";
        };
      };
    };
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
    };
    networking.firewall.interfaces = let
      matchAll =
        if !config.networking.nftables.enable
        then "podman+"
        else "podman*";
    in {
      "${matchAll}".allowedUDPPorts = [53];
    };
    systemd = {
      services = {
        "podman-VPN" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          after = [
            "podman-network-torrent_Torrent.service"
          ];
          requires = [
            "podman-network-torrent_Torrent.service"
          ];
          partOf = [
            "podman-compose-torrent-root.target"
          ];
          wantedBy = [
            "podman-compose-torrent-root.target"
          ];
        };
        "podman-qBittorrent" = {
          serviceConfig = {
            Restart = lib.mkOverride 90 "always";
          };
          partOf = [
            "podman-compose-torrent-root.target"
          ];
          wantedBy = [
            "podman-compose-torrent-root.target"
          ];
        };
        "podman-network-torrent_Torrent" = {
          path = [pkgs.podman];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStop = "podman network rm -f torrent_Torrent";
          };
          script = ''
            podman network inspect torrent_Torrent || podman network create torrent_Torrent
          '';
          partOf = ["podman-compose-torrent-root.target"];
          wantedBy = ["podman-compose-torrent-root.target"];
        };
      };
      targets = {
        "podman-compose-torrent-root" = {
          unitConfig = {
            Description = "Media Torrent Root Target.";
          };
          wantedBy = ["multi-user.target"];
        };
      };
    };
    virtualisation = {
      oci-containers = {
        backend = "podman";
        containers = {
          "VPN" = {
            image = "qmcgaw/gluetun";
            environmentFiles = [
              /run/secrets/tz
              /run/secrets/vpn/provider
              /run/secrets/vpn/type
              /run/secrets/vpn/addresses
              /run/secrets/vpn/key
            ];
            volumes = [
              "/srv/modules/gluetun/config:/gluetun:rw"
            ];
            ports = [
              "6881:6881/tcp"
              "6881:6881/udp"
              "8080:8080/tcp"
            ];
            log-driver = "journald";
            extraOptions = [
              "--cap-add=NET_ADMIN"
              "--device=/dev/net/tun:/dev/net/tun:rwm"
              "--network-alias=VPN"
              "--network=torrent_Torrent"
              "--security-opt=no-new-privileges:true"
            ];
          };
          "qBittorrent" = {
            image = "lscr.io/linuxserver/qbittorrent:latest";
            environment = {
              "PUID" = "1000";
              "PGID" = "100";
              "WEBUI_PORT" = "8080";
            };
            environmentFiles = [
              /run/secrets/tz
            ];
            volumes = [
              "/srv/modules/qbittorrent/config:/config:rw"
              "/srv/Media/sort:/downloads:rw"
            ];
            dependsOn = [
              "VPN"
            ];
            log-driver = "journald";
            extraOptions = [
              "--network=container:VPN"
              "--security-opt=no-new-privileges:true"
            ];
          };
        };
      };
    };
  };
}
