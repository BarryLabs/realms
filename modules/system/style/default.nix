{ config
, lib
, pkgs
, ...
}:
with lib; let
  module = "mocha";
  cfg = config.augs.styles.${module};
in
{
  options.augs.styles.${module}.enable = mkEnableOption "Mocha Style Module";
  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = true;
      image = ../../../.config/styles/catppuccin.png;
      polarity = "dark";
      fonts = rec {
        serif = monospace;
        sansSerif = monospace;
        emoji = monospace;
        monospace = {
          package = pkgs.source-code-pro;
          name = "Source Code Pro";
        };
      };
      opacity =
        let
          opacity = 0.80;
        in
        {
          applications = opacity;
          desktop = opacity;
          popups = opacity;
          terminal = opacity;
        };

      override = {
        scheme = "mocha";
        base00 = "1e1e2e";
        base01 = "181825";
        base02 = "313244";
        base03 = "45475a";
        base04 = "585b70";
        base05 = "cdd6f4";
        base06 = "f5e0dc";
        base07 = "b4befe";
        base08 = "f38ba8";
        base09 = "fab387";
        base0A = "f9e2af";
        base0B = "a6e3a1";
        base0C = "94e2d5";
        base0D = "89b4fa";
        base0E = "cba6f7";
        base0F = "f2cdcd";
        base10 = "232634";
        base11 = "232634";
        base12 = "d20f39";
        base13 = "df8e1d";
        base14 = "40a02b";
        base15 = "04a5e5";
        base16 = "1e66f5";
        base17 = "8839ef";
      };
    };
  };
}
