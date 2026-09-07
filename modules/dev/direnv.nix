{self, ...}: {
  flake.nixosModules.direnv = {
    nixpkgs.overlays = [
      (final: prev: {
        direnv = self.packages.${prev.stdenv.hostPlatform.system}.direnv;
      })
    ];
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  flake.homeModules.direnv = {
    nixpkgs.overlays = [
      (final: prev: {
        direnv = self.packages.${prev.stdenv.hostPlatform.system}.direnv;
      })
    ];
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };

  perSystem = {pkgs, ...}: {
    packages.direnv = pkgs.direnv;
  };
}
