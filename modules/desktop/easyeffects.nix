{self, ...}: {
  flake.nixosModules.easyeffects = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.easyeffects];

    # persistence.data.directories = [
    #   ".config/easyeffects"
    #   ".local/share/easyeffects"
    # ];
  };

  flake.homeModules.easyeffects = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.easyeffects];
  };

  perSystem = {pkgs, ...}: {
    packages.easyeffects = pkgs.easyeffects;
  };
}
