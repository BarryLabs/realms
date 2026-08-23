{ self, ... }: {
  flake.nixosModules.kicad = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.kicad ];
  };

  flake.homeModules.kicad = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.kicad ];
  };

  perSystem = { pkgs, ... }: {
    packages.kicad = pkgs.kicad;
  };
}
