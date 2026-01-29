{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../profiles/system
    ../../modules/system
  ];

  augs = {
    com = {
      bootGRUB.enable = true;
      vmVariant.enable = true;
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      curl
      john
      nmap
      aircrack-ng
      tcpdump
      metasploit
      nikto
      proxychains
    ];
  };

  virtualisation = {
    vmVariant = {
      virtualisation = {
        cores = lib.mkForce 4;
        memorySize = lib.mkForce 4096;
        diskSize = lib.mkForce 32768;
      };
    };
  };
}
