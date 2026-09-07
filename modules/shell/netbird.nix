{self, ...}: {
  flake.nixosModules.netbird = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.netbird];
    services.netbird.enable = true;
  };

  flake.homeModules.netbird = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.netbird];
  };

  perSystem = {pkgs, ...}: {
    packages.netbird = pkgs.netbird-ui;
  };
}
