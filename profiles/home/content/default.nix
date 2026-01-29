{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "content";
  cfg = config.mods.profile.${module};
in
{
  imports = [
    ../../../modules/home
  ];
  options.mods.profile.${module}.enable = mkEnableOption "Content Production Profile";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ardour
      blender
      libreoffice
      gimp
    ];
    mods = {
      tools = {
        obs.enable = true;
        obsidian.enable = true;
      };
    };
  };
}
