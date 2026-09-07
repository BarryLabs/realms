{self, ...}: {
  flake.nixosModules.localsend = {pkgs, ...}: {
    programs.localsend = {
      enable = true;
      openFirewall = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.localsend;
    };

    # persistence.data.directores = [
    #   ".local/share/org.localsend.localsend_app"
    # ];
  };

  flake.homeModules.localsend = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.localsend];
  };

  perSystem = {pkgs, ...}: {
    packages.localsend = pkgs.localsend;
  };
}
