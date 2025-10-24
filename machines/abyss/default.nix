{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];

  augs = {
    backup.abyss.enable = true;
    sync.base.enable = true;
    com = {
      apparmor.enable = true;
      bootEFI.enable = true;
      bluetooth.enable = true;
      cpu.enable = true;
      environment.enable = true;
      fhb.enable = true;
      fonts.enable = true;
      fstrim.enable = true;
      governor.enable = true;
      hyprlandPortal.enable = true;
      kernel.enable = true;
      locale.enable = true;
      #mac-randomizer.enable = true;
      network.enable = true;
      nix.enable = true;
      nixpkgs.enable = true;
      nvidiaGPU.enable = true;
      openssh.enable = true;
      pam.enable = true;
      pipewire.enable = true;
      podman.enable = true;
      security.enable = true;
      settings.enable = true;
      sops.enable = true;
      state.enable = true;
      sudo-rs.enable = true;
      thermald.enable = true;
      timezone.enable = true;
      udisks.enable = true;
      upgrade.enable = true;
      users.enable = true;
      virt-manager.enable = true;
      waydroid.enable = true;
      xboxController.enable = true;
      xserver.enable = true;
      yubikey.enable = true;
      zram.enable = true;
      zsh.enable = true;
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
