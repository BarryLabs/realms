{self, ...}: {
  flake.nixosModules.alvr = {pkgs, ...}: {
    nixpkgs.overlays = [
      (final: prev: {
        alvr = self.packages.${pkgs.stdenv.hostPlatform.system}.alvr;
      })
    ];

    programs.alvr = {
      enable = true;
      openFirewall = true;
    };

    # persistence.data.directories = [
    #   ".config/alvr"
    #   ".local/share/alvr"
    # ];
  };

  flake.homeModules.alvr = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.alvr];
  };

  perSystem = {pkgs, ...}: {
    packages.alvr = pkgs.alvr;
  };
}
