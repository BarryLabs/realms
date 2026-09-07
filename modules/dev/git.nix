{self, ...}: {
  flake.nixosModules.git = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.git];
  };

  flake.homeModules.git = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.git];
  };

  perSystem = {pkgs, ...}: {
    packages.git = pkgs.git;
  };
}
