{self, ...}: {
  flake.nixosModules.virtualisation = {
    imports = [
      self.nixosModules.virt-manager
      self.nixosModules.waydroid
    ];
  };
}
