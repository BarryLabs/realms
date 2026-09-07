{self, ...}: {
  flake.nixosModules.brave = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.brave];

    # persistence = {
    #   data.directories = [ ".config/BraveSoftware" ];
    #   cache.directories = [ ".cache/BraveSoftware" ];
    # };
  };

  flake.homeModules.brave = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.brave];
  };

  perSystem = {pkgs, ...}: {
    packages.brave = pkgs.brave;
  };
}
