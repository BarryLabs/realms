{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "laptop";
  cfg = config.mods.profile.gui.${module};
in
{
  imports = [
    ../../../home
  ];
  options.mods.profile.gui.${module}.enable = mkEnableOption "Laptop GUI Profile";
  config = mkIf cfg.enable {
    
  };
}
