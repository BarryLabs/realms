{ self, ... }: {
  flake.nixosModules.kdeconnect = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.kdeconnect ];

    # persistence.data.directories = [
    #   ".config/kdeconnect"
    # ];
  };

  flake.homeModules.kdeconnect = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.kdeconnect ];
  };

  perSystem = { pkgs, ... }: {
    packages.kdeconnect = pkgs.kdePackages.kdeconnect-kde;
  };
}
