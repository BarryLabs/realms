{ config
, lib
, ...
}:
with lib; let
  module = "mangohud";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Base Mangohud Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".config/MangoHud"
    #   ];
    # };
    programs = {
      mangohud = {
        enable = true;
        enableSessionWide = true;
        # settings = {
        #   alpha = 0.70;
        #   background_alpha = 0.40;
        #   font_scale = 0.60;
        # };
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
