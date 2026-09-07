{self, ...}: {
  flake.nixosModules.weylus = {pkgs, ...}: {
    programs.weylus = {
      enable = true;
      openFirewall = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.weylus;
    };
    # persistence.data.directories = [
    #   ".config/weylus"
    # ];
  };

  flake.homeModules.weylus = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.weylus];
  };

  perSystem = {pkgs, ...}: {
    packages.weylus = pkgs.weylus;
  };
}
