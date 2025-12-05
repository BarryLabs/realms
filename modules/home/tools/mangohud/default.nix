{ config
, lib
, ...
}:
with lib; let
  module = "mangohud";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Mangohud Module";
  config = mkIf cfg.enable {
    programs = {
      mangohud = {
        enable = true;
        enableSessionWide = true;
        settingsPerApplication = {
          mpv = {
            no_display = true;
          };
          zen = {
            no_display = true;
          };
          nautilus = {
            no_display = true;
          };
          xdg-desktop-portal-gnome = {
            no_display = true;
          };
        };
      };
    };
  };
}
