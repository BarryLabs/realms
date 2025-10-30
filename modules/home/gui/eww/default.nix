{ config
, lib
, ...
}:
with lib; let
  module = "eww";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "EWW Module";
  config = mkIf cfg.enable {
    programs = {
      eww = {
        enable = true;
        configDir = ../../../../../.config/eww;
      };
    };
  };
}
