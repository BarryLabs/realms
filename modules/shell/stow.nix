{self, ...}: {
  flake.nixosModules.stow = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.stow];
  };

  flake.homeModules.stow = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.stow];
  };

  perSystem = {pkgs, ...}: {
    packages.stow = pkgs.stow;
  };
}
