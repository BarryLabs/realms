{ config
, lib
, ...
}:
with lib; let
  cfg = config.mods.tools.mangohud.base;
in
{
  options.mods.tools.mangohud.base.enable = mkEnableOption "Base Mangohud Module";
  config = mkIf cfg.enable {
    programs = {
      mangohud = {
        enable = true;
        enableSessionWide = true;
        settings = {
          font_scale = 0.60;
          background_alpha = 0.40;
          alpha = 0.70;
        };
        settingsPerApplication = {
          mpv = {
            no_display = true;
          };
          zen = {
            no_display = true;
          };
        };
      };
    };
  };
}
