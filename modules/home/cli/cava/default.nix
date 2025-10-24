{ config
, lib
, ...
}:
with lib; let
  module = "cava";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Base Cava Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
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
