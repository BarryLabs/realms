{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];

  augs = {
    backup.abyss.enable = true;
    sync.base.enable = true;
    styles.mocha.enable = true;
    profile = {
      client.enable = true;
      desktop.enable = true;
      monitoring.enable = true;
      virtualisation.enable = true;
    };
    com = {
      bluetooth.enable = false;
      nvidiaGPU.enable = true;
      sops.enable = true;
      thermald.enable = true;
    };
    programs = {
      appimages.enable = true;
      firejail.enable = true;
      hyprland.enable = true;
      steam.enable = true;
    };
    services = {
      mullvad.enable = true;
      node-exporter.enable = true;
      promtail.enable = true;
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
      bbEvo = {
        mode = "0400";
      };
      borgJob = {
        mode = "0400";
      };
      localEvoEncKey = {
        mode = "0400";
      };
      remoteEvoEncKey = {
        mode = "0400";
      };
    };
  };
}
