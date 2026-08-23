{ self, ... }: {
  flake.nixosModules.kitty = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.kitty ];
  };

  flake.homeModules.kitty = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.kitty ];
  };

  perSystem = { pkgs, ... }: {
    packages.kitty = pkgs.kitty;
  };
}
