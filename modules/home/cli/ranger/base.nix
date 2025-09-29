{ config
, lib
, ...
}:
with lib; let
  cfg = config.mods.cli.ranger.base;
in
{
  options.mods.cli.ranger.base.enable = mkEnableOption "Base Ranger Module";
  config = mkIf cfg.enable {
    programs = {
      ranger = {
        enable = true;
        extraConfig = ''
          set show_hidden true
          set viewmode miller
          set automatically_count_files true
          set vcs_backend_git enabled
          set vcs_msg_length 50
          set preview_images_method kitty
          set colorscheme jungle
          set preview_files true
          set preview_directories true
          set collapse_preview true
          set wrap_plaintext_previews false
          set save_console_history true
          set status_bar_on_top false
          set draw_progress_bar_in_status_bar true
          set draw_borders outline
          set dirname_in_tabs false
          set mouse_enabled true
          set display_size_in_main_column true
          set display_size_in_status_bar true
          set display_free_space_in_status_bar true
          set display_tags_in_all_columns true
          set update_title false
          set shorten_title 3
          set hostname_in_titlebar true
          set tilde_in_titlebar false
          set max_history_size 20
          set max_console_history_size 50
          set padding_right true
        '';
      };
    };
  };
}
