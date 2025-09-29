{ pkgs, ... }:
{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];

  augs = {
    com = {
      bash.enable = true;
      bootGRUB.enable = true;
      environment = true;
      kernel.enable = true;
      locale.enable = true;
      nix.enable = true;
      nixpkgs.enable = true;
      openssh.enable = true;
      qemuguest.enable = true;
      settings.enable = true;
      sops.enable = false;
      state.enable = true;
      timezone.enable = true;
      users.enable = true;
    };
    services = {
      promtail.enable = false;
      node-exporter.enable = false;
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
  };

  services = {
    stubby = {
      enable = true;
      settings = pkgs.stubby.passthru.settings // {
        upstream_recursive_servers = [
          {
            address_data = "1.1.1.1";
            tls_auth_name = "cloudflare-dns.com";
            tls_pubkey_pinset = [
              {
                digest = "sha256";
                value = "SPfg6FluPIlUc6a5h313BDCxQYNGX+THTy7ig5X3+VA=";
              }
            ];
          }
          {
            address_data = "9.9.9.11";
            tls_auth_name = "dns11.quad9.net";
            tls_pubkey_pinset = [
              {
                digest = "sha256";
                value = "i2kObfz0qIKCGNWt7MjBUeSrh0Dyjb0/zWINImZES+I=";
              }
            ];
          }
          {
            address_data = "194.242.2.9";
            tls_auth_name = "all.dns.mullvad.net";
            tls_pubkey_pinset = [
              {
                digest = "sha256";
                value = "g8bfYNSxU86c8odFPsdTvWnC2VZkxIiHLZ2a6pydEjI=";
              }
            ];
          }
        ];
      };
    };
  };

  networking = {
    dhcpcd = {
      extraConfig = "nohook resolv.conf";
    };
    hosts = {
      "192.168.1.1" = [ "router.home" ];
      "192.168.30.5" = [ "media.home" ];
      "192.168.40.5" = [ "nas.home" ];
      "192.168.50.5" = [ "home.home" ];
      "192.168.60.5" = [ "proxy.home" ];
      "192.168.60.10" = [ "auth.home" ];
      "192.168.60.15" = [ "mail.home" ];
      "192.168.70.5" = [ "monitor.home" ];
    };
    nameservers = [ "127.0.0.1" ];
    firewall.enable = false;
    interfaces = {
      "enp3s0" = { };
      "enp4s0" = {
        useDHCP = false;
        ipv4 = {
          addresses = [
            {
              prefixLength = 24;
              address = "192.168.1.1";
            }
          ];
        };
      };
      "enp5s0" = {
        useDHCP = true;
      };
      "enp6s0" = { };
      vlan30.ipv4.addresses = [
        {
          prefixLength = 24;
          address = "192.168.30.1";
        }
      ];
    };
    vlans = {
      vlan5 = {
        id = 5;
        interface = "enp4s0";
      };
      vlan10 = {
        id = 10;
        interface = "enp4s0";
      };
      vlan15 = {
        id = 15;
        interface = "enp4s0";
      };
      vlan30 = {
        id = 30;
        interface = "enp4s0";
      };
      vlan40 = {
        id = 40;
        interface = "enp4s0";
      };
      vlan50 = {
        id = 50;
        interface = "enp4s0";
      };
      vlan60 = {
        id = 60;
        interface = "enp4s0";
      };
      vlan70 = {
        id = 70;
        interface = "enp4s0";
      };
    };
  };
}
