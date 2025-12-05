{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "gui";
  cfg = config.mods.profile.${module};
in
{
  imports = [
    ../../../home
  ];
  options.mods.profile.${module}.enable = mkEnableOption "GUI Profile";
  config = mkIf cfg.enable {
    
  };
}
