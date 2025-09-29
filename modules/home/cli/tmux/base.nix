{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.cli.tmux.base;
in
{
  options.mods.cli.tmux.base.enable = mkEnableOption "Base Tmux Module";
  config = mkIf cfg.enable {
    programs = {
      tmux = {
        enable = true;
        shortcut = "a";
        baseIndex = 1;
        newSession = true;
        escapeTime = 0;
        secureSocket = false;
        extraConfig = ''
          set-option -g mouse on
          set -g default-terminal "xterm-256color"
          set -ga terminal-overrides ",*256col*:Tc"
          set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
          set-environment -g COLORTERM "truecolor"
          bind | split-window -h -c "#{pane_current_path}"
          bind - split-window -v -c "#{pane_current_path}"
          bind c new-window -c "#{pane_current_path}"
        '';
      };
    };
  };
}
