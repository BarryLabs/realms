{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "content";
  cfg = config.mods.profile.${module};
in
{
  imports = [
    ../../../home
  ];
  options.mods.profile.${module}.enable = mkEnableOption "Base Content Profile";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ardour
      blender
      libreoffice
      obsidian
      gimp
    ];
  };
}
