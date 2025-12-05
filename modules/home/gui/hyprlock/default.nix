{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "hyprlock";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "Hyprlock Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprlock
    ];
  };
}
