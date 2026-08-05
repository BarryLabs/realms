{self, ...}: {
  flake.nixosModules.suitesVirtualization = {
    imports = [
      self.nixosModules.podman
      self.nixosModules.virt-manager
      self.nixosModules.waydroid
    ];
  };
}
