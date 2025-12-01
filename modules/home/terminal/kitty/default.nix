{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "kitty";
  cfg = config.mods.terminal.${module};
in
{
  options.mods.terminal.${module}.enable = mkEnableOption "Base Kitty Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".config/kitty"
    #   ];
    # };
    programs = {
      ${module} = {
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
