{ self, ... }: {
  flake.nixosModules.nautilus = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nautilus ];
    services.gvfs.enable = true;

    # persistence.data.directores = [
    #   ".config/nautilus"
    #   ".local/share/nautilus"
    # ];
  };

  flake.homeModules.nautilus = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nautilus ];
  };

  perSystem = { pkgs, ... }: {
    packages.nautilus = pkgs.nautilus;
  };
}
