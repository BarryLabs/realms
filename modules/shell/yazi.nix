{self, ...}: {
  flake.nixosModules.yazi = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.yazi];
  };

  flake.homeModules.yazi = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.yazi];
  };

  perSystem = {pkgs, ...}: {
    packages.yazi = pkgs.yazi;
  };
}
