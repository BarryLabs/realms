{self, ...}: {
  flake.nixosModules.jujutsu = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.jujutsu];
  };

  flake.homeModules.jujutsu = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.jujutsu];
  };

  perSystem = {pkgs, ...}: {
    packages.jujutsu = pkgs.jujutsu;
  };
}
