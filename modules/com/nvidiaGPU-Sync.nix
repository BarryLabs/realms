{
  flake.nixosModules.nvidiaGPU-Sync = { config, ... }: {
    services.xserver.videoDrivers = [
      "modesetting"
      "nvidia"
    ];
    hardware = {
      graphics = true;
      nvidia = {
        open = false;
        nvidiaSettings = true;
        modesetting.enable = true;
        powerManagement = {
          enable = false;
          finegrained = false;
        };
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        prime = {
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:14:0:0";
          sync.enable = true;
        };
      };
    };
  };
}
