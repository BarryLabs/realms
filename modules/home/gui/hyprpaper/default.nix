{ config
, lib
, pkgs
, vars
, ...
}:
with lib;
let
  module = "hyprpaper";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "Hyprpaper Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprpaper
    ];
  };
}
