{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.mods.tools.mpv.base;
in
{
  options.mods.tools.mpv.base.enable = mkEnableOption "Base MPV Module";
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
          background-color = "#1e1e2e";
          osd-back-color = "#11111b";
          osd-border-color = "#11111b";
          osd-color = "#cdd6f4";
          osd-shadow-color = "#1e1e2e";
        };
        package = (
          pkgs.mpv-unwrapped.wrapper {
            scripts = with pkgs.mpvScripts; [
              modernz
              memo
              crop
              quality-menu
              sponsorblock
              youtube-chat
            ];
            mpv = pkgs.mpv-unwrapped.override {
              waylandSupport = true;
            };
          }
        );
      };
    };
  };
}
