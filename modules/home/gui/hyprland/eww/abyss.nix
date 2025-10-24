{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.mods.wm.wayland.eww.abyss;
in {
  options.mods.wm.wayland.eww.abyss.enable = mkEnableOption "enable eww module for abyss";
  config = mkIf cfg.enable {
    programs = {
      eww = {
        enable = true;
        configDir = ../../../../../.config/eww;
      };
    };
  };
}
