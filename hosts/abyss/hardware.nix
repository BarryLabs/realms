{
  flake.nixosModules.abyssHardware = {
    modulesPath,
    config,
    pkgs,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    networking = {
      hostName = config.abyss.host;
      interfaces = {
        enp5s0 = {
          useDHCP = true;
        };
        enp6s0 = {
          useDHCP = true;
        };
      };
    };
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;
      extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
      kernelModules = [
        "kvm-intel"
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
    # CPU
    hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
    # State
    system.stateVersion = config.abyss.state;
  };
}
