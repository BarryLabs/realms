{self, ...}: {
  flake.nixosModules.suitesDevops = {
    imports = [
      self.nixosModules.kubectl
      self.nixosModules.netbird
      self.nixosModules.talosctl
    ];
  };
}
