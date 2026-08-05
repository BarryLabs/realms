{self, ...}: {
  flake.nixosModules.desktopEnvironment = {
    imports = [
      self.nixosModules.btop
    ];
  };
}
