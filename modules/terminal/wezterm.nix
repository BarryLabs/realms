{self, ...}: {
  flake.nixosModules.wezterm = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.wezterm];
  };

  flake.homeModules.wezterm = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.wezterm];
  };

  perSystem = {pkgs, ...}: {
    packages.wezterm = pkgs.wezterm;
  };
}
