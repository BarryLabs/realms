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
    fileSystems = {
      "/persist/hdd" = {
        fsType = "xfs";
        device = "/dev/disk/by-uuid/d67c935f-2321-43fa-8135-32915d91f2b4";
      };
    };
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
    hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;
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
    system.stateVersion = config.client.state;
  };
}
