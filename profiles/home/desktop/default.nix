{
  config,
  lib,
  ...
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
      tools = {
        easyeffects.enable = true;
        mpv.enable = true;
        thunderbird.enable = true;
        zathura.enable = true;
      };
    };
  };
}
