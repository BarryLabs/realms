{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];

  augs = {
    borg.yggdrasil.enable = true;
    sync.base.enable = true;
    com = {
      apparmor.enable = true;
      bootEFI.enable = true;
      cpu.enable = true;
      environment.enable = true;
      fhb.enable = true;
      fonts.enable = true;
      fstrim.enable = true;
      governor.enable = true;
      hyprlandPortal.enable = true;
      kernel.enable = true;
      locale.enable = true;
      network.enable = true;
      nix.enable = true;
      nixpkgs.enable = true;
      nvidiaGPU.enable = true;
      openssh.enable = true;
      pam.enable = true;
      pipewire.enable = true;
      podman.enable = false;
      settings.enable = true;
      sops.enable = true;
      state.enable = true;
      sudo-rs.enable = true;
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
      alvr.enable = true;
      appimages.enable = true;
      firejail.enable = true;
      hyprland.enable = true;
      localsend.enable = true;
      steam.enable = true;
    };
    services = {
      mullvad.enable = true;
      node-exporter.enable = true;
      openrgb.enable = true;
      promtail.enable = true;
    };
  };
  fileSystems = {
    "/mnt/Storage" = {
      fsType = "ntfs";
      device = "/dev/disk/by-uuid/CC3A7A573A7A3F10";
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
  sops = {
    secrets = {
      "ssh/barrylabs" = {
        mode = "0400";
        sopsFile = ../../secrets/ssh.yaml;
      };
      "ssh/nixfleet" = {
        mode = "0400";
        sopsFile = ../../secrets/ssh.yaml;
      };
      "backup/ssh/local" = {
        mode = "0400";
        sopsFile = ../../secrets/backups/yggdrasil.yaml;
      };
      "backup/ssh/remote_yggdrasil" = {
        mode = "0400";
        sopsFile = ../../secrets/backups/yggdrasil.yaml;
      };
      "backup/keys/local_yggdrasil" = {
        mode = "0400";
        sopsFile = ../../secrets/backups/yggdrasil.yaml;
      };
      "backup/keys/remote_yggdrasil" = {
        mode = "0400";
        sopsFile = ../../secrets/backups/yggdrasil.yaml;
      };
    };
  };
}
