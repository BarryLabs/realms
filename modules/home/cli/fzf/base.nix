{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.mods.cli.fzf.base;
in
{
  options.mods.cli.fzf.base.enable = mkEnableOption "Base Fzf Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fd
    ];
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      changeDirWidgetCommand = "fd --type d --exclude .git .jj --follow --hidden";
      defaultCommand = "fd --type f --exclude .git --follow --hidden";
      defaultOptions = [
        "--bind 'ctrl-/:toggle-preview'"
        "--preview='bat --color-always -n {}'"
      ];
    };
  };
}
