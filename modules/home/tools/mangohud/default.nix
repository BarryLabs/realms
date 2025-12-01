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
    # home.file."${module}" = {
    #   source = "./MangoHud.conf";
    #   target = ".config/MangoHud/MangoHud.conf";
    # };
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
