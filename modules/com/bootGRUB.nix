{
  flake.nixosModules.bootGRUB = {
    boot = {
      loader = {
        timeout = 5;
        grub = {
          enable = true;
          useOSProber = true;
        };
      };
    };
  };
}
