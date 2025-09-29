{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.mods.terminal.kitty.base;
in
{
  options.mods.terminal.kitty.base.enable = mkEnableOption "Base Kitty Module";
  config = mkIf cfg.enable {
    programs = {
      kitty = {
        enable = true;
        font = {
          size = 10;
          name = "Source Code Pro";
        };
        themeFile = "Catppuccin-Mocha";
        settings = {
          shell = "${pkgs.nushell}/bin/nu";
          #shell = "${pkgs.zsh}/bin/zsh";
          editor = "${pkgs.neovim}/bin/nvim";
          background_image = "none";
          copy_on_select = true;
          cursor_blink_interval = 1;
          confirm_os_window_close = 0;
          disable_ligatures = "cursor";
          dynamic_background_opacity = true;
          enable_audio_bell = false;
          show_hyperlink_targets = "no";
          underline_hyperlinks = "always";
          url_color = "#0087bd";
          url_style = "curly";
          window_padding_width = "6";
        };
      };
    };
  };
}
