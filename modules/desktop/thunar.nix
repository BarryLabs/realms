{self, ...}: {
  flake.nixosModules.thunar = {pkgs, ...}: {
    nixpkgs.overlays = [
      (final: prev: {
        thunar = self.packages.${prev.stdenv.hostPlatform.system}.thunar;
        xfce = prev.xfce // {thunar = final.thunar;};
      })
    ];

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman];
    };

    # persistence = {
    #   data.directories = [
    #     ".config/Thunar"
    #     ".local/share/Thunar"
    #   ];
    # };
  };

  flake.homeModules.thunar = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.thunar];
  };

  perSystem = {pkgs, ...}: {
    packages.thunar = pkgs.xfce.thunar;
  };
}
