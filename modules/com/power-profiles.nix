{
  flake.nixosModules.power-profiles = {
    services.power-profiles-daemon.enable = true;
  };
}
