{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "mpv";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "MPV Module";
  config = mkIf cfg.enable {
    programs = {
      mpv = {
        enable = true;
        bindings = {
          "c" = "script-message-to crop start-crop hard";
          "d" = "vf del -1";
          "Alt+c" = "script-message-to crop start-crop soft";
          "l" = "script-message-to crop start-crop delogo";
          "w" = "script-binding modernz/progress-toggle";
          "x" = "script-message-to modernz osc-show";
          "y" = "script-message-to modernz osc-visibility cycle";
          "z" = "script-message-to modernz osc-idlescreen";
        };
        config = {
          profile = "gpu-hq";
          ytdl-format = "bestvideo+bestaudio";
        };
      };
    };
  };
}
