{ config
, lib
, ...
}:
with lib;
let
  module = "tmux";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Base Tmux Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
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
