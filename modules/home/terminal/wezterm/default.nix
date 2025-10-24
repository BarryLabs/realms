{ config
, lib
, ...
}:
with lib;
let
  module = "wezterm";
  cfg = config.mods.terminal.${module};
in
{
  options.mods.terminal.${module}.enable = mkEnableOption "Base Wezterm Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".config/wezterm"
    #   ];
    # };
    programs = {
      ${module} = {
        enable = true;
        extraConfig = ''
          local wezterm = require 'wezterm'
          local config = wezterm.config_builder()
          config.initial_cols = 120
          config.initial_rows = 28
          config.font_size = 10
          config.color_scheme = 'catppuccin-mocha'
          config.hide_tab_bar_if_only_one_tab = true
          config.window_close_confirmation = 'NeverPrompt'
          return config 
        '';
      };
    };
  };
}
