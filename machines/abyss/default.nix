{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../profiles/system
    ../../modules/system
  ];
  home-manager.extraSpecialArgs = {
    vars = {
      user = "mamotdask";
    };
  };
  networking = {
    interfaces = {
      enp4s0 = {
        useDHCP = true;
      };
    };
  };
  augs = {
    styles.mocha.enable = true;
    svc.sync-node.enable = true;
    gui.hyprland.enable = true;
    profile = {
      client.enable = true;
      desktop.enable = true;
      monitoring.enable = true;
      virtualisation.enable = true;
    };
    com = {
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
}
