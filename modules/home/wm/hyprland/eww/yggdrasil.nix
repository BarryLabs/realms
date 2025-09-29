{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.mods.wm.wayland.eww.yggdrasil;
in {
  options.mods.wm.wayland.eww.yggdrasil.enable = mkEnableOption "enable eww module for yggdrasil";
  config = mkIf cfg.enable {
    programs = {
      eww = {
        enable = true;
        configDir = ../../../../../.config/eww;
      };
    };
  };
}
