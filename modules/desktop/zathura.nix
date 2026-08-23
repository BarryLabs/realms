{ self, ... }: {
  flake.nixosModules.zathura = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.zathura ];
    # persistence.data.directories = [
    #   ".config/zathura"
    # ];
  };

  flake.homeModules.zathura = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.zathura ];
  };

  perSystem = { pkgs, ... }: {
    packages.zathura = pkgs.zathura;
  };
}
