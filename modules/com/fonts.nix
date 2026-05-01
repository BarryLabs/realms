{
  flake.nixosModules.fonts = {pkgs, ...}: {
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        jetbrains-mono
        source-code-pro
        font-awesome
        openmoji-color
        nerd-font-patcher
        noto-fonts-color-emoji
      ];
      fontconfig = {
        enable = true;
        useEmbeddedBitmaps = true;
      };
    };
  };
}
