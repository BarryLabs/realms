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
      screen = {
        one = {
          name = "HDMI-A-2";
        };
        two = {
          name = "HDMI-A-1";
        };
      };
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
  augs = {
    backup.yggdrasil.enable = true;
    sync.base.enable = true;
    styles.mocha.enable = true;
    gui.niri.enable = true;
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
  };
  # environment.persistence."/nix/persist" = {
  #   hideMounts = true;
  #   directories = [
  #     "/etc/nixos"
  #     "/etc/ssh"
  #     "/var/lib/nixos"
  #     "/var/lib/systemd/timers"
  #     "/var/lib/systemd/coredump"
  #   ];
  #   files = [
  #     "/etc/machine-id"
  #     "/root/.config/sops/age/keys.txt"
  #   ];
  # };
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
        sopsFile = ../../secrets/yggdrasil.yaml;
      };
      "backup/ssh/remote" = {
        mode = "0400";
        sopsFile = ../../secrets/yggdrasil.yaml;
      };
      "backup/keys/local" = {
        mode = "0400";
        sopsFile = ../../secrets/yggdrasil.yaml;
      };
      "backup/keys/remote" = {
        mode = "0400";
        sopsFile = ../../secrets/yggdrasil.yaml;
      };
    };
  };
}
