{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "desktop";
  cfg = config.mods.profile.gui.${module};
in
{
  imports = [
    ../../../home
  ];
  options.mods.profile.gui.${module}.enable = mkEnableOption "Desktop GUI Profile";
  config = mkIf cfg.enable {
    
  };
}
