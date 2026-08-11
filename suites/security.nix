{self, ...}: {
  flake.nixosModules.suitesSecurity = {
    imports = [
      self.nixosModules.keepassxc
      self.nixosModules.mullvad
      self.nixosModules.protonvpn
    ];
  };
}
