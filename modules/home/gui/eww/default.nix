{ config
, lib
, pkgs
, ...
}:
with lib; let
  module = "eww";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "EWW Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      eww
    ];
  };
}
