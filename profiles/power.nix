{self, ...}: {
  flake.nixosModules.power = {
    imports = [
      self.nixosModules.power-profiles
      self.nixosModules.powertop
      self.nixosModules.thermald
    ];
  };
}
