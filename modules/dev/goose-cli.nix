{self, ...}: {
  flake.nixosModules.goose-cli = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.goose-cli];
  };

  flake.homeModules.goose-cli = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.goose-cli];
  };

  perSystem = {pkgs, ...}: {
    packages.goose-cli = pkgs.goose-cli;
  };
}
