{self, ...}: {
  flake.nixosModules.starship = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.starship];
  };

  flake.homeModules.starship = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.starship];
  };

  perSystem = {pkgs, ...}: {
    packages.starship = pkgs.starship;
  };
}
