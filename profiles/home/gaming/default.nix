{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "gaming";
  cfg = config.mods.profile.${module};
in
{
  imports = [
    ../../../modules/home
  ];
  options.mods.profile.${module}.enable = mkEnableOption "Gaming Profile";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      runelite
      vesktop
    ];
    mods = {
      tools = {
        gamescope.enable = false;
        lutris.enable = false;
        mangohud.enable = true;
      };
    };
  };
}
