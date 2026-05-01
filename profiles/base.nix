{self, ...}: {
  flake.nixosModules.base = {pkgs, ...}: {
    imports = [
      self.nixosModules.locale
      self.nixosModules.network
      self.nixosModules.nh
      self.nixosModules.nix
      self.nixosModules.openssh
      self.nixosModules.settings
      self.nixosModules.timezone
    ];
    environment.systemPackages = with pkgs; [
      git
      htop
    ];
  };
}
