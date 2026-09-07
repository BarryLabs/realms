{self, ...}: {
  flake.nixosModules.nix-ld = {pkgs, ...}: {
    programs.nix-ld = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.nix-ld;
    };
  };

  perSystem = {pkgs, ...}: {
    packages.nix-ld = pkgs.nix-ld;
  };
}
