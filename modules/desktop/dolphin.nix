{ self, ... }: {
  flake.nixosModules.dolphin = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.dolphin
      self.packages.${pkgs.stdenv.hostPlatform.system}.dolphin-plugins
    ];

    # persistence.data.directories = [
    #   ".config/dolphin-emu"
    #   ".local/share/dolphin-emu"
    # ];
  };

  flake.homeModules.dolphin = { pkgs, ... }: {
    home.packages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.dolphin
      self.packages.${pkgs.stdenv.hostPlatform.system}.dolphin-plugins
    ];
  };

  perSystem = { pkgs, ... }: {
    packages.dolphin = pkgs.kdePackages.dolphin;
    packages.dolphin-plugins = pkgs.kdePackages.dolphin-plugins;
  };
}
