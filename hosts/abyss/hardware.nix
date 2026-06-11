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
    ### Networking
    users.users.${config.abyss.user}.extraGroups = ["networkmanager"];
    networking = {
      hostName = config.abyss.host;
      interfaces = {
        ### LAN Port
        enp130s0 = {
          useDHCP = true;
        };
      };
      ### Wifi
      networkmanager.enable = true;
    };
    ### Bluetooth
    environment.systemPackages = with pkgs; [
      bluetui
    ];
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    ### Boot
    boot = {
      ### Kernel
      kernelPackages = pkgs.linuxPackages_cachyos;
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
      ### Rust Patches for Fun
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
    ### CPU & NPU
    hardware.cpu.intel = {
      npu.enable = true;
      updateMicrocode = config.hardware.enableRedistributableFirmware;
    };
    ### GPU
    services.xserver.videoDrivers = [
      "modesetting"
      "nvidia"
    ];
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      nvidia = {
        open = true;
        powerManagement = {
          enable = true;
          # finegrained = false;
        };
        prime = {
          intelBusId = "PCI:0@0:2:0";
          nvidiaBusId = "PCI:2@0:0:0";
          sync.enable = true;
          # offload = {
          #   enable = true;
          #   enableOffloadCmd = true;
          # };
        };
      };
    };
    ### State
    system.stateVersion = config.abyss.state;
  };
}
