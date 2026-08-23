{ self, ... }: {
  flake.nixosModules.ranger = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.ranger ];
  };

  flake.homeModules.ranger = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.ranger ];
  };

  perSystem = { pkgs, ... }: {
    packages.ranger = pkgs.ranger;
  };
}
