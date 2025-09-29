{ config
, lib
, ...
}:
with lib; let
  cfg = config.mods.cli.cava.base;
in
{
  options.mods.cli.cava.base.enable = mkEnableOption "Base Cava Module";
  config = mkIf cfg.enable {
    programs = {
      cava = {
        enable = true;
        settings = {
          general = {
            framerate = 60;
          };
          smoothing.noise_reduction = 88;
          color = {
            background = "'#111111'";
            foreground = "'#33ffff'";
          };
        };
      };
    };
  };
}
