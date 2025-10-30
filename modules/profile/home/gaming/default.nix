{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "gaming";
  cfg = config.mods.profile.${module};
in
{
  imports = [
    ../../../home
  ];
  options.mods.profile.${module}.enable = mkEnableOption "Gaming Profile";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      runelite
      vesktop
    ];
    mods = {
      tools = {
        lutris.enable = true;
        mangohud.enable = true;
      };
    };
  };
}
