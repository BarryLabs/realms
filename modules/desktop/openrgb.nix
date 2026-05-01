{
  flake.nixosModules.openrgb = {
    services = {
      hardware = {
        openrgb = {
          enable = true;
        };
      };
    };
  };
}
