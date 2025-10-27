{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "obs";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "OBS Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".config/obs-studio"
    #   ];
    # };
    programs = {
      obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          input-overlay
          obs-vkcapture
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      };
    };
  };
}
