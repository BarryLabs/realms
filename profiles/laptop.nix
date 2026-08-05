{self, ...}: {
  flake.nixosModules.laptop = {
    imports = [
      self.nixosModules.desktop
      self.nixosModules.power
      self.nixosModules.bluetooth
    ];
  };
}
