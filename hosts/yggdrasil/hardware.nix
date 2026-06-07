{
  flake.nixosModules.yggdrasilHardware = {
    modulesPath,
    config,
    pkgs,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    ### Attached Disks
    fileSystems = {
      "/persist/hdd" = {
        fsType = "xfs";
        device = "/dev/disk/by-uuid/d67c935f-2321-43fa-8135-32915d91f2b4";
      };
    };
    ### Networking
    networking = {
      hostName = config.client.host;
      interfaces = {
        enp5s0 = {
          useDHCP = true;
        };
        enp6s0 = {
          useDHCP = true;
        };
      };
    };
    ### Boot
    boot = {
      kernelPackages = pkgs.linuxPackages_cachyos;
      extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
      kernelModules = [
        "kvm-amd"
        "snd_aloop"
        "v4l2loopback"
      ];
      kernelParams = [
        "slab_nomerge"
        "page_poison=1"
        "debugfs=off"
        "page_alloc.shuffle=1"
      ];
      initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "uas"
        "sd_mod"
      ];
      kernelPatches = [
        {
          name = "Rust Kernel Module";
          patch = null;
          features = {
            rust = true;
          };
        }
      ];
    };
    ### CPU
    hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
    ### GPU
    systemd.services.nvidia-power-limit = {
      description = "Set Power Limit for 3080 to 150 Watt";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/run/current-system/sw/bin/nvidia-smi -pl 150";
      };
    };
    services.xserver.videoDrivers = [
      "nvidia"
    ];
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      nvidia = {
        open = false;
        nvidiaSettings = true;
        modesetting = {
          enable = true;
        };
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
    ### State
    system.stateVersion = config.client.state;
  };
}
