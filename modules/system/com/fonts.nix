{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.com.fonts;
in
{
  options.augs.com.fonts.enable = mkEnableOption "Base Fonts Module";
  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        jetbrains-mono
        source-code-pro
        font-awesome
        openmoji-color
        nerd-font-patcher
        noto-fonts-emoji
      ];
      fontconfig = {
        enable = true;
        useEmbeddedBitmaps = true;
      };
    };
  };
}
