{ self, ... }: {
  flake.nixosModules.zellij = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.zellij ];
  };

  flake.homeModules.zellij = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.zellij ];
  };

  perSystem = { pkgs, ... }: {
    packages.zellij = pkgs.zellij;
  };
}
