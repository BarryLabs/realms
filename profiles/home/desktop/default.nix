{ config
, lib
, ...
}:
with lib;
let
  module = "desktop";
  cfg = config.mods.profile.${module};
in
{
  imports = [
    ../../../modules/home
  ];
  options.mods.profile.${module}.enable = mkEnableOption "Desktop Profile";
  config = mkIf cfg.enable {
    mods = {
      browser = {
        firefox.enable = true;
      };
      tools = {
        easyeffects.enable = true;
        freetube.enable = true;
        mpv.enable = true;
        thunderbird.enable = true;
        zathura.enable = true;
      };
    };
  };
}
