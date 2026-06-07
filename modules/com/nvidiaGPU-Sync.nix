{
  flake.nixosModules.nvidiaGPU-Sync = {
    services.xserver.videoDrivers = [
      "modesetting"
      "nvidia"
    ];
    hardware = {
      graphics.enable = true;
      nvidia = {
        open = true;
        # nvidiaSettings = true;
        # modesetting.enable = true;
        # powerManagement = {
        #   enable = false;
        #   finegrained = false;
        # };
        prime = {
          intelBusId = "PCI:0@0:2:0";
          nvidiaBusId = "PCI:2@0:0:0";
          sync.enable = true;
        };
      };
    };
  };
}
