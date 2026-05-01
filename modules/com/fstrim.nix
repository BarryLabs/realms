{
  flake.nixosModules.fstrim = {
    services = {
      fstrim = {
        enable = true;
        interval = "weekly";
      };
    };
  };
}
