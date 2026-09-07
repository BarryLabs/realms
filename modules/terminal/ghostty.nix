{self, ...}: {
  flake.nixosModules.ghostty = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty];
  };

  flake.homeModules.ghostty = {pkgs, ...}: {
    programs.ghostty = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.ghostty;
      enableZshIntegration = true;
      installVimSyntax = true;
      settings = {
        mouse-hide-while-typing = true;
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.ghostty = pkgs.ghostty;
  };
}
