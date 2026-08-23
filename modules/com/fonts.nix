{
  flake.nixosModules.fonts = {pkgs, ...}: {
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        nerd-fonts.iosevka
        source-code-pro
      ];
      fontconfig = {
        enable = true;
        useEmbeddedBitmaps = true;
      };
    };
  };
}
