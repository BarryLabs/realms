{ config
, lib
, ...
}:
with lib;
let
  module = "zathura";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Base Zathura Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".config/zathura"
    #   ];
    # };
    programs = {
      zathura = {
        enable = true;
        mappings = {
          K = "zoom in";
          J = "zoom out";
          r = "reload";
          R = "rotate";
          u = "scroll half-up";
          d = "scroll half-down";
          D = "toggle_page_mode";
          i = "recolor";
          H = "navigate previous";
          L = "navigate next";
          "<Right>" = "navigate next";
          "<Left>" = "navigate previous";
          "<Down>" = "scroll down";
          "<Up>" = "scroll up";
        };
        options = {
          # font = "JetBrainsMono 14";
          adjust-open = "width";
          pages-per-row = 1;
          selection-clipboard = "clipboard";
          incremental-search = true;
          window-title-home-tilde = true;
          window-title-basename = true;
          statusbar-home-tilde = true;
          show-hidden = true;
          statusbar-h-padding = 0;
          statusbar-v-padding = 0;
          page-padding = 1;
          # default-fg = "rgba(205,214,244,1)";
          # default-bg = "rgba(30,30,46,1)";
          # completion-bg = "rgba(49,50,68,1)";
          # completion-fg = "rgba(205,214,244,1)";
          # completion-highlight-bg = "rgba(87,82,104,1)";
          # completion-highlight-fg = "rgba(205,214,244,1)";
          # completion-group-bg = "rgba(49,50,68,1)";
          # completion-group-fg = "rgba(137,180,250,1)";
          # statusbar-fg = "rgba(205,214,244,1)";
          # statusbar-bg = "rgba(49,50,68,1)";
          # notification-bg = "rgba(49,50,68,1)";
          # notification-fg = "rgba(205,214,244,1)";
          # notification-error-bg = "rgba(49,50,68,1)";
          # notification-error-fg = "rgba(243,139,168,1)";
          # notification-warning-bg = "rgba(49,50,68,1)";
          # notification-warning-fg = "rgba(250,227,176,1)";
          # inputbar-fg = "rgba(205,214,244,1)";
          # inputbar-bg = "rgba(49,50,68,1)";
          # recolor = "true";
          # recolor-lightcolor = "rgba(30,30,46,1)";
          # recolor-darkcolor = "rgba(205,214,244,1)";
          # index-fg = "rgba(205,214,244,1)";
          # index-bg = "rgba(30,30,46,1)";
          # index-active-fg = "rgba(205,214,244,1)";
          # index-active-bg = "rgba(49,50,68,1)";
          # render-loading-bg = "rgba(30,30,46,1)";
          # render-loading-fg = "rgba(205,214,244,1)";
          # highlight-color = "rgba(87,82,104,0.5)";
          # highlight-fg = "rgba(245,194,231,0.5)";
          # highlight-active-color = "rgba(245,194,231,0.5)";
        };
      };
    };
  };
}
