{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
    ../../modules/profile/system
  ];
  home-manager.extraSpecialArgs = {
    vars = {
      user = "mamotdask";
    };
  };
  augs = {
    styles.mocha.enable = true;
    svc.sync.enable = true;
    gui.hyprland.enable = true;
    profile = {
      client.enable = true;
      desktop.enable = true;
      monitoring.enable = true;
      virtualisation.enable = true;
    };
    com = {
      btrfsImpermanent.enable = false;
      bluetooth.enable = true;
      intelGPU.enable = true;
      nvidiaGPU.enable = true;
      sops.enable = true;
      thermald.enable = true;
    };
    svc = {
      flatpak.enable = true;
    };
  };
  networking = {
    interfaces = {
      enp4s0 = {
        useDHCP = true;
      };
    };
  };
  sops = {
    secrets = {
      Nixfleet = {
        mode = "0400";
      };
    };
  };
}
