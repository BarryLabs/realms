{ config
, lib
, ...
}:
with lib; let
  module = "cava";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Cava Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cava
    ];
    #programs = {
    #  ${module} = {
    #    enable = true;
    #    settings = {
    #      general = {
    #        framerate = 60;
    #      };
    #      smoothing.noise_reduction = 88;
    #    };
    #  };
    #};
  };
}
