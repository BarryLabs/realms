{self, ...}: {
  flake.nixosModules.obsidian = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.obsidian];

    # persistence.data.directories = [
    #   ".config/obsidian"
    # ];
  };

  flake.homeModules.obsidian = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.obsidian];
  };

  perSystem = {pkgs, ...}: {
    packages.obsidian = pkgs.obsidian;
  };
}
