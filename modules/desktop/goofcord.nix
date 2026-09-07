{self, ...}: {
  flake.nixosModules.goofcord = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.goofcord];

    # persistence.data.directories = [
    #   ".config/goofcord"
    # ];
  };

  flake.homeModules.goofcord = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.goofcord];
  };

  perSystem = {pkgs, ...}: {
    packages.goofcord = pkgs.goofcord;
  };
}
