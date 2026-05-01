{self, ...}: {
  flake.nixosModules.vm = {
    imports = [
      self.nixosModules.base
      self.nixosModules.bash
    ];
  };
}
