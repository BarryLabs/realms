{ pkgs
, lib
, ...
}: {
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];

  augs = {
    com = {
      bash.enable = true;
      bootGRUB.enable = true;
      cpu.enable = false;
      docs.enable = true;
      environment.enable = true;
      governor.enable = true;
      kernel.enable = true;
      locale.enable = true;
      network.enable = true;
      nix.enable = true;
      nixpkgs.enable = true;
      openssh.enable = true;
      qemuguest.enable = true;
      sops.enable = false;
      state.enable = true;
      timezone.enable = true;
      users.enable = true;
      vmVariant.enable = true;
    };
    services = {
      node-exporter.enable = false;
      promtail.enable = false;
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
