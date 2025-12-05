{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
    ../../modules/profile/system
  ];
  home-manager.extraSpecialArgs = {
    vars = {
      user = "chandler";
    };
  };
  fileSystems = {
    "/persist/hdd" = {
      fsType = "xfs";
      device = "/dev/disk/by-uuid/d67c935f-2321-43fa-8135-32915d91f2b4";
    };
  };
  networking = {
    interfaces = {
      enp5s0 = {
        useDHCP = true;
      };
      enp6s0 = {
        useDHCP = true;
      };
    };
  };
  augs = {
    styles.mocha.enable = true;
    gui.hyprland.enable = true;
    profile = {
      client.enable = true;
      desktop.enable = true;
      monitoring.enable = true;
      virtualisation.enable = true;
    };
    com = {
      nvidiaGPU.enable = true;
      sops.enable = true;
    };
    svc = {
      flatpak.enable = true;
      sync-node.enable = true;
    };
  };
  # sops = {
  #   secrets = {
  #     "ssh/barrylabs" = {
  #       mode = "0400";
  #       sopsFile = ../../secrets/ssh.yaml;
  #     };
  #     "ssh/nixfleet" = {
  #       mode = "0400";
  #       sopsFile = ../../secrets/ssh.yaml;
  #     };
  #   };
  # };
}
