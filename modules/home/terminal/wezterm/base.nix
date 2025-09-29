{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.terminal.wezterm.base;
in
{
  options.mods.terminal.wezterm.base.enable = mkEnableOption "Base Wezterm Module";
  config = mkIf cfg.enable {
    programs = {
      wezterm = {
        enable = true;
        extraConfig = ''
          local wezterm = require 'wezterm'
          local config = wezterm.config_builder()

          config.initial_cols = 120
          config.initial_rows = 28
          config.font_size = 10
          config.color_scheme = 'catppuccin-mocha'
          config.hide_tab_bar_if_only_one_tab = true

          return config 
        '';
      };
    };
  };
}
