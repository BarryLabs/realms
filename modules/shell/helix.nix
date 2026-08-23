{ self, ... }: {
  flake.nixosModules.helix = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.helix ];
  };

  flake.homeModules.helix = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.helix ];
  };

  perSystem = { pkgs, ... }: {
    packages.helix = pkgs.helix;
  };
}
