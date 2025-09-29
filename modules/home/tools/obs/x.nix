{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.mods.tools.obs.x;
in
{
  options.mods.tools.obs.x.enable = mkEnableOption "OBS Module for X";
  config = mkIf cfg.enable {
    programs = {
      obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          input-overlay
          obs-vkcapture
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      };
    };
  };
}
