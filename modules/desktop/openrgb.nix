{ self, ... }: {
  flake.nixosModules.openrgb = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.openrgb ];
    services.hardware.openrgb.enable = true;

    # persistence.data.directories = [
    #   ".config/openrgb"
    # ];
  };

  flake.homeModules.openrgb = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.openrgb ];
  };

  perSystem = { pkgs, ... }: {
    packages.openrgb = pkgs.openrgb;
  };
}
