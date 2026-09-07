{self, ...}: {
  flake.nixosModules.superfile = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.superfile];
  };

  flake.homeModules.superfile = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.superfile];
  };

  perSystem = {pkgs, ...}: {
    packages.superfile = pkgs.superfile;
  };
}
