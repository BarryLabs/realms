{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "swaybg";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "SwayBG Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swaybg
    ];
  };
}
