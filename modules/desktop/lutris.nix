{self, ...}: {
  flake.nixosModules.lutris = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.lutris];

    # persistence.data.directores = [
    #   ".config/lutris"
    # ];
  };

  flake.homeModules.lutris = {pkgs, ...}: {
    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    };
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.lutris];
  };

  perSystem = {pkgs, ...}: {
    packages.lutris = pkgs.lutris.override {
      extraPkgs = p: [p.adwaita-icon-theme];
    };
  };
}
