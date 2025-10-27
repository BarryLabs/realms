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
    ../../../home
  ];
  options.mods.profile.${module}.enable = mkEnableOption "Base Desktop Profile";
  config = mkIf cfg.enable {
    mods = {
      browser = {
        firefox.enable = true;
      };
      tools = {
        easyeffects.enable = true;
        freetube.enable = true;
        mpv.enable = true;
        obs.enable = true;
        ollama.enable = true;
        thunderbird.enable = true;
        zathura.enable = true;
      };
    };
  };
}
