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
  # fileSystems = {
  #   "/mnt/Storage" = {
  #     fsType = "xfs";
  #     device = "/dev/disk/by-uuid/CC3A7A573A7A3F10";
  #   };
  # };
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
    backup.yggdrasil.enable = false;
    styles.mocha.enable = true;
    gui.hyprland.enable = true;
    profile = {
      client.enable = true;
      desktop.enable = true;
      monitoring.enable = false;
      virtualisation.enable = true;
    };
    com = {
      nvidiaGPU.enable = true;
      sops.enable = false;
    };
    svc = {
      flatpak.enable = true;
      sync.enable = false;
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
  #     "backup/ssh/local" = {
  #       mode = "0400";
  #       sopsFile = ../../secrets/yggdrasil.yaml;
  #     };
  #     "backup/ssh/remote" = {
  #       mode = "0400";
  #       sopsFile = ../../secrets/yggdrasil.yaml;
  #     };
  #     "backup/keys/local" = {
  #       mode = "0400";
  #       sopsFile = ../../secrets/yggdrasil.yaml;
  #     };
  #     "backup/keys/remote" = {
  #       mode = "0400";
  #       sopsFile = ../../secrets/yggdrasil.yaml;
  #     };
  #   };
  # };
}
